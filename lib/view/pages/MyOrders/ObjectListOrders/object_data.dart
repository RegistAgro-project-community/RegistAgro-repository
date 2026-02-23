import 'package:flutter/material.dart';

class Order {
  final String id;
  final String storeName;
  final String status;
  final Color statusColor;
  final DateTime date;
  final String description;
  final String? driverPosition;

  Order({
    required this.id,
    required this.storeName,
    required this.status,
    required this.statusColor,
    required this.date,
    required this.description,
    this.driverPosition,
  });
}
