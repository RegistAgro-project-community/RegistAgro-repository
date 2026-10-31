// lib/utils/logger.dart
// Logger centralizado para substituir print() em produção
// Em debug: usa developer.log
// Em produção: envia para Sentry/Crashlytics (sem PII)

import 'dart:developer' as developer;
import 'package:flutter/foundation.dart';

class AppLogger {
  static void debug(String message, {Object? error, StackTrace? stackTrace}) {
    if (kDebugMode) {
      developer.log(message, name: 'RegistAgro', error: error, stackTrace: stackTrace);
    }
  }

  static void info(String message, {Object? error, StackTrace? stackTrace}) {
    if (kDebugMode) {
      developer.log(message, name: 'RegistAgro', level: 800, error: error, stackTrace: stackTrace);
    }
  }

  static void warning(String message, {Object? error, StackTrace? stackTrace}) {
    developer.log(message, name: 'RegistAgro', level: 900, error: error, stackTrace: stackTrace);
  }

  static void error(String message, {Object? error, StackTrace? stackTrace}) {
    developer.log(message, name: 'RegistAgro', level: 1000, error: error, stackTrace: stackTrace);
    // Em produção: enviar para Sentry/Crashlytics (sem PII)
  }

  // Log seguro para erros Dio - NÃO loga response.data, request.data, headers (podem ter PII)
  static void dioError(String message, {Object? error, StackTrace? stackTrace}) {
    developer.log(
      message,
      name: 'RegistAgro-Dio',
      level: 1000,
      error: error,
      stackTrace: stackTrace,
    );
  }

  static void dioErrorDetails({
    required String path,
    required String method,
    int? statusCode,
    required String type,
  }) {
    if (kDebugMode) {
      developer.log(
        '[DioError] $method $path ${statusCode ?? 'N/A'} $type',
        name: 'RegistAgro-Dio',
        level: 1000,
      );
    }
  }
}