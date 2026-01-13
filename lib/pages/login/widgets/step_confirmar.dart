import 'package:flutter/material.dart';
import './login_base_modal.dart';
import './modal_handle.dart';

class StepConfirmar extends StatefulWidget {
  final Future<void> Function() onConfirmar;

  const StepConfirmar({
    super.key,
    required this.onConfirmar,
  });

  @override
  State<StepConfirmar> createState() => _StepConfirmarState();
}

class _StepConfirmarState extends State<StepConfirmar> {
  bool isLoading = false;

  Future<void> _handleConfirmar() async {
    setState(() => isLoading = true);
    await Future.delayed(const Duration(seconds: 2));
    await widget.onConfirmar();
  }

  @override
  Widget build(BuildContext context) {
    return LoginBaseModal(
      modalKey: const ValueKey('confirmar'),
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const ModalHandle(),
            const Text(
              "Confirmar dados",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 25),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildRow("Nome:", "Elias Manuell"),
                _buildRow("Email:", "eliasmanuell495@gmail.com"),
                _buildRow("Departamento:", "not found", isError: true),
                _buildRow("Cargo:", "not found", isError: true),
                _buildRow("Endereço:", "Av. 21 de Janeiro, Gamek, rua dos combatentes", isEnd: true),
              ],
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                onPressed: isLoading ? null : _handleConfirmar,
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

  Widget _buildRow(
    String label, 
    String value, 
    { bool isError = false, 
      bool isEnd = false
     }
    ) {
    return Padding(
      padding: EdgeInsets.only(bottom: isEnd ? 0 : 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 110,
            child: Text(
              label,
              style: const TextStyle(fontSize: 15),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              value,
              style: TextStyle(color: isError ? Colors.red : Colors.grey),
              textAlign: TextAlign.end,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
