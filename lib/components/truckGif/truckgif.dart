import 'package:flutter/material.dart';

class Truckgif extends StatefulWidget {
  const Truckgif({super.key});

  @override
  State<Truckgif> createState() => _TruckgifState();
}

class _TruckgifState extends State<Truckgif> {
  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'assets/videos/truck.gif',
      width: 150,
      height: 150,
      fit: BoxFit.cover,
    );
  }
}