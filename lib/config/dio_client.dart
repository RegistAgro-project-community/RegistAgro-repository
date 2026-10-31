// lib/config/dio_client.dart
// Dio singleton com interceptors: token auto, error sanitizado, retry com backoff
// Retry manual implementado sem dio_retry para evitar dependência extra

import 'dart:developer' as developer;
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:projecto_registagro/config/api_config.dart';
import 'package:projecto_registagro/repositories/storage.dart';
import 'package:projecto_registagro/utils/logger.dart';

class DioClient {
  static final DioClient _instance = DioClient._internal();
  factory DioClient() => _instance;
  DioClient._internal();

  late final Dio _dio;
  bool _initialized = false;

  Dio get dio => _dio;

  Future<void> init() async {
    if (_initialized) return;

    _dio = Dio(BaseOptions(
      baseUrl: ApiConfig.baseUrl,
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 30),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Accept-Encoding': 'gzip, deflate, br',
        'Connection': 'keep-alive',
      },
    ));

    // Interceptor request - anexa token automaticamente
    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) async {
        options.extra['startTime'] = DateTime.now();
        
        final tokenMap = await TokenStorage().readToken();
        if (!tokenMap.containsKey('error') && tokenMap['token'] != null) {
          options.headers['Authorization'] = 'Bearer ${tokenMap['token']}';
        }
        return handler.next(options);
      },
      onError: (error, handler) async {
        // Sanitizar erro - NÃO loga error.response.data (pode ter PII)
        if (error.response?.statusCode == 401) {
          await TokenStorage().logout();
          // Navegação para login será tratada pelo chamador
        }
        
        // Log seguro para auditoria
        AppLogger.dioErrorDetails(
          path: error.requestOptions.path,
          method: error.requestOptions.method,
          statusCode: error.response?.statusCode,
          type: error.type.name,
        );
        
        return handler.next(error);
      },
      onResponse: (response, handler) {
        if (kDebugMode) {
          final startTime = response.requestOptions.extra['startTime'] as DateTime?;
          if (startTime != null) {
            final latency = DateTime.now().difference(startTime);
            developer.log(
              '[DioPerf] ${response.requestOptions.method} ${response.requestOptions.path} ${latency.inMilliseconds}ms',
              name: 'RegistAgro-Perf',
            );
          }
        }
        return handler.next(response);
      },
    ));

    // Retry manual com backoff exponencial (sem dio_retry)
    _dio.interceptors.add(InterceptorsWrapper(
      onError: (error, handler) async {
        if (_shouldRetry(error) && error.requestOptions.extra['retryCount'] == null) {
          error.requestOptions.extra['retryCount'] = 0;
        }
        
        final retryCount = error.requestOptions.extra['retryCount'] as int? ?? 0;
        if (_shouldRetry(error) && retryCount < 3) {
          final delays = [
            const Duration(seconds: 1),
            const Duration(seconds: 3),
            const Duration(seconds: 10),
          ];
          
          await Future.delayed(delays[retryCount]);
          error.requestOptions.extra['retryCount'] = retryCount + 1;
          
          try {
            final response = await _dio.fetch(error.requestOptions);
            return handler.resolve(response);
          } catch (e) {
            return handler.next(error);
          }
        }
        
        return handler.next(error);
      },
    ));

    _initialized = true;
  }

  bool _shouldRetry(DioException error) {
    return error.response?.statusCode == 503 ||
           error.response?.statusCode == 429 ||
           error.type == DioExceptionType.connectionTimeout ||
           error.type == DioExceptionType.receiveTimeout ||
           error.type == DioExceptionType.sendTimeout;
  }
}