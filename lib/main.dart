import 'package:flutter/material.dart';
import 'package:projecto_registagro/pages/login/login_home_screen/login_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:projecto_registagro/pages/Autentications-Page/homeScreen/homescreen.dart';
import 'package:projecto_registagro/pages/Autentications-Page/loginScreen/login.dart';
import 'package:projecto_registagro/pages/Autentications-Page/screenRegist/screenregist.dart';
import 'package:projecto_registagro/pages/Autentications-Page/signUp/signup.dart';
import 'package:projecto_registagro/pages/Autentications-Page/transport/screentransport.dart';
import 'pages/Onboarding-Pages/onboarding.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  final lastRoute = prefs.getString("last_route") ?? "/";

  runApp(MyApp(initialRoute: lastRoute));
}

class MyApp extends StatelessWidget {
  final String initialRoute;

  const MyApp({super.key, required this.initialRoute});

  Future<void> _saveRoute(String route) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString("last_route", route);
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          initialRoute: initialRoute,
          onGenerateRoute: (settings) {
            _saveRoute(settings.name ?? "/");
            return MaterialPageRoute(
              builder: (context) => _getPage(settings.name),
            );
          },
        );
      },
    );
  }

  Widget _getPage(String? route) {
    switch (route) {
      case "/Homescreen":
        return Homescreen();
      case "/Login":
        return Login();
      case "/Signup":
        return Signup();
      case "/Screenregist":
        return Screenregist();
      case "/Screentransport":
        return Screentransport();
      default:
        return LoginScreen();
    }
  }
}
