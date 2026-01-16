import 'package:flutter/material.dart';
import 'package:projecto_registagro/pages/login/login_consumidor/widgets/loginBaseModal/login_base_modal.dart';
import 'package:projecto_registagro/shared/Handle/modal_handle.dart';


  Widget buildInitState( 
    VoidCallback onConsumidor, 
    VoidCallback onMotorista 
    ) {
    return LoginBaseModal(
      key: const Key("initState"),
      child: SafeArea(
        child: SizedBox(
          height: 250,
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
              GestureDetector(
                onTap: onConsumidor,
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
              GestureDetector(
                onTap: onMotorista,
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
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
