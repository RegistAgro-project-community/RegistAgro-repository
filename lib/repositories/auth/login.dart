import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:projecto_registagro/config/api_config.dart';
import 'package:projecto_registagro/config/dio_client.dart';
import 'package:projecto_registagro/repositories/storage.dart';
import 'package:projecto_registagro/utils/logger.dart';

Future<Map<String, String>> login(
  BuildContext context,
  String email,
  String password,
  String? captchaToken,
) async {
  final dio = DioClient().dio;
  final storeToken = TokenStorage();

  final data = {'email': email, 'password': password, 'captchaToken': captchaToken};

  try {
    final res = await dio.post(
      ApiConfig.consumerLogin,
      data: data,
    );

    final authHeader = res.headers.value('authorization');
    final token = authHeader?.split(' ')[1];

    if (token == null) {
      return {'error': 'Token não recebido do servidor'};
    }

    final stored = await storeToken.storeToken(token);

    if (stored) {
      return {'message': res.data['message'] ?? 'Login realizado com sucesso'};
    }

    return {'error': 'Não foi possível salvar o token'};
  } on DioException catch (e) {
    AppLogger.dioError('Erro no login', error: e);

    String errorMessage;
    final statusCode = e.response?.statusCode;

    if (statusCode == 401) {
      errorMessage = 'Email ou senha incorretos';
    } else if (statusCode == 403) {
      errorMessage = 'Acesso negado';
    } else if (statusCode == 429) {
      errorMessage = 'Muitas tentativas. Tente novamente mais tarde';
    } else if (statusCode == 500) {
      errorMessage = 'Erro no servidor. Tente novamente mais tarde';
    } else if (e.type == DioExceptionType.connectionTimeout ||
               e.type == DioExceptionType.receiveTimeout) {
      errorMessage = 'Tempo de conexão esgotado. Verifique sua internet';
    } else if (e.type == DioExceptionType.connectionError) {
      errorMessage = 'Erro de conexão. Verifique sua internet';
    } else {
      errorMessage = 'Ocorreu um erro ao fazer login';
    }

    return {'error': errorMessage};
  } catch (e, stackTrace) {
    AppLogger.error('Erro inesperado no login', error: e, stackTrace: stackTrace);
    return {'error': 'Ocorreu um erro inesperado'};
  }
}
