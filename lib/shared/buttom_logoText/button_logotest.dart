import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ButtonLogotext extends StatelessWidget {
  final String tilte;
  final VoidCallback onPressed;
  final Color backgroundColor;
  final Color color;
  final BorderRadius? borderRadius;
  final EdgeInsetsGeometry? padding;


  const ButtonLogotext ({
    super.key,
    required this.tilte,
    required this.onPressed,
    this.borderRadius,
    this.padding,
    this.color = Colors.white,
    this.backgroundColor = const Color(0xFF61983D),
  });
  @override
  
  Widget build(BuildContext context) {
    return Padding(
      padding: padding?? EdgeInsets.symmetric(horizontal: 20),
      child: SizedBox(
        width: MediaQuery.sizeOf(context).height * .4.w,
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: backgroundColor,
            padding: EdgeInsets.symmetric(vertical: 16.r),
            shape: RoundedRectangleBorder(
              borderRadius: borderRadius?? BorderRadius.circular(100.r),
              side: BorderSide(
                color: Color(0xFF61983D),
                width: 2.w
              )
            ),
            elevation: 4.r,
          ),
          child: Text(
            tilte,
            style: TextStyle(
              color:  color,
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.r
            ),
          ),
        ),
      ),
    );
  }
}