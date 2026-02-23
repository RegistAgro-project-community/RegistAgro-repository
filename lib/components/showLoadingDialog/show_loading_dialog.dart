import 'package:flutter/material.dart';

void showLoadingDialog(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: false, // não fecha ao clicar fora
    barrierColor: Colors.black.withOpacity(0.7), // fundo escuro
    builder: (context) {
      return const Dialog(
        backgroundColor: Colors.transparent,
        insetPadding: EdgeInsets.zero, // ocupa toda tela
        child: SizedBox.expand(
          child: Center(
            child: CircularProgressIndicator(
              color: Colors.white,
              strokeWidth: 4,
            ),
          ),
        ),
      );
    },
  );
}