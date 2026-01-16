import 'package:flutter/material.dart';
import 'package:projecto_registagro/shared/formInput/input.dart';
import '../loginBaseModal/login_base_modal.dart';
import '../../../../../shared/Handle/modal_handle.dart';

class StepInsertPassword extends StatelessWidget {
  final VoidCallback onFinish;
  const StepInsertPassword({super.key, required this.onFinish});

  @override
  Widget build(BuildContext context) {
    final confirmationNumberController = TextEditingController();
    return LoginBaseModal(
      modalKey: const ValueKey('insertPassword'),
      child: SingleChildScrollView(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const ModalHandle(),
            const Text("Validação final"),
            const SizedBox(height: 16),
            Input(
              controller: confirmationNumberController,
              keyboardType: TextInputType.number,
              placeholder: "Insira o código de confirmação",
              labelText: "Verifique o seu email",
              sufixIcon: Icon(Icons.key, color: Colors.grey),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: onFinish,
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 111, vertical: 13),
                backgroundColor: const Color.fromARGB(255, 5, 110, 9),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6),
                ),
              ),
              child: const Text(
                "Entrar na aplicação",
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
