import 'package:flutter/material.dart';
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
  final Color? color;

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
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      onChanged: onChanged,
      validator: validator,
      obscureText: isObscure,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.grey.shade200,
        hintText: placeholder,
        suffixIcon: sufixIcon,
        prefixIcon: icon != null ? Icon(icon, color: Colors.grey) : null,
        floatingLabelBehavior: FloatingLabelBehavior.auto,
        labelText: labelText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5.r),
          borderSide: BorderSide(color: Color(0xF4F4F4F4)),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5.r),
          borderSide: BorderSide(color: Colors.red),
        ),
        labelStyle: TextStyle(color: Colors.grey),
        hintStyle: TextStyle(color: Colors.grey),
        iconColor: Colors.grey,
        contentPadding: EdgeInsets.symmetric(
          horizontal: 10.r, 
          vertical: 18.r
        ),
      ),
    );
  }
}
