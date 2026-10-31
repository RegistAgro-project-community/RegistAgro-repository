import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:projecto_registagro/config/api_config.dart';
import 'package:projecto_registagro/config/dio_client.dart';
import 'package:projecto_registagro/repositories/products.dart';
import 'package:projecto_registagro/utils/logger.dart';
import 'package:projecto_registagro/utils/safe_notification.dart';

class PaymentRepo {
  final Dio _dio = DioClient().dio;

  Future<String> getReference(
    BuildContext context,
    String farmId,
    String product,
    int qtd,
    String unit,
    String delivery,
  ) async {
    try {
      final response = await _dio.post(
        '${ApiConfig.createOrder}/$farmId',
        data: {
          'name': product,
          'qtd': qtd,
          'unit': unit,
          'delivery': delivery.isEmpty ? null : delivery,
        },
      );

      final String reference = response.data['reference'] as String? ?? '';

      if (reference.isEmpty) {
        throw Exception('Referência não gerada');
      }

      return reference;
    } on DioException catch (e) {
      _handleDioError(context, e);
      throw Exception(_getErrorMessage(e));
    } catch (e, stackTrace) {
      AppLogger.error('Erro inesperado ao gerar referência', error: e, stackTrace: stackTrace);
      if (context.mounted) {
        showSafeNotification(
          context,
          title: 'Erro',
          description: 'Ocorreu um erro inesperado',
          backgroundColor: Colors.red.shade700,
          icon: Icons.error_outline,
        );
      }
      throw Exception('Ocorreu um erro inesperado');
    }
  }

  Future<String> pay(BuildContext context, String reference) async {
    try {
      final response = await _dio.patch(
        ApiConfig.paymentConfirm,
        data: {'reference': reference},
      );

      final String message = response.data['message'] as String? ?? 'Pagamento confirmado';

      return message;
    } on DioException catch (e) {
      _handleDioError(context, e);
      throw Exception(_getErrorMessage(e));
    } catch (e, stackTrace) {
      AppLogger.error('Erro inesperado ao confirmar pagamento', error: e, stackTrace: stackTrace);
      if (context.mounted) {
        showSafeNotification(
          context,
          title: 'Erro',
          description: 'Ocorreu um erro inesperado',
          backgroundColor: Colors.red.shade700,
          icon: Icons.error_outline,
        );
      }
      throw Exception('Ocorreu um erro inesperado');
    }
  }

  void _handleDioError(BuildContext context, DioException e) {
    final statusCode = e.response?.statusCode;

    if (statusCode == 401 || statusCode == 403) {
      final message = e.response?.data?['error'] ?? 'Sessão expirada';
      if (context.mounted) {
        ProductsRepositories().handleAuthError(context, message);
      }
    } else {
      final message = _getErrorMessage(e);
      if (context.mounted) {
        showSafeNotification(
          context,
          title: 'Erro',
          description: message,
          backgroundColor: Colors.red.shade700,
          icon: Icons.error_outline,
        );
      }
      AppLogger.dioError('Erro no pagamento', error: e);
    }
  }

  String _getErrorMessage(DioException e) {
    final statusCode = e.response?.statusCode;

    if (statusCode == 401) return 'Sessão expirada. Faça login novamente';
    if (statusCode == 403) return 'Acesso negado';
    if (statusCode == 404) return e.response?.data?['info'] ?? 'Não encontrado';
    if (statusCode == 429) return 'Muitas tentativas. Tente novamente mais tarde';
    if (statusCode == 500) return 'Erro no servidor. Tente novamente mais tarde';
    if (e.type == DioExceptionType.connectionTimeout ||
        e.type == DioExceptionType.receiveTimeout) {
      return 'Tempo de conexão esgotado. Verifique sua internet';
    }
    if (e.type == DioExceptionType.connectionError) {
      return 'Erro de conexão. Verifique sua internet';
    }
    return 'Ocorreu um erro inesperado';
  }
}
