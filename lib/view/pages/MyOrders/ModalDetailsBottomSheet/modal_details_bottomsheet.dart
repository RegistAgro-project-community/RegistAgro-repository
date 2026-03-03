import 'package:flutter/material.dart';
import 'package:projecto_registagro/view/pages/MyOrders/ObjectListOrders/object_data.dart';

String setDescription(Order order){
  switch (order.status) {
    case "pendent":
      return "Este pedido precisa de confirmação.";
    case "confirmed":
      return "Este pedido foi confirmado.";
    case "canceled":
      return "Você cancelou este pedido";
    case "rejected":
      return "Este pedido foi rejeitado.";
    case "ongoing":
      return "O pedido está em andamento";
    default:
      return "Caregando...";
  }
}

void showDetailsBottomSheet(BuildContext context, Order order) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    height: 5,
                    width: 130,
                    decoration: BoxDecoration(
                      color: Color.fromARGB(244, 185, 185, 185),
                      borderRadius: BorderRadius.circular(100)
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ],
                ),
                const Text(
                  'Detalhes do Pedido',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Quantidade: "),
                        Text("Total: "),
                        Text('Data e Hora: '),
                        Text('Estado: '),
                        Text('Descrição: '),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text("${order.qtd}${order.unit}"),
                        Text(order.total),
                        Text(order.created_at.toString().substring(0, 16)),
                        Text(order.status),
                        Text(setDescription(order)),
                      ],
                    )
                  ],
                ),
                SizedBox(height: 20,),
                Container(
                  height: 250,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(10)
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }