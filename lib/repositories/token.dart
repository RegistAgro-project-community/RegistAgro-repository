import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:projecto_registagro/repositories/storage.dart';

class VerifyAcessToken {
  isValidToken(BuildContext context) async {
    final tokenClass = TokenStorage();
    final token = await tokenClass.readToken();

    if (token.containsKey('error') || token['token'] == null) {
      return false;
    }

    final dio = Dio(
      BaseOptions(
        headers: {
          'Content-Type': 'application/json',
          'authorization': 'Bearer ${token['token']}',
        },
      ),
    );

    try {
      await dio.get('https://api-registagro.onrender.com/token');

      return true;
    } catch (e) {
      return false;
    }
  }
}
