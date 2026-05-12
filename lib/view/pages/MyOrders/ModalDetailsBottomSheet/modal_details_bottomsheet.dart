import 'package:flutter/material.dart';
import 'package:projecto_registagro/view/pages/MyOrders/ObjectListOrders/object_data.dart';

String setDescription(Order order) {
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

String setStatus(String status){
  switch (status) {
    case "pendent":
      return "pendente";
    case "delivered":
      return "entregue";
    case "canceled":
      return "cancelado";
    case "rejected":
      return "rejeitado";
    case "ongoing":
      return "em andamento";
    case "incollection":
      return "em coleta";
    default:
      return status;
  }
}

String splitDate(Order order) {
  List date = order.created_at.split("T");
  String created_at = "${date[0]} ${date[1]}";

  return created_at;
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
                    borderRadius: BorderRadius.circular(100),
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
                      Text("Produto: "),
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
                      Text(order.product.name),
                      Text(
                        "${order.qtd}${order.unit == "t" ? "ton" : order.unit}",
                      ),
                      Text(order.total),
                      Text(splitDate(order).toString().substring(0, 16)),
                      Text(setStatus(order.status)),
                      Text(setDescription(order)),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 20),
              Container(
                height: 200,
                width: double.infinity,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}
