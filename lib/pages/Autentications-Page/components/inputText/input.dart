import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Input extends StatelessWidget {
  final String placeholder;
  final TextEditingController? controller;
  final TextInputType keyboardType;
  final IconData? icon;
  final ValueChanged<String>? onChanged;

  final String? Function(String?)? validator;

  const Input({
    super.key,
    this.icon,
    required this.placeholder,
    this.controller,
    this.keyboardType = TextInputType.text,
    this.onChanged,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      onChanged: onChanged,
      validator: validator,
      decoration: InputDecoration(
        hintText: placeholder,
        prefixIcon: icon != null ? Icon(icon) : null,
        floatingLabelBehavior: FloatingLabelBehavior.auto,
        labelText: placeholder,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.r)
        ),
        labelStyle: TextStyle(color: Colors.grey),
        contentPadding: EdgeInsets.symmetric(
          horizontal: 16.r,
          vertical: 12.r,
        ),
      ),
    );
  }
}
