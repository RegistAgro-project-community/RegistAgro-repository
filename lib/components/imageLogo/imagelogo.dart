import 'package:flutter/material.dart';

class Imagelogo extends StatelessWidget {
  final double height;
  const Imagelogo(
    {
      super.key,
      required this.height 
      }
    );

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Image(
        image: AssetImage("assets/images/icone.png"),
        height: height,
        fit: BoxFit.cover,
      ),
    );
  }
}