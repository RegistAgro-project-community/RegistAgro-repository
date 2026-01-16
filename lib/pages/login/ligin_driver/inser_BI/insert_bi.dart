import 'package:flutter/material.dart';
import 'package:projecto_registagro/pages/login/login_consumidor/widgets/loginBaseModal/login_base_modal.dart';
import '../../../../../shared/Handle/modal_handle.dart';

class StepInsertBI extends StatefulWidget {
  final bool isLoading;
  final VoidCallback onContinuar;
  final ValueChanged<bool> onLoadingChanged;

  const StepInsertBI({
    super.key,
    required this.isLoading,
    required this.onContinuar,
    required this.onLoadingChanged,
  });

  @override
  State<StepInsertBI> createState() => _StepInsertBIState();
}

class _StepInsertBIState extends State<StepInsertBI> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController nifController = TextEditingController();

  void _handleContinuar() async {
    if (!_formKey.currentState!.validate()) return;
    widget.onLoadingChanged(true);
    await Future.delayed(const Duration(seconds: 2));
    if (mounted) {
      widget.onLoadingChanged(false);
      widget.onContinuar();          
    }
  }

  @override
  Widget build(BuildContext context) {
    return LoginBaseModal(
      modalKey: const ValueKey('insert_nif'),
      child: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const ModalHandle(),
              const SizedBox(height: 6),
              const Text(
                "Insira o seu NIF para começar.",
                style: TextStyle(color: Colors.grey, fontSize: 15),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                child: Form(
                  key: _formKey,
                  child: TextFormField(
                    controller: nifController,
                    keyboardType: TextInputType.number,
                    maxLength: 10,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'O NIF é obrigatório';
                      }
                      if (!RegExp(r'^\d+$').hasMatch(value)) {
                        return 'Digite apenas números';
                      }
                      if (value.length != 10) {
                        return 'O NIF deve ter exatamente 10 números';
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                      labelText: 'Insira o seu NIF',
                      hintText: 'Ex: 1234567890',
                      border: OutlineInputBorder(),
                      counterText: '',
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: ElevatedButton(
                    onPressed: widget.isLoading ? null : _handleContinuar,
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
              const SizedBox(height: 8),
            ],
          ),
        ),
      ),
    );
  }
}