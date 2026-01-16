import 'package:flutter/material.dart';
import '../loginBaseModal/login_base_modal.dart';

class StepLoadingPassword extends StatelessWidget {
  final String message;

  const StepLoadingPassword({
    super.key,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    return LoginBaseModal(
      modalKey: const ValueKey('loadingPassword'),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            message,
            textAlign: TextAlign.center,
            style: const TextStyle(color: Colors.grey),
          ),
          const SizedBox(height: 16),
          const CircularProgressIndicator(),
        ],
      ),
    );
  }
}
