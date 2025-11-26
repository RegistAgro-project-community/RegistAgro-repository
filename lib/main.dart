import 'package:flutter/material.dart';
import 'package:projecto_registagro/pages/Autentications-Page/homeScreen/homescreen.dart';
import 'package:projecto_registagro/pages/Autentications-Page/loginScreen/login.dart';
import 'package:projecto_registagro/pages/Autentications-Page/screenRegist/screenregist.dart';
import 'package:projecto_registagro/pages/Autentications-Page/signUp/signup.dart';
import 'package:projecto_registagro/pages/Autentications-Page/transport/screentransport.dart';
import 'pages/Onboarding-Pages/onboarding.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
            "/Login": (context) => Login(),
            "/Signup": (context) => Signup(),
            "/Screenregist": (context) => Screenregist(),
            "/Screentransport": (context) => Screentransport()
          },
        );
      }
    );
  }
}