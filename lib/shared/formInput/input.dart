import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Input extends StatelessWidget {
  final String placeholder;
  final String labelText;
  final TextEditingController? controller;
  final TextInputType keyboardType;
  final IconData? icon;
  final Widget? sufixIcon;
  final ValueChanged<String>? onChanged;
  final bool isObscure;
  final String? Function(String?)? validator;
  final  maxLenght;

  const Input({
    super.key,
    this.icon,
    this.isObscure = false,
    required this.placeholder,
    required this.labelText,
    this.controller,
    this.sufixIcon,
    this.keyboardType = TextInputType.text,
    this.onChanged,
    this.validator,
    this.maxLenght = 10
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      onChanged: onChanged,
      validator: validator,
      obscureText: isObscure,
      inputFormatters: [
        LengthLimitingTextInputFormatter(maxLenght)
      ],
      decoration: InputDecoration(
        hintText: placeholder,
        suffixIcon: sufixIcon,
        prefixIcon: icon != null ? Icon(icon) : null,
        floatingLabelBehavior: FloatingLabelBehavior.auto,
        labelText: labelText,
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
