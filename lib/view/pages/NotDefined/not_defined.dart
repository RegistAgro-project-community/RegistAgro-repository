import 'package:flutter/material.dart';

class NotDefined extends StatefulWidget {
  const NotDefined({super.key});

  @override
  State<NotDefined> createState() => _NotDefinedState();
}

class _NotDefinedState extends State<NotDefined> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        "Brevemente not defined...",
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 25
        ),
        ),
    );
  }
}