import 'package:flutter/material.dart';
import 'package:projecto_registagro/view/pages/MyOrders/ObjectListOrders/object_data.dart';

final List<Order> allOrders = [
    Order(
      id: '#1',
      storeName: 'Tio Lucas',
      status: 'Completed',
      statusColor: Colors.green,
      date: DateTime(2023, 10, 15, 14, 30),
      description: 'Pedido de itens variados da loja principal.',
    ),
    Order(
      id: '#2',
      storeName: 'Maria Paz',
      status: 'Pending',
      statusColor: Colors.orange,
      date: DateTime(2023, 10, 16, 15, 45),
      description: 'Pedido em andamento para entrega.',
      driverPosition: 'Motorista a 5km, chegando em 10 min.',
    ),
    Order(
      id: '#3',
      storeName: 'Fazenda Kikovo',
      status: 'Cancelled',
      statusColor: Colors.red,
      date: DateTime(2023, 10, 17, 16, 0),
      description: 'Pedido cancelado pelo usuário.',
    ),
    Order(
      id: '#4',
      storeName: 'Fazenda Filomena',
      status: 'Completed',
      statusColor: Colors.green,
      date: DateTime(2023, 10, 18, 17, 15),
      description: 'Pedido finalizado com sucesso.',
    ),
  ];
