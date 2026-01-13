import 'package:flutter/material.dart';
import './login_base_modal.dart';
import './modal_handle.dart';

class StepInsertPassword extends StatelessWidget {
  final VoidCallback onFinish;

  const StepInsertPassword({
    super.key,
    required this.onFinish,
  });

  @override
  Widget build(BuildContext context) {
    return LoginBaseModal(
      modalKey: const ValueKey('insertPassword'),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const ModalHandle(),
          const Text("Validação final"),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: onFinish,
            child: const Text("Entrar na aplicação"),
          ),
        ],
      ),
    );
  }
}
