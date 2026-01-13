import 'dart:async';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:projecto_registagro/pages/login/widgets/init_state.dart';

import 'login_steps.dart';
import 'login_state.dart';
import 'widgets/step_insertnif.dart';
import 'widgets/step_confirmar.dart';
import 'widgets/step_access_key.dart';
import 'widgets/step_loading_password.dart';
import 'widgets/step_insert_password.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  LoginState state = LoginState();
  Timer? timer;
  bool isLoading = false;
  bool isTrue = false;

  void _next(AcessoStep step) {
    setState(() {
      state = state.copyWith(step: step);
    });
  }

  void _startLoading() {
    timer?.cancel();
    state = state.copyWith(messageIndex: 0);
    setState(() {});
    timer = Timer.periodic(const Duration(seconds: 2), (t) {
      if (state.messageIndex < state.mensagens.length - 1) {
        setState(() {
          state = state.copyWith(
            messageIndex: state.messageIndex + 1,
          );
        });
      } else {
        t.cancel();
        Future.delayed(const Duration(seconds: 1), () {
          _next(AcessoStep.insertPassword);
        });
      }
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  Widget _buildStep() {
    switch (state.step) {
      case AcessoStep.initState:
        return InitState(
          isLoading: state.isLoading, 
          onConsumidor: () => _next(AcessoStep.insertNIF), 
          onMotorista: () {},
          onLoadingChanged:  (loading) {
              setState(() {
                state = state.copyWith(isLoading: loading);
              });
            }
          );

      case AcessoStep.insertNIF:
        return StepInsertNIF(
          isLoading: state.isLoading,              
          onContinuar: () => _next(AcessoStep.confirmar),
          onLoadingChanged: (loading) {            
            setState(() {
              state = state.copyWith(isLoading: loading);
            });
          },
        );

      case AcessoStep.confirmar:
        return StepConfirmar(
          onConfirmar: () async {
            _next(AcessoStep.acessKey);
            
          },
        );

      case AcessoStep.acessKey:
        return StepAccessKey(
          onLoadingChange: (loading) =>{
            setState(() {
              state = state.copyWith(isLoading: loading);
            })
          } ,
          onNext: () async {
            _next(AcessoStep.loadingPassword);
            _startLoading();
          },
        );

      case AcessoStep.loadingPassword:
        return StepLoadingPassword(
          message: state.mensagens[state.messageIndex],
        );

      case AcessoStep.insertPassword:
        return StepInsertPassword(
          onFinish: () => Navigator.pop(context),
        );
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 5, 110, 9),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset("assets/images/logobranca.png", height: 100),
            const SizedBox(height: 18),
            const Text(
              "Bem-vindo ao RegistAgro",
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: MediaQuery.of(context).size.width * .9,
              height: 40,
              child: ElevatedButton(
                onPressed: () {
                  showModalBottomSheet(
                    context: context,
                    backgroundColor: Colors.transparent,
                    isScrollControlled: true,
                    builder: (_) => BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
                      child: AnimatedSwitcher(
                        duration: const Duration(milliseconds: 300),
                        child: _buildStep(),
                      ),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: const Color.fromARGB(255, 5, 110, 9),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: isLoading
                  ? const SizedBox(
                      width: 24,
                      height: 24,
                      child: CircularProgressIndicator(strokeWidth: 2.5),
                    )
                  : Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset("assets/images/icone.png", height: 40,),
                      const SizedBox(width: 2),
                      const Text(
                        "Entrar com NIF",
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
              ),
            ),
          ],
        ),
      )
    );
  }
}



