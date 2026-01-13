import 'package:flutter/material.dart';

class ModalHandle extends StatelessWidget {
  const ModalHandle({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 140,
      height: 5,
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(8),
      ),
    );
  }
}
