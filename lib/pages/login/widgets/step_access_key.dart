import 'package:flutter/material.dart';
import './login_base_modal.dart';
import './modal_handle.dart';


class StepAccessKey extends StatefulWidget {
  final VoidCallback onNext;
  final ValueChanged<bool> onLoadingChange;

  const StepAccessKey({
    super.key,
    required this.onNext,
    required this.onLoadingChange
  });

  @override
  State<StepAccessKey> createState() => _StepAccessKeyState();
}

class _StepAccessKeyState extends State<StepAccessKey> {

  final formKey = GlobalKey<FormState>();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  bool isLoading = false;

   void _handleOnNext() async {
    if (!formKey.currentState!.validate()) return;
    widget.onLoadingChange(true);
    await Future.delayed(const Duration(seconds: 2));
    if(mounted) return;
      widget.onLoadingChange(false);
      widget.onNext();          
  }

  @override
  Widget build(BuildContext context) {
    return LoginBaseModal(
      modalKey: const ValueKey('accessKey'),
      child: SingleChildScrollView(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const ModalHandle(),
            Container(
              height: 45,
              width: 45,
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 179, 238, 181),
                borderRadius: BorderRadius.circular(100)
              ),
              child: Icon(
                Icons.lock_outline, 
                size: 27,
                color: Colors.green,
              )
            ),
            const SizedBox(height: 10),
            const Text(
              "Verificação com chave de acesso",
              style: TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: passwordController,
                      keyboardType: TextInputType.visiblePassword,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Crie uma password!';
                        }
                        if (value.length < 5) {
                          return 'A password não pode ter menos de 6 digítos!';
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                        labelText: 'Insira uma password',
                        hintText: 'Ex: registAgro@123',
                        border: OutlineInputBorder(),
                        counterText: '',
                      ),
                    ),
                    const SizedBox(height: 20,),
                    TextFormField(
                      controller: confirmPasswordController,
                      keyboardType: TextInputType.visiblePassword,
                      validator: (value) {
                         if (value == null || value.isEmpty) {
                          return 'Confirme a sua password!';
                        }
                        if (value.length < 5) {
                          return 'A password não pode ter menos de 6 digítos!';
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                        labelText: 'Confirmar password',
                        hintText: 'Ex: registAgro@123',
                        border: OutlineInputBorder(),
                        counterText: '',
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                onPressed: isLoading ? null : _handleOnNext,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 5, 110, 9),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6),
                  ),
                ),
                child: isLoading
                  ? const SizedBox(
                      width: 22,
                      height: 22,
                      child: CircularProgressIndicator(
                        strokeWidth: 2.5,
                        color: Colors.white,
                      ),
                    )
                  : const Text(
                    "Continuar",
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
