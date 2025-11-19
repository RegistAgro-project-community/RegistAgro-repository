import 'package:flutter/material.dart';
import 'package:projecto_registagro/pages/Autentications-Page/homeScreen/homescreen.dart';
import 'package:projecto_registagro/pages/Autentications-Page/loginScreen/login.dart';
import 'package:projecto_registagro/pages/Autentications-Page/screenRegist/screenRegist.dart';
import 'pages/Onboarding-Pages/onboarding.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:page_transition/page_transition.dart';

void main() {
  runApp(const MyApp());
  
}
class MyApp extends StatelessWidget {
  const MyApp({super.key}); 
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          routes: {
            "/": (context) => Onboarding(),
            "/Homescreen": (context) => Homescreen(),
            "/Login": (context) => Login()
          },
        );
      }
    );
  }
}