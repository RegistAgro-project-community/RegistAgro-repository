import 'package:flutter/material.dart';

class LoginBaseModal extends StatelessWidget {
  final Widget child;
  final Key? modalKey;

  const LoginBaseModal({
    super.key,
    required this.child,
    this.modalKey,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: SafeArea(
        child: Container(
          key: modalKey,
          width: double.infinity,
          padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
          decoration: const BoxDecoration(
            color: Color(0xFFF6F6F6),
            borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
          ),
          child: child,
        ),
      ),
    );
  }
}
