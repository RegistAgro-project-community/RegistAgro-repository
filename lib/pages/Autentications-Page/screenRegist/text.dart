import 'package:flutter/material.dart';

class MyText extends StatelessWidget {
  final String title;

  const MyText(
    {
      super.key, 
      required this.title
      }
    );

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 17,
        color: Colors.grey,
        fontWeight: FontWeight.w500
      ),
    );
  }
}