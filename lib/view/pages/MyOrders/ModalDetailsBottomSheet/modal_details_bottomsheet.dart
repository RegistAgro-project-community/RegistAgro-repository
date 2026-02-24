import 'package:flutter/material.dart';
import 'package:projecto_registagro/view/pages/MyOrders/ObjectListOrders/object_data.dart';

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
                        Text('Data e Hora: '),
                        Text('Estado: '),
                        Text('Descrição: '),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(order.date.toString().substring(0, 16)),
                        Text(order.status),
                        Text(order.description),
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