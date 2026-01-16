import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:projecto_registagro/pages/login/ligin_driver/inser_BI/insert_bi.dart';
import 'package:projecto_registagro/pages/login/login_consumidor/widgets/initState/init_state.dart';
import '../loginSteps/login_steps.dart';
import '../login_consumidor/awaitState/login_state.dart';
import '../login_consumidor/widgets/EnterNIF/step_insertnif.dart';
import '../login_consumidor/widgets/ConfirmPersonalData/step_confirmar.dart';
import '../login_consumidor/widgets/createPassword/step_access_key.dart';
import '../login_consumidor/widgets/AwaitLoading/step_loading_password.dart';
import '../login_consumidor/widgets/validaçãoFinal/step_insert_password.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  LoginState _state = LoginState();
  bool _isLoading = false;

  void nextStep(AcessoStep newStep) {
    if (!mounted) return;
    setState(() {
      _state = _state.copyWith(step: newStep);
    });
  }

  void _updateLoading(bool loading) {
    if (!mounted) return;
    setState(() {
      _state = _state.copyWith(isLoading: loading);
      _isLoading = loading;
    });
  }

  Future<void> _openLoginModal() async {
    setState(() => _isLoading = true);

    try {
      await showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        builder: (modalContext) {
          return _LoginModalFlow(
            initialState: _state,
            onStateChange: (newState) {
              if (!mounted) return;
              setState(() => _state = newState);
            },
            onLoadingChange: _updateLoading,
            onFinish: () {
              if (!mounted) return;
              setState(() => _isLoading = false);
              Navigator.pop(modalContext);
            },
          );
        },
      );
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro ao iniciar sessão: $e')),
      );
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
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
            const SizedBox(height: 32),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.9,
              height: 48,
              child: ElevatedButton(
                onPressed: _isLoading ? null : _openLoginModal,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: const Color.fromARGB(255, 5, 110, 9),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: _isLoading
                    ? const SizedBox(
                        width: 24,
                        height: 24,
                        child: CircularProgressIndicator(
                          strokeWidth: 2.5,
                        ),
                      )
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset("assets/images/icone.png", height: 40),
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
      ),
    );
  }
}

class _LoginModalFlow extends StatefulWidget {
  final LoginState initialState;
  final ValueChanged<LoginState> onStateChange;
  final ValueChanged<bool> onLoadingChange;
  final VoidCallback onFinish;

  const _LoginModalFlow({
    required this.initialState,
    required this.onStateChange,
    required this.onLoadingChange,
    required this.onFinish,
  });

  @override
  State<_LoginModalFlow> createState() => _LoginModalFlowState();
}

class _LoginModalFlowState extends State<_LoginModalFlow> {
  late LoginState _currentState;

  @override
  void initState() {
    super.initState();
    _currentState = widget.initialState;
  }

  void _updateState(LoginState newState) {
    setState(() {
      _currentState = newState;
    });
    widget.onStateChange(newState);
  }

  void _startLoadingMessages() async {
    for (int i = 0; i < _currentState.mensagens.length; i++) {
      _updateState(
        _currentState.copyWith(
          messageIndex: i,
          step: AcessoStep.loadingPassword,
        ),
      );
      await Future.delayed(const Duration(seconds: 4));
    }
    _updateState(
      _currentState.copyWith(
        step: AcessoStep.insertEmailCode,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
        child: SafeArea(
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 400),
            child: _buildCurrentStep(),
          ),
        ),
      ),
    );
  }


  Widget _buildCurrentStep() {
    switch (_currentState.step) {
      case AcessoStep.initState:
        return buildInitState(
          () => _updateState(_currentState.copyWith(step: AcessoStep.insertNIF)),
          () {},
        );
      case AcessoStep.insertBI:
        return StepInsertBI (
          isLoading: _currentState.isLoading,
          onContinuar: () => 
            _updateState(_currentState.copyWith(step: AcessoStep.confirmar)),
          onLoadingChanged: widget.onLoadingChange,

        );
      case AcessoStep.insertNIF:
        return StepInsertNIF(
          isLoading: _currentState.isLoading,
          onContinuar: () =>
              _updateState(_currentState.copyWith(step: AcessoStep.confirmar)),
          onLoadingChanged: widget.onLoadingChange,
        );

      case AcessoStep.confirmar:
        return StepConfirmar(
          onConfirmar: () async {
            _updateState(_currentState.copyWith(step: AcessoStep.acessKey));
          },
        );

      case AcessoStep.acessKey:
        return StepAccessKey(
          isLoading: _currentState.isLoading,
          onNext: () {
            _startLoadingMessages();
          },
          onLoadingChange: widget.onLoadingChange,
        );

      case AcessoStep.loadingPassword:
        return StepLoadingPassword(
          message: _currentState.mensagens[_currentState.messageIndex],
        );

      case AcessoStep.insertEmailCode:
        return StepInsertPassword(
          onFinish: widget.onFinish,
        );
    }
  }
}