import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:projecto_registagro/config/api_config.dart';
import 'package:projecto_registagro/config/dio_client.dart';
import 'package:projecto_registagro/repositories/storage.dart';
import 'package:projecto_registagro/utils/logger.dart';
import 'package:projecto_registagro/utils/safe_notification.dart';
import 'package:projecto_registagro/view/auth/OptScreen/opt_screen_state.dart';
import 'package:projecto_registagro/view/pages/main_page/main_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignupValidations {
  String? name;
  String? phone;
  String? email;
  String? province;
  String? adress;
  String? pass1;
  String? pass2;
  String? captchaToken;

  SignupValidations({
    this.name,
    this.email,
    this.phone,
        this.province,
        this.adress,
        this.pass1,
        this.pass2,
        this.captchaToken,
      });

      Future<Map<String, String>> sendEmail(BuildContext context) async {
        final dio = DioClient().dio;
        final userData = {
          "name": name,
          "email": email,
          "phone": phone,
          "adress": adress,
          "province": province,
          "pass1": pass1,
          "pass2": pass2,
          "captchaToken": captchaToken,
        };

        try {
        final res = await dio.post(
          ApiConfig.consumerSignup,
          data: userData,
        );

        showSafeInfoNotification(
          context,
          title: 'Enviando código',
          description: res.data['message']?.toString(),
        );

        final prefes = await SharedPreferences.getInstance();
        prefes.setString("last_route", '/otpCode');

        if (context.mounted) {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => OtpScreen()),
            (route) => false,
          );
        }

        return {'message': res.data['message'] ?? 'Código enviado'};
      } on DioException catch (e) {
        AppLogger.dioError('Erro no cadastro', error: e);

        String errorMessage;
        final statusCode = e.response?.statusCode;

        if (statusCode == 400) {
          final data = e.response?.data;
          if (data is Map && data['error'] is List) {
            final List errors = data['error'];
            if (errors.isNotEmpty) {
              if (errors.first is String) {
                errorMessage = errors.join('\n');
              } else {
                errorMessage = errors.map((err) => err['message']?.toString() ?? 'Erro de validação').join('\n');
              }
            } else {
              errorMessage = 'Dados inválidos';
            }
          } else {
            errorMessage = data?['message'] ?? data?['error'] ?? 'Erro ao cadastrar';
          }
        } else if (statusCode == 429) {
          errorMessage = 'Muitas tentativas. Tente novamente mais tarde';
        } else if (statusCode == 500) {
          errorMessage = 'Erro no servidor. Tente novamente mais tarde';
        } else if (e.type == DioExceptionType.connectionTimeout ||
                   e.type == DioExceptionType.receiveTimeout) {
          errorMessage = 'Tempo de conexão esgotado. Verifique sua internet';
        } else if (e.type == DioExceptionType.connectionError) {
          errorMessage = 'Erro de conexão. Verifique sua internet';
        } else {
          errorMessage = 'Ocorreu um erro ao cadastrar';
        }

        showSafeNotification(
          context,
          title: 'Erro',
          description: errorMessage,
          backgroundColor: Colors.red.shade700,
          icon: Icons.error_outline,
        );

        return {'error': errorMessage};
      } catch (e, stackTrace) {
        AppLogger.error('Erro inesperado no cadastro', error: e, stackTrace: stackTrace);
        showSafeNotification(
          context,
          title: 'Erro',
          description: 'Ocorreu um erro inesperado',
          backgroundColor: Colors.red.shade700,
          icon: Icons.error_outline,
        );
        return {'error': 'Ocorreu um erro inesperado'};
      }
    }

    Future<Map<String, String>> validateOtp(BuildContext context, String code) async {
      final dio = DioClient().dio;
      final storeToken = TokenStorage();

      try {
        // API expects GET /auth/signup/verify/{code}?email=...
        final email = this.email ?? '';
        final otpCode = await dio.get(
          '${ApiConfig.consumerVerifyOtpGet}/$code',
          queryParameters: {'email': email},
        );

        // API returns TokenPair: {accessToken, refreshToken, tokenType, expiresIn}
        final accessToken = otpCode.data['accessToken'];
        final refreshToken = otpCode.data['refreshToken'];

        if (accessToken == null) {
          return {'error': 'Token não recebido do servidor'};
        }

        final stored = await storeToken.storeToken(accessToken);
        // TODO: Store refresh token separately if needed

        if (!stored) {
          return {'error': 'Não foi possível salvar o token'};
        }

        final message = otpCode.data['message']?.toString() ?? 'Cadastro confirmado';

        showSafeSuccessNotification(
          context,
          title: 'Sucesso',
          description: message,
        );

        final prefes = await SharedPreferences.getInstance();
        prefes.setString("last_route", '/MainPage');

        if (context.mounted) {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => MainPage()),
            (route) => false,
          );
        }

        return {'message': message};
      } on DioException catch (e) {
        AppLogger.dioError('Erro na verificação OTP', error: e);

        String errorMessage;
        final statusCode = e.response?.statusCode;

        if (statusCode == 400) {
          errorMessage = e.response?.data?['message'] ?? e.response?.data?['error'] ?? 'Código inválido';
        } else if (statusCode == 401) {
          errorMessage = 'Código expirado ou inválido';
        } else if (statusCode == 429) {
          errorMessage = 'Muitas tentativas. Tente novamente mais tarde';
        } else if (statusCode == 500) {
          errorMessage = 'Erro no servidor. Tente novamente mais tarde';
        } else if (e.type == DioExceptionType.connectionTimeout ||
                   e.type == DioExceptionType.receiveTimeout) {
          errorMessage = 'Tempo de conexão esgotado. Verifique sua internet';
        } else if (e.type == DioExceptionType.connectionError) {
          errorMessage = 'Erro de conexão. Verifique sua internet';
        } else {
          errorMessage = 'Ocorreu um erro ao verificar código';
        }

        showSafeNotification(
          context,
          title: 'Erro',
          description: errorMessage,
          backgroundColor: Colors.red.shade700,
          icon: Icons.error_outline,
        );

        return {'error': errorMessage};
      } catch (e, stackTrace) {
        AppLogger.error('Erro inesperado na verificação OTP', error: e, stackTrace: stackTrace);
        showSafeNotification(
          context,
          title: 'Erro',
          description: 'Ocorreu um erro inesperado',
          backgroundColor: Colors.red.shade700,
          icon: Icons.error_outline,
        );
        return {'error': 'Ocorreu um erro inesperado'};
      }
    }
  }
