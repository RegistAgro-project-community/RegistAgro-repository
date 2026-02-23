import 'package:dio/dio.dart';
import 'package:elegant_notification/elegant_notification.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:projecto_registagro/repositories/storage.dart';
import 'package:projecto_registagro/view/login-signup/OptScreen/opt_screen_state.dart';
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

      if (context.mounted) {
        Navigator.of(context).pop();
      }

      ElegantNotification.info(
        title: Text("Enviando código"),
        description: Text(res.data['message']),
        height: 80,
        // ignore: use_build_context_synchronously
      ).show(context);

      final prefes = await SharedPreferences.getInstance();
      prefes.setString("last_route", '/otpCode');

      if (context.mounted) {
        Navigator.pushReplacement(
          context,
          PageTransition(
            type: PageTransitionType.leftToRight,
            child: const OtpScreen(),
            duration: const Duration(milliseconds: 350),
          ),
        );
      }
    } on DioException catch (e) {
      if (context.mounted) Navigator.pop(context);

      final data = e.response?.data;

      if (data is Map && data['error'] is List) {
        final List errors = data['error'];

        if (errors.isNotEmpty && errors.first is String) {
          final message = errors.join('\n');

          ElegantNotification.error(
            title: const Text("Error"),
            description: Text(message),
            height: 120,
            // ignore: use_build_context_synchronously
          ).show(context);
        } else {
          for (final err in errors) {
            final message = err['message'];

            ElegantNotification.error(
              title: Text("Error"),
              description: Text(message),
              height: 80,
              // ignore: use_build_context_synchronously
            ).show(context);

            await Future.delayed(const Duration(seconds: 4));
          }
        }
      } else {
        ElegantNotification.error(
          title: const Text("Error"),
          description: Text(e.response?.data['message']),
          height: 80,
          // ignore: use_build_context_synchronously
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

      if (context.mounted) Navigator.of(context).pop();

      final authHeader = otpCode.headers.value('authorization');
      final token = authHeader?.split(" ")[1];

      final tokenStorage = TokenStorage();

      try {
        await tokenStorage.storeToken(token!);

        final message = otpCode.data['message'];

        ElegantNotification.success(
          title: Text("Sucess"),
          description: Text(message),
          height: 80,
          // ignore: use_build_context_synchronously
        ).show(context);

        Future.delayed(const Duration(seconds: 1), () {
          Navigator.pushReplacement(
            // ignore: use_build_context_synchronously
            context,
            PageTransition(
              type: PageTransitionType.leftToRight,
              child: const MainPage(),
              duration: const Duration(milliseconds: 350),
            ),
            //MaterialPageRoute(builder: (_) => const MainPage()),
          );
        });
      } catch (e) {
        if (context.mounted) Navigator.of(context).pop();

        ElegantNotification.error(
          title: Text("Error"),
          description: Text('Ocorreu um erro inesperado'),
          height: 80,
          // ignore: use_build_context_synchronously
        ).show(context);
      }
    } on DioException catch (e) {
      if (context.mounted) Navigator.of(context).pop();

      final message = e.response?.data?['message'] ?? e.response?.data?['error'];

      ElegantNotification.error(
        title: Text("Error"),
        description: Text(message),
        height: 80,
        // ignore: use_build_context_synchronously
      ).show(context);
    }
  }
}
