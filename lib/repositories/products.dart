import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:projecto_registagro/Models/product_ep/product_modals_ep.dart';
import 'package:projecto_registagro/components/TopNotifications/top_notification.dart';
import 'package:projecto_registagro/repositories/storage.dart';
import 'package:projecto_registagro/view/auth/loginScreen/login.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProductsRepositories {
  Future<List<DataKeys>> getProducts(BuildContext context) async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => const Center(child: CircularProgressIndicator()),
    );

    try {
      final tokenMap = await TokenStorage().readToken();

      if (tokenMap.containsKey("error") || tokenMap["token"] == null) {
        handleAuthError(context, tokenMap["error"] ?? "Faça login novamente");
        throw Exception("Não autenticado");
      }

      final dio = Dio(
        BaseOptions(
          headers: {
            'Content-Type': 'application/json',
            'authorization': "Bearer ${tokenMap['token']}",
          },
        ),
      );

      final response = await dio.get(
        'https://api-registagro.onrender.com/products/consumers/get/products',
      );

      Navigator.of(context, rootNavigator: true).pop();

      final json = response.data as Map<String, dynamic>? ?? {};
      final List<dynamic> items = json['data'] as List<dynamic>? ?? [];

      return items
          .map((item) => DataKeys.fromJson(item as Map<String, dynamic>))
          .toList();
    } on DioException catch (e) {
      Navigator.of(context, rootNavigator: true).pop();

      String message = "Erro ao carregar produtos";

      if (e.response?.statusCode == 401 || e.response?.statusCode == 403) {
        message = e.response?.data?['error'] ?? 'Sessão expirada';

        handleAuthError(context, message);
      } else {
        message =
            e.response?.data?['error'] ??
            e.response?.data?['info'] ??
            e.message ??
            message;

        showTopNotification(
          context,
          title: "Error",
          description: message,
          backgroundColor: Colors.red.shade700,
          icon: Icons.error_outline,
        );
      }

      throw Exception(message);
    } catch (e) {
      Navigator.of(context, rootNavigator: true).pop();

      showTopNotification(
        context,
        title: "Error",
        description: "Ocorreu um erro inesperado",
        backgroundColor: Colors.amber,
        icon: Icons.error_outline,
      );

      rethrow;
    }
  }

  void handleAuthError(BuildContext context, String message) {
    showTopNotification(
      context,
      title: "Error",
      description: message,
      backgroundColor: Colors.amber,
      icon: Icons.error_outline,
    );

    SharedPreferences.getInstance().then((prefs) {
      prefs.setString("last_route", '/');
    });

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const Login())
    );
  }
}
