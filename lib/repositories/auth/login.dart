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
  
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext dialogContext) {
      return const Center(child: CircularProgressIndicator());
    },
  );

  try {
    final res = await dio.post(
      'https://api-registagro.onrender.com/auth/login',
      data: data,
    );

    if (context.mounted) Navigator.of(context).pop();

    final authHeader = res.headers.value('authorization');
    final token = authHeader?.split(" ")[1];

    final stored = await storeToken.storeToken(token!);

    if (stored) {
      return {'message': res.data["message"]};
    }

    return {'error': "Não foi possível fazer login"};
  } on DioException catch (e) {
    if (context.mounted) Navigator.of(context).pop();

    return {"error": e.response?.data!["error"]};
  }
}
