import 'package:flutter/material.dart';
import 'package:projecto_registagro/config/api_config.dart';
import 'package:projecto_registagro/config/dio_client.dart';
import 'package:projecto_registagro/repositories/storage.dart';
import 'package:projecto_registagro/utils/logger.dart';

class VerifyAcessToken {
  Future<bool> isValidToken(BuildContext context) async {
    final tokenClass = TokenStorage();
    final token = await tokenClass.readToken();

    if (token.containsKey('error') || token['token'] == null) {
      return false;
    }

    final dio = DioClient().dio;

    try {
      await dio.get(ApiConfig.tokenVerify);

      return true;
    } catch (e) {
      AppLogger.debug('Token validation failed', error: e);
      return false;
    }
  }
}
