import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ButtonSubmit extends StatelessWidget {
  final Widget child;
  final VoidCallback? onPressed;
  final Color backgroundColor;
  final Color color;
  final BorderRadius? borderRadius;
  final EdgeInsetsGeometry? padding;

  const ButtonSubmit({
    super.key,
    required this.child,
    required this.onPressed,
    this.borderRadius,
    this.padding,
    this.color = Colors.white,
    this.backgroundColor = const Color(0xFF61983D),
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? EdgeInsets.symmetric(horizontal: 20),
      child: SizedBox(
        width: MediaQuery.sizeOf(context).width * .8.w,
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: backgroundColor,
            padding: EdgeInsets.symmetric(vertical: 10.r),
            shape: RoundedRectangleBorder(
              borderRadius: borderRadius ?? BorderRadius.circular(10.r),
            ),
            elevation: 2.r,
          ),
          child: child,
        ),
      ),
    );
  }
}