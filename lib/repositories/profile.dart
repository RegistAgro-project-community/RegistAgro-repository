import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:projecto_registagro/config/api_config.dart';
import 'package:projecto_registagro/config/dio_client.dart';
import 'package:projecto_registagro/repositories/products.dart';
import 'package:projecto_registagro/repositories/storage.dart';
import 'package:projecto_registagro/utils/logger.dart';
import 'package:projecto_registagro/utils/safe_notification.dart';
import 'package:projecto_registagro/view/auth/homeScreen/homescreen.dart';
import 'package:projecto_registagro/view/pages/userProfile/userModal/user_modal.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Profile {
  final Dio _dio = DioClient().dio;

  Future<void> logout(BuildContext context) async {
    final tokenClass = TokenStorage();
    final logoutResult = await tokenClass.logout();

    if (!context.mounted) return;

    if (logoutResult.containsKey('message')) {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext dialogContext) {
          return const Center(
            child: CircularProgressIndicator(
              color: Colors.white,
              strokeWidth: 2,
            ),
          );
        },
      );

      await Future.delayed(const Duration(milliseconds: 1000));

      if (!context.mounted) return;

      showSafeSuccessNotification(
        context,
        title: 'Sucesso',
        description: 'Sessão terminada com sucesso',
      );

      final prefes = await SharedPreferences.getInstance();
      prefes.setString('last_route', '/');

      if (!context.mounted) return;
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => Homescreen()),
        (route) => false,
      );
    } else {
      showSafeWarningNotification(
        context,
        title: 'Erro',
        description: 'Não foi possível terminar sessão',
      );
    }
  }

  Future<UserModel> userData(BuildContext context, {bool showLoading = true}) async {
    if (showLoading) {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) => const Center(
          child: CircularProgressIndicator(
            color: Colors.white,
            strokeWidth: 2,
          ),
        ),
      );
    }

    try {
      final res = await _dio.get(ApiConfig.userProfile);

      if (showLoading && context.mounted) {
        Navigator.of(context).pop();
      }

      final data = res.data['data'];

      return UserModel(
        name: data['name'],
        email: data['email'],
        phone: data['phone'],
        bio: 'bio',
        province: data['province'],
        adress: data['adress'],
        photoPath: data['profile'],
      );
    } on DioException catch (e) {
      if (showLoading && context.mounted) {
        Navigator.of(context, rootNavigator: true).pop();
      }

      _handleDioError(context, e);
      throw Exception(_getErrorMessage(e));
    } catch (e, stackTrace) {
      if (showLoading && context.mounted) {
        Navigator.of(context).pop();
      }

      AppLogger.error('Erro inesperado ao buscar perfil', error: e, stackTrace: stackTrace);
      if (context.mounted) {
        ProductsRepositories().handleAuthError(context, 'Ocorreu um erro inesperado');
      }

      throw Exception('Error');
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
      AppLogger.dioError('Erro ao buscar perfil', error: e);
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
