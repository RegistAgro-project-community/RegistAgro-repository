import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:projecto_registagro/repositories/storage.dart';
import 'package:projecto_registagro/view/pages/main_page/main_page.dart';

final verifyToken = TokenStorage();

class VerifyAcessToken {
  Future isLogged(BuildContext context) async {
    final token = await verifyToken.readToken();

    if (token.containsKey('token')) {
      return Navigator.pushReplacement(
        // ignore: use_build_context_synchronously
        context,
        PageTransition(
          type: PageTransitionType.fade,
          child: MainPage(),
          duration: const Duration(milliseconds: 300),
        ),
      );
    }

    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("${token['error']}"),
        backgroundColor: Colors.red,
      ),
    );
  }
  
}
