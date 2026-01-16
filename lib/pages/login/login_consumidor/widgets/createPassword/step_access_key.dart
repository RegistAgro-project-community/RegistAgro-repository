import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:projecto_registagro/shared/formInput/input.dart';
import 'package:projecto_registagro/shared/show_top_message/show_top_message.dart';
import '../loginBaseModal/login_base_modal.dart';
import '../../../../../shared/Handle/modal_handle.dart';

class StepAccessKey extends StatefulWidget {
  final bool isLoading;
  final VoidCallback onNext;
  final ValueChanged<bool> onLoadingChange;

  const StepAccessKey({
    super.key,
    required this.isLoading,
    required this.onNext,
    required this.onLoadingChange,
  });

  @override
  State<StepAccessKey> createState() => _StepAccessKeyState();
}

class _StepAccessKeyState extends State<StepAccessKey> {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  bool isObscure = true;
  bool isConfirmObscure = true;

  void _handleOnNext() async {
  try {
    if (!formKey.currentState!.validate()) {
      return;
    }

    final password = passwordController.text.trim();
    final confirmPassword = confirmPasswordController.text.trim();
    if (password != confirmPassword) {
      showTopMessage(context, 'As passwords não coincidem!');
      return;
    }
    widget.onLoadingChange(true);
    await Future.delayed(const Duration(seconds: 2));
    if (!mounted) return;
    widget.onLoadingChange(false);
    widget.onNext();
  } catch (e) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Erro ao criar password: $e'),
      ),
    );
  }
}

  void toggleObscure() {
    setState(() {
      isObscure = !isObscure;
    });
  }

  void toggleConfirmObscure() {
    setState(() {
      isConfirmObscure = !isConfirmObscure;
    });
  }

  @override
  Widget build(BuildContext context) {
    return LoginBaseModal(
      modalKey: const ValueKey('accessKey'),
      child: SingleChildScrollView(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
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
                borderRadius: BorderRadius.circular(100),
              ),
              child: Icon(Icons.lock_outline, size: 27, color: Colors.green),
            ),
            const Text(
              "Verificação com chave de acesso",
              style: TextStyle(color: Colors.grey),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 13, horizontal: 1),
              child: Form(
                key: formKey,
                child: Column(
                  spacing: 20,
                  children: [
                    Input(
                      controller: emailController,
                      keyboardType: TextInputType.emailAddress,
                      isObscure: false,
                      placeholder: "Ex: registAgro@gmail.com",
                      labelText: "Insira o seu email",
                      icon: Icons.alternate_email,
                      onChanged: (value) {
                        emailController.value = TextEditingValue(
                          text: value.toLowerCase(),
                          selection: TextSelection.collapsed(
                            offset: value.length,
                          ),
                        );
                      },
                      validator: (input) {
                        if (input == null || input.trim().isEmpty) {
                          return 'Informe o email';
                        }

                        final emailRegex = RegExp(
                          r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                        );

                        if (!emailRegex.hasMatch(input.trim())) {
                          return '${emailController.text} -->  email inválido';
                        }

                        return null;
                      },
                    ),
                    Input(
                      controller: passwordController,
                      keyboardType: TextInputType.visiblePassword,
                      isObscure: isObscure,
                      placeholder: "Ex: registAgro@123",
                      labelText: "Insira uma password",
                      sufixIcon: IconButton(
                        icon: Icon(
                          isObscure ? Icons.visibility : Icons.visibility_off,
                        ),
                        onPressed: toggleObscure,
                        splashRadius: 20.r,
                      ),
                      icon: Icons.lock,
                      validator: (input) {
                        if (input == null || input.trim().isEmpty) {
                          return "Informe a password!";
                        }
                        if (input.length < 5) {
                          return "A password tem que conter mais de cinco (5) digitos!";
                        }
                        return null;
                      },
                    ),
                    Input(
                      controller: confirmPasswordController,
                      keyboardType: TextInputType.visiblePassword,
                      isObscure: isConfirmObscure,
                      placeholder: "Ex: registAgro@123",
                      labelText: "Confirmar password",
                      sufixIcon: IconButton(
                        icon: Icon(isConfirmObscure
                              ? Icons.visibility
                              : Icons.visibility_off,
                        ),
                        onPressed: toggleConfirmObscure,
                        splashRadius: 20.r,
                      ),
                      icon: Icons.lock,
                      validator: (input) {
                        if (input == null || input.trim().isEmpty) {
                          return "Confirme a sua password!";
                        }
                        if (input.length < 5) {
                          return "A password tem que conter mais de cinco (5) digitos!";
                        }
                        return null;
                      },
                    ),
                  ],
                ),
              ),
            ),
            SafeArea(
              child: SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  onPressed: widget.isLoading ? null : _handleOnNext,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 5, 110, 9),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6),
                    ),
                  ),
                  child: widget.isLoading
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
            ),
          ],
        ),
      ),
    );
  }
}
