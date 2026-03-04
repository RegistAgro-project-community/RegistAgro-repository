import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:projecto_registagro/repositories/products.dart';
import 'package:projecto_registagro/repositories/storage.dart';

class PaymentRepo {
  Future<String> getReference(
    BuildContext context,
    String farmId,
    String product,
    int qtd,
    String unit,
  ) async {
    try {
      final token = await TokenStorage().readToken();

      if (token.containsKey("error") || token["token"] == null) {
        final message = token["error"] ?? "Faça login novamente";

        ProductsRepositories().handleAuthError(context, message);
      }

      final dio = Dio(
        BaseOptions(
          headers: {
            'Content-Type': 'application/json',
            'authorization': "Bearer ${token['token']}",
          },
        ),
      );

      final response = await dio.post(
        "https://api-registagro.onrender.com/orders/create/farm/$farmId",
        data: {"name": product, "qtd": qtd, "unit": unit},
      );

      final String reference = response.data['reference'];

      return reference;
    } on DioException catch (e) {
      String message = "Ocorreu um erro ao gerar referência";

      if (e.response?.statusCode == 401 ||
          e.response?.statusCode == 403 ||
          e.response?.statusCode == 500) {
        message = e.response?.data?['error'] ?? 'Sessão expirada';

        ProductsRepositories().handleAuthError(context, message);
      } else {
        message =
            e.response?.data?['error'] ??
            e.response?.data?['info'] ??
            e.message ??
            message;
      }

      throw Exception(message);
    } catch (e) {
      throw Exception("Ocorreu um erro inesperado");
    }
  }

  Future<String> pay(BuildContext context, String reference) async {
    try {
      final tokenMap = await TokenStorage().readToken();

      if (tokenMap.containsKey("error") || tokenMap["token"] == null) {
        ProductsRepositories().handleAuthError(
          context,
          tokenMap["error"] ?? "Faça login novamente",
        );
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

      final response = await dio.patch(
        "https://api-registagro.onrender.com/orders/payment/confirm",
        data: {"reference": reference},
      );

      final String message = response.data["message"];

      return message;
    } on DioException catch (e) {
      String message = "Ocorreu um erro ao gerar referência";

      if (e.response?.statusCode == 401 ||
          e.response?.statusCode == 403 ||
          e.response?.statusCode == 500) {
        message = e.response?.data?['error'] ?? 'Sessão expirada';

        ProductsRepositories().handleAuthError(context, message);
      } else {
        message =
            e.response?.data?['error'] ??
            e.response?.data?['info'] ??
            e.message ??
            message;
      }

      throw Exception(message);
    } catch (e) {
      throw Exception("Ocorreu um erro inesperado");
    }
  }
}
