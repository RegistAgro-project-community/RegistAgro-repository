import 'package:flutter/material.dart';

class InicialStore extends StatefulWidget {
  const InicialStore({super.key});

  @override
  State<InicialStore> createState() => _InicialStoreState();
}

class _InicialStoreState extends State<InicialStore> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        "Brevemente store...",
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 25
        ),
      ),
    );
  }
}