import 'package:flutter/material.dart';

class ArrowBack extends StatelessWidget {
  final VoidCallback onPressed;
  const ArrowBack(
    {
      super.key,
      required this.onPressed
      }
    );

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topLeft,
      child: IconButton(
        onPressed: onPressed,
        icon: Icon(
          Icons.arrow_back,
          fontWeight: FontWeight.bold,
          color: Colors.green,
        ),
      ),
    );
  }
}