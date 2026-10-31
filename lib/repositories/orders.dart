import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:projecto_registagro/config/api_config.dart';
import 'package:projecto_registagro/config/dio_client.dart';
import 'package:projecto_registagro/repositories/products.dart';
import 'package:projecto_registagro/utils/logger.dart';
import 'package:projecto_registagro/utils/safe_notification.dart';
import 'package:projecto_registagro/view/pages/MyOrders/ObjectListOrders/object_data.dart';

class OrdersRepositories {
  final Dio _dio = DioClient().dio;

  Future<List<Order>> getOrders(BuildContext context, {bool showLoading = true}) async {
    if (showLoading) {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) => const Center(
          child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2),
        ),
      );
    }

    try {
      final response = await _dio.get(ApiConfig.consumerOrders);

      if (showLoading && context.mounted) {
        Navigator.of(context).pop();
      }

      final json = response.data as Map<String, dynamic>? ?? {};
      final List<dynamic> orders = json['orders'] as List<dynamic>;

      return orders
          .map((key) => Order.fromJson(key as Map<String, dynamic>))
          .toList();
    } on DioException catch (e) {
      if (showLoading && context.mounted) {
        Navigator.of(context).pop();
      }

      _handleDioError(context, e, showLoading);
      throw Exception(_getErrorMessage(e));
    } catch (e, stackTrace) {
      if (showLoading && context.mounted) {
        Navigator.of(context).pop();
      }

      AppLogger.error('Erro inesperado ao buscar pedidos', error: e, stackTrace: stackTrace);
      if (context.mounted) {
        ProductsRepositories().handleAuthError(context, 'Ocorreu um erro inesperado');
      }
      rethrow;
    }
  }

  Future<String> confirmOrder(BuildContext context, String orderId) async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => const Center(
        child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2),
      ),
    );

    try {
      final res = await _dio.put(
        '${ApiConfig.consumerCompleteOrder}/$orderId',
      );

      Navigator.of(context).pop();

      final json = res.data as Map<String, dynamic>? ?? {};
      final String message = json['message'] as String? ?? 'Pedido confirmado';

      return message;
    } on DioException catch (e) {
      Navigator.of(context).pop();
      _handleDioError(context, e, false);
      throw Exception(_getErrorMessage(e));
    } catch (e, stackTrace) {
      Navigator.of(context).pop();
      AppLogger.error('Erro inesperado ao confirmar pedido', error: e, stackTrace: stackTrace);
      if (context.mounted) {
        ProductsRepositories().handleAuthError(context, 'Ocorreu um erro inesperado');
      }
      rethrow;
    }
  }

  Future<String> cancelOrder(BuildContext context, String orderId) async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => const Center(
        child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2),
      ),
    );

    try {
      final res = await _dio.patch(
        '${ApiConfig.cancelOrder}/$orderId',
      );

      Navigator.of(context).pop();

      final json = res.data as Map<String, dynamic>? ?? {};
      final String message = json['message'] as String? ?? 'Pedido cancelado';

      return message;
    } on DioException catch (e) {
      Navigator.of(context).pop();
      _handleDioError(context, e, false);
      throw Exception(_getErrorMessage(e));
    } catch (e, stackTrace) {
      Navigator.of(context).pop();
      AppLogger.error('Erro inesperado ao cancelar pedido', error: e, stackTrace: stackTrace);
      if (context.mounted) {
        ProductsRepositories().handleAuthError(context, 'Ocorreu um erro inesperado');
      }
      rethrow;
    }
  }

  Future<String> updateOrder(BuildContext context, String orderId, Map<String, dynamic> data) async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => const Center(
        child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2),
      ),
    );

    try {
      final res = await _dio.put(
        '${ApiConfig.updateOrder}/$orderId',
        data: data,
      );

      Navigator.of(context).pop();

      final json = res.data as Map<String, dynamic>? ?? {};
      final String message = json['message'] as String? ?? 'Pedido atualizado';

      return message;
    } on DioException catch (e) {
      Navigator.of(context).pop();
      _handleDioError(context, e, false);
      throw Exception(_getErrorMessage(e));
    } catch (e, stackTrace) {
      Navigator.of(context).pop();
      AppLogger.error('Erro inesperado ao atualizar pedido', error: e, stackTrace: stackTrace);
      if (context.mounted) {
        ProductsRepositories().handleAuthError(context, 'Ocorreu um erro inesperado');
      }
      rethrow;
    }
  }

  Future<String> deleteOrder(BuildContext context, String orderId) async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => const Center(
        child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2),
      ),
    );

    try {
      final res = await _dio.delete(
        '${ApiConfig.deleteOrder}/$orderId',
      );

      Navigator.of(context).pop();

      final json = res.data as Map<String, dynamic>? ?? {};
      final String message = json['message'] as String? ?? 'Pedido apagado';

      return message;
    } on DioException catch (e) {
      Navigator.of(context).pop();
      _handleDioError(context, e, false);
      throw Exception(_getErrorMessage(e));
    } catch (e, stackTrace) {
      Navigator.of(context).pop();
      AppLogger.error('Erro inesperado ao apagar pedido', error: e, stackTrace: stackTrace);
      if (context.mounted) {
        ProductsRepositories().handleAuthError(context, 'Ocorreu um erro inesperado');
      }
      rethrow;
    }
  }

  void _handleDioError(BuildContext context, DioException e, bool showLoading) {
    final statusCode = e.response?.statusCode;

    if (statusCode == 401 || statusCode == 403) {
      final message = e.response?.data?['error'] ?? 'Sessão expirada';
      if (context.mounted) {
        ProductsRepositories().handleAuthError(context, message);
      }
    } else if (statusCode == 404) {
      // 404 é tratado pelo chamador
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
      AppLogger.dioError('Erro ao buscar pedidos', error: e);
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
