import 'package:flutter/material.dart';

class Imagelogo extends StatelessWidget {
  final height;
  const Imagelogo(
    {
      super.key,
      this.height 
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