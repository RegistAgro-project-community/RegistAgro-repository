import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:projecto_registagro/repositories/storage.dart';

final dio = Dio(BaseOptions(headers: {'Content-Type': 'application/json'}));
final storeToken = TokenStorage();

Future<Map<String, String>> login(
  BuildContext context,
  String email,
  String password,
) async {
  final data = {'email': email, 'password': password};
  
  try {
    final res = await dio.post(
      'https://api-registagro.onrender.com/auth/login/consumer',
      data: data,
    );

    final authHeader = res.headers.value('authorization');
    final token = authHeader?.split(" ")[1];

    final stored = await storeToken.storeToken(token!);

    if (stored) {
      return {'message': res.data["message"]};
    }

    return {'error': "Não foi possível fazer login"};
  } on DioException catch (e) {
    final responseData = e.response?.data;
    String errorMessage;

    if (responseData is Map) {
      errorMessage = responseData["error"] ?? "Ocorreu um erro ao fazer login";
    } else if (responseData is String) {
      errorMessage = responseData.isNotEmpty ? responseData : "Ocorreu um erro ao fazer login";
    } else {
      errorMessage = "Ocorreu um erro ao fazer login";
    }

    return {"error": errorMessage};
  }
}
