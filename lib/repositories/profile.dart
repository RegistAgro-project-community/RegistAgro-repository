import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:projecto_registagro/components/TopNotifications/top_notification.dart';
import 'package:projecto_registagro/repositories/products.dart';
import 'package:projecto_registagro/repositories/storage.dart';
import 'package:projecto_registagro/view/auth/homeScreen/homescreen.dart';
import 'package:projecto_registagro/view/pages/userProfile/userModal/user_modal.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Profile {
  logout(BuildContext context) async {
    final tokenClass = TokenStorage();
    final logoutResult = await tokenClass.logout();

    if (logoutResult.containsKey('message')) {
      if (!context.mounted) return;
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext dialogContext) {
          return const Center(
            child: CircularProgressIndicator(
              color: Colors.white,
              strokeWidth: 2,            
            ));
        },
      );

      await Future.delayed(const Duration(milliseconds: 1000));

      showTopNotification(
        context,
        title: "Sucess",
        description: "Sessão terminada com sucesso",
        backgroundColor: Colors.green,
        icon: Icons.verified,
      );

      final prefes = await SharedPreferences.getInstance();
      prefes.setString("last_route", '/');

      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => Homescreen()),
        (route) => false,
      );
    } else {
      showTopNotification(
        context,
        title: "Error",
        description: "Não foi possível fazer terminar sessão",
        backgroundColor: Colors.amber,
        icon: Icons.error_outline,
      );
    }
  }

  Future<UserModel> userData(BuildContext context, {bool showLoading = true}) async {
    if(showLoading){
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) => const Center(
          child: CircularProgressIndicator(
            color: Colors.white,
            strokeWidth: 2,           
          )),
      );
    }

    try {
      final tokenMap = await TokenStorage().readToken();

      if (tokenMap.containsKey("error") || tokenMap["token"] == null) {
        ProductsRepositories().handleAuthError(
          context,
          tokenMap['error'] ?? "Faça login novamente",
        );

        throw Exception("Error");
      }

      final dio = Dio(
        BaseOptions(
          headers: {
            "content-type": "application/json",
            "authorization": "Bearer ${tokenMap["token"]}",
          },
        ),
      );

      final res = await dio.get(
        "https://api-registagro.onrender.com/users/profile",
      );

      if(showLoading && context.mounted){
        Navigator.of(context).pop();
      }

      final data = res.data["data"];

      return UserModel(
        name: data['name'],
        email: data['email'],
        phone: data['phone'],
        bio: "bio",
        province: data['province'],
        adress: data['adress'],
        photoPath: data['profile']
      );
    } on DioException catch (e) {
      if(showLoading && context.mounted){
        Navigator.of(context, rootNavigator: true).pop();
      }

      String message = "Erro ao carregar produtos";

      if (e.response?.statusCode == 401 || e.response?.statusCode == 403) {
        message = e.response?.data?['error'] ?? 'Sessão expirada';

        ProductsRepositories().handleAuthError(context, message);
      } else {
        message =
            e.response?.data?['error'] ??
            e.response?.data?['info'] ??
            e.message ??
            message;

        e.response?.data["error"] != null || e.response?.data["info"] != null
            ? showTopNotification(
                context,
                title: "Error",
                description: message,
                backgroundColor: Colors.red.shade700,
                icon: Icons.error_outline,
              )
            : print(message);
        rethrow;
      }

      throw Exception(message);
    } catch (e) {
      if(showLoading && context.mounted){
        Navigator.of(context).pop();
      }

      ProductsRepositories().handleAuthError(
        context,
        "Ocorreu um erro inesperado",
      );

      throw Exception("Error");
    }
  }
}
