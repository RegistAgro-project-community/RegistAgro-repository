import 'package:dio/dio.dart';
import 'package:elegant_notification/elegant_notification.dart';
import 'package:flutter/material.dart';
import 'package:projecto_registagro/repositories/storage.dart';
import 'package:projecto_registagro/view/auth/OptScreen/opt_screen_state.dart';
import 'package:projecto_registagro/view/pages/main_page/main_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

final dio = Dio(
  BaseOptions(
    headers: {'Content-Type': 'application/json', 'Accept': 'application/json'},
  ),
);

class SignupValidations {
  String? name;
  String? phone;
  String? email;
  String? province;
  String? adress;
  String? pass1;
  String? pass2;

  SignupValidations({
    this.name,
    this.email,
    this.phone,
    this.province,
    this.adress,
    this.pass1,
    this.pass2,
  });

  sendEmail(BuildContext context) async {
    final userData = {
      "name": name,
      "email": email,
      "phone": phone,
      "adress": adress,
      "province": province,
      "pass1": pass1,
      "pass2": pass2,
    };

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext dialogContext) {
        return const Center(child: CircularProgressIndicator());
      },
    );

    try {
      final res = await dio.post(
        'https://api-registagro.onrender.com/auth/signup/consumer',
        data: userData,
      );

      if (context.mounted) Navigator.of(context).pop(); // fecha o loading

      if (context.mounted) {
        ElegantNotification.info(
          title: const Text("Enviando código"),
          description: Text(res.data['message']),
          height: 80,
        ).show(context);
      }

      final prefes = await SharedPreferences.getInstance();
      prefes.setString("last_route", '/otpCode');

      if (context.mounted) {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => OtpScreen()),
          (route) => false,
        );
      }
    } on DioException catch (e) {
      if (context.mounted) Navigator.of(context).pop();

      final data = e.response?.data;

      if (data is Map && data['error'] is List) {
        final List errors = data['error'];

        if (errors.isNotEmpty && errors.first is String) {
          final message = errors.join('\n');

          if (context.mounted) {
            ElegantNotification.error(
              title: const Text("Erro"),
              description: Text(message),
              height: 120,
            ).show(context);
          }
        } else {
          for (final err in errors) {
            final message = err['message'] ?? 'Erro desconhecido';

            if (context.mounted) {
              ElegantNotification.error(
                title: const Text("Erro"),
                description: Text(message),
                height: 80,
              ).show(context);
            }

            await Future.delayed(const Duration(seconds: 5));
          }
        }
      } else {
        if (context.mounted) {
          ElegantNotification.error(
            title: const Text("Erro"),
            description: Text(
              data?['message'] ?? data?['error'] ?? 'Ocorreu um erro inesperado',
            ),
            height: 80,
          ).show(context);
        }
      }
    } catch (e) {
      if (context.mounted) Navigator.of(context).pop();

      if (context.mounted) {
        ElegantNotification.error(
          title: const Text("Erro"),
          description: const Text('Ocorreu um erro inesperado'),
          height: 80,
        ).show(context);
      }
    }
  }

  validateOtp(BuildContext context, String code) async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext dialogContext) {
        return const Center(child: CircularProgressIndicator());
      },
    );

    try {
      final otpCode = await dio.get(
        'https://api-registagro.onrender.com/auth/signup/verify/$code',
      );

      if (context.mounted) Navigator.of(context).pop(); // fecha o loading

      final authHeader = otpCode.headers.value('authorization');
      final token = authHeader?.split(" ")[1];

      if (token == null) {
        ElegantNotification.error(
          title: const Text("Erro"),
          description: const Text('Token inválido, tente novamente'),
          height: 80,
        ).show(context);
        return;
      }

      final tokenStorage = TokenStorage();
      await tokenStorage.storeToken(token);

      final message = otpCode.data['message'];

      if (context.mounted) {
        ElegantNotification.success(
          title: const Text("Sucesso"),
          description: Text(message),
          height: 80,
        ).show(context);
      }

      final prefes = await SharedPreferences.getInstance();
      prefes.setString("last_route", '/MainPage');

      if (context.mounted) {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => MainPage()),
          (route) => false,
        );
      }
    } on DioException catch (e) {
      if (context.mounted) Navigator.of(context).pop(); 

       debugPrint('STATUS: ${e.response?.statusCode}');
        debugPrint('DATA: ${e.response?.data}');
        debugPrint('DATA TYPE: ${e.response?.data.runtimeType}');

      final message =
          e.response?.data?['message'] ??
          e.response?.data?['error'] ??
          'Ocorreu um erro inesperado';

      if (context.mounted) {
        ElegantNotification.error(
          title: const Text("Erro"),
          description: Text(message),
          height: 80,
        ).show(context);
      }
    } catch (e) {
      if (context.mounted) Navigator.of(context).pop();

      if (context.mounted) {
        ElegantNotification.error(
          title: const Text("Erro"),
          description: const Text('Ocorreu um erro inesperado'),
          height: 80,
        ).show(context);
      }
    }
  }
}
