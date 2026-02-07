import 'package:flutter/material.dart';
import 'package:projecto_registagro/view/pages/MyOrders/ObjectListOrders/object_data.dart';

void showTrackingBottomSheet(BuildContext context, Order order) {
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
                'Acompanhamento do Pedido',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              Container(
                height: 150,
                width: double.infinity,
                color: Colors.grey[300],
                child: const Center(child: Text('Mapa placeholder')),
              ),
              const SizedBox(height: 16),
              Text('Posição atual: ${order.driverPosition ?? 'N/A'}'),
              const SizedBox(height: 16),
              Text('Data: ${order.date.toString().substring(0, 16)}'),
              Text('Descrição: ${order.description}'),
            ],
          ),
        ),
      );
    },
  );
}