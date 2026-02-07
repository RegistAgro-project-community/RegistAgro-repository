import 'package:flutter/material.dart';
import 'package:projecto_registagro/view/login-signup/OptScreen/opt_screen_state.dart';
import 'package:projecto_registagro/view/pages/MyOrders/my_orders.dart';
import 'package:projecto_registagro/view/pages/main_page/main_page.dart';
import 'package:projecto_registagro/view/pages/userProfile/profile.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:projecto_registagro/view/login-signup/homeScreen/homescreen.dart';
import 'package:projecto_registagro/view/login-signup/loginScreen/login.dart';
import 'package:projecto_registagro/view/login-signup/signUp/signup.dart';
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
      case "/Login":
        return Login();
      case "/MainPage":
        return MainPage();
      case "/Signup":
        return Signup();
      default:
        return Homescreen();
    }
  }
}
