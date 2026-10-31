import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:projecto_registagro/config/api_config.dart';
import 'package:projecto_registagro/config/dio_client.dart';
import 'package:projecto_registagro/Models/product_ep/product_modals_ep.dart';
import 'package:projecto_registagro/utils/logger.dart';
import 'package:projecto_registagro/utils/safe_notification.dart';
import 'package:projecto_registagro/view/auth/loginScreen/login.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProductsRepositories {
  final Dio _dio = DioClient().dio;

  Future<List<DataKeys>> getProducts(
    BuildContext context, {
    bool showLoading = true,
  }) async {
    if (showLoading) {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) => const Center(child: CircularProgressIndicator()),
      );
    }

    try {
      final response = await _dio.get(ApiConfig.consumerProducts);

      if (showLoading && context.mounted) {
        Navigator.of(context, rootNavigator: true).pop();
      }

      final json = response.data as Map<String, dynamic>? ?? {};
      final List<dynamic> items = json['data'] as List<dynamic>? ?? [];

      return items
          .map((item) => DataKeys.fromJson(item as Map<String, dynamic>))
          .toList();
    } on DioException catch (e) {
      if (showLoading && context.mounted) {
        Navigator.of(context, rootNavigator: true).pop();
      }

      _handleDioError(context, e);
      throw Exception(_getErrorMessage(e));
    } catch (e, stackTrace) {
      if (showLoading && context.mounted) {
        Navigator.of(context, rootNavigator: true).pop();
      }

      AppLogger.error('Erro inesperado ao buscar produtos', error: e, stackTrace: stackTrace);
      if (context.mounted) {
        handleAuthError(context, 'Ocorreu um erro inesperado');
      }

      rethrow;
    }
  }

  Future<FarmPorducts> getFarmProducts(
    BuildContext context,
    String farmId,
  ) async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => const Center(child: CircularProgressIndicator()),
    );

    try {
      final res = await _dio.get(
        '${ApiConfig.farmProducts}/$farmId',
      );

      Navigator.of(context, rootNavigator: true).pop();

      final Map<String, dynamic> json = res.data as Map<String, dynamic>? ?? {};
      final Map<String, dynamic> items =
          json['data'] as Map<String, dynamic>? ?? {};

      final farmProducts = FarmPorducts.fromJson(items);

      return farmProducts;
    } on DioException catch (e) {
      Navigator.of(context, rootNavigator: true).pop();

      _handleDioError(context, e);
      throw Exception(_getErrorMessage(e));
    } catch (e, stackTrace) {
      Navigator.of(context, rootNavigator: true).pop();

      AppLogger.error('Erro inesperado ao buscar produtos da fazenda', error: e, stackTrace: stackTrace);
      if (context.mounted) {
        handleAuthError(context, 'Ocorreu um erro inesperado');
      }

      rethrow;
    }
  }

  void _handleDioError(BuildContext context, DioException e) {
    final statusCode = e.response?.statusCode;

    if (statusCode == 401 || statusCode == 403) {
      final message = e.response?.data?['error'] ?? 'Sessão expirada';
      if (context.mounted) {
        handleAuthError(context, message);
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
      AppLogger.dioError('Erro ao buscar produtos', error: e);
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

  void handleAuthError(BuildContext context, String message) {
    showSafeWarningNotification(
      context,
      title: 'Erro',
      description: message,
    );

    SharedPreferences.getInstance().then((prefs) {
      prefs.setString('last_route', '/');
    });

    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => Login()),
      (route) => false,
    );
  }
}
