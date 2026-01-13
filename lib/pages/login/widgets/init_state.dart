import 'package:flutter/material.dart';
import 'package:projecto_registagro/pages/login/widgets/login_base_modal.dart';
import 'package:projecto_registagro/pages/login/widgets/modal_handle.dart';

class InitState extends StatefulWidget {
  final bool isLoading;
  final VoidCallback onConsumidor;
  final VoidCallback onMotorista;
  final ValueChanged<bool> onLoadingChanged;

  const InitState(
    {
      super.key,
      required this.isLoading,
      required this.onConsumidor,
      required this.onMotorista,
      required this.onLoadingChanged
      }
    );

  @override
  State<InitState> createState() => _InitStateState();
}

class _InitStateState extends State<InitState> {

  void handleConsumidor() async {
    if (mounted) {
      widget.onLoadingChanged(false);
      widget.onConsumidor();          
    }
  }
  @override
  Widget build(BuildContext context) {
    return LoginBaseModal(
      key: const Key("initState"),
      child: SafeArea(
        child: SizedBox(
          height: 230,
          child: Column(
            children: [
              const ModalHandle(),
              const SizedBox(height: 6),
              const Text(
                "Escolha uma conta para começar",
                style: TextStyle(
                  color: Colors.grey,
                  fontWeight: FontWeight.w500,
                  fontSize: 15
                ),
              ),
              const SizedBox(height: 16),
              InkWell(
                onTap: widget.isLoading ? null : handleConsumidor,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.grey.shade300),
                  ),
                  child: ListTile(
                    leading: const CircleAvatar(
                      backgroundColor: Colors.white,
                      child: Icon(Icons.person, color: Colors.grey),
                    ),
                    title: const Text(
                      "Consumidor",
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                        fontFamily: "arial"
                      ),
                    ),
                    subtitle: const Text(
                      "Entre como uma empresa consumidora",
                        style: TextStyle(
                          fontSize: 13.5,
                          color: Colors.grey
                        ),
                    ),
                    trailing: Icon(
                      Icons.arrow_forward,
                      color: Colors.grey.shade400
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20,),
              InkWell(
                onTap: () {},
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.grey.shade300),
                  ),
                  child: ListTile(
                    leading: const CircleAvatar(
                      backgroundColor: Colors.white,
                      child: Icon(Icons.person, color: Colors.grey),
                    ),
                    title: const Text(
                      "Motorista",
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                        fontFamily: "arial"
                      ),
                    ),
                    subtitle: const Text(
                      "Entre como motorista e comece um corrida",
                      style: TextStyle(
                        fontSize: 13.5,
                        color: Colors.grey
                      ),
                    ),
                    trailing: Icon(
                      Icons.arrow_forward,
                      color: Colors.grey.shade400
                    ),
                    onTap: (){},
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}