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
                const SizedBox(height: 16),
                Text('Data e Hora: ${order.date.toString().substring(0, 16)}'),
                const SizedBox(height: 8),
                Text('Estado: ${order.status}'),
                const SizedBox(height: 8),
                Text('Descrição: ${order.description}'),
                const SizedBox(height: 8),
                Text(order.additions),
              ],
            ),
          ),
        );
      },
    );
  }