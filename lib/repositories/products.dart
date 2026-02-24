import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:projecto_registagro/Models/product_ep/product_modals_ep.dart';
import 'package:projecto_registagro/components/TopNotifications/top_notification.dart';
import 'package:projecto_registagro/repositories/storage.dart';
import 'package:projecto_registagro/view/auth/loginScreen/login.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProductsRepositories {
  getProducts(BuildContext context) async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext dialogContext) {
        return const Center(child: CircularProgressIndicator());
      },
    );

    final tokenClass = TokenStorage();
    final token = await tokenClass.readToken();

    if (token.containsKey('error') || token['token'] == null) {
      if (context.mounted) Navigator.of(context).pop();

      if (!context.mounted) return;

      showTopNotification(
        context,
        title: "Failed",
        description: token['error'] ?? "Ocorreu um erro inesperado. Faça Login",
        backgroundColor: Colors.amber,
        icon: Icons.error_outline,
      );

      if (!context.mounted) return;
      Navigator.pushReplacement(
        context,
        PageTransition(type: PageTransitionType.rightToLeft, child: Login()),
      );
    }

    final dio = Dio(
      BaseOptions(
        headers: {
          'Content-Type': 'application/json',
          'authorization': "Bearer ${token['token']}",
        },
      ),
    );

    try {
      final products = await dio.get(
        'https://api-registagro.onrender.com/products/consumers/get/products',
      );

      if (context.mounted) Navigator.of(context).pop();

      final Map<String, dynamic> data = products.data;
      final List<dynamic> productsList = data['data'];

      final List<Product> productsData = productsList
          .map((item) => Product.fromJson(item as Map<String, dynamic>))
          .toList();

      return productsData;
    } on DioException catch (e) {
      var message = e.response?.data;

      switch (e.response?.statusCode) {
        case 401 || 403:
          message = message['error'];

          if (context.mounted) Navigator.of(context).pop();

          if (!context.mounted) return;
          showTopNotification(
            context,
            title: "Error",
            description: message,
            backgroundColor: Colors.amber,
            icon: Icons.error_outline,
          );

          final prefes = await SharedPreferences.getInstance();
          prefes.setString("last_route", '/');

          Navigator.pushReplacement(
            context,
            PageTransition(
              type: PageTransitionType.leftToRight,
              child: Login(),
              duration: Duration(milliseconds: 350),
            ),
          );

          break;
        default:
          message = message['error'] ?? message['info'];
          break;
      }

      if (context.mounted) Navigator.of(context).pop();

      return message;
    }
  }
}
