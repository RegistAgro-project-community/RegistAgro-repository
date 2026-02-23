import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:projecto_registagro/repositories/storage.dart';
import 'package:projecto_registagro/shared/TopNotifications/top_notification.dart';
import 'package:projecto_registagro/view/login-signup/loginScreen/login.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Profile {
  logout(BuildContext context) async {
    final tokenClass = TokenStorage();
    final logoutResult = await tokenClass.logout();

    if (logoutResult.containsKey('message')) {
      if (!context.mounted) return;
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext dialogContext) {
          return const Center(child: CircularProgressIndicator());
        },
      );

      await Future.delayed(const Duration(milliseconds: 1000));

      showTopNotification(
        context,
        title: "Sucess",
        description: "Logout efetuado com sucesso",
        backgroundColor: Colors.green,
        icon: Icons.verified,
      );

      final prefes = await SharedPreferences.getInstance();
      prefes.setString("last_route", '/');

      Navigator.pushReplacement(
        context,
        PageTransition(type: PageTransitionType.leftToRight, child: Login()),
      );
    }else{
      showTopNotification(
        context,
        title: "Error",
        description: "Não foi possível fazer terminar sessão",
        backgroundColor: Colors.amber,
        icon: Icons.error_outline,
      );
    }

  }
}
