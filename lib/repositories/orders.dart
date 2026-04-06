import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:projecto_registagro/components/TopNotifications/top_notification.dart';
import 'package:projecto_registagro/repositories/products.dart';
import 'package:projecto_registagro/repositories/storage.dart';
import 'package:projecto_registagro/view/pages/MyOrders/ObjectListOrders/object_data.dart';

class OrdersRepositories {
  Future<List<Order>> getOrders(BuildContext context) async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => const Center(
        child: CircularProgressIndicator(
          color: Colors.white,
          strokeWidth: 2,
        )
      ),
    );

    try {
      final tokenMap = await TokenStorage().readToken();

      if (tokenMap.containsKey("error") || tokenMap["token"] == null) {
        ProductsRepositories().handleAuthError(
          context,
          tokenMap['error'] ?? "Faça login novamente",
        );

        throw Exception("Não autenticado");
      }

      final dio = Dio(
        BaseOptions(
          headers: {
            "Content-Type": "application/json",
            "authorization": "Bearer ${tokenMap["token"]}",
          },
        ),
      );

      final response = await dio.get(
        'https://api-registagro.onrender.com/orders/consumers/order/sent',
      );

      Navigator.of(context).pop();

      final json = response.data as Map<String, dynamic>? ?? {};
      final List<dynamic> orders = json['orders'] as List<dynamic>;

      return orders
          .map((key) => Order.fromJson(key as Map<String, dynamic>))
          .toList();
    } on DioException catch (e) {
      Navigator.of(context).pop();

      String message = "";

      if (e.response?.statusCode == 401 ||
          e.response?.statusCode == 403 ||
          e.response?.statusCode == 500) {
        message = e.response?.data["error"] ?? "Sessão expirada";

        ProductsRepositories().handleAuthError(context, message);
      } else if (e.response?.statusCode == 404) {
        message = e.response?.data["info"];

        throw Exception(message);
      } else {
        message = e.response?.data["error"] ?? "Ocorreu um erro inesperado";

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
      Navigator.of(context).pop();

      ProductsRepositories().handleAuthError(
        context,
        "Ocorreu um erro inesperado",
      );

      rethrow;
    }
  }
}
