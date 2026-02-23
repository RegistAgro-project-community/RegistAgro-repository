import 'package:elegant_notification/elegant_notification.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:page_transition/page_transition.dart';
import 'package:projecto_registagro/view/auth/OptScreen/opt_screen_state.dart';
import 'package:projecto_registagro/view/auth/homeScreen/homescreen.dart';
import 'package:projecto_registagro/view/auth/loginScreen/login.dart';
import 'package:projecto_registagro/components/arraow_back/arrow_back.dart';
import 'package:projecto_registagro/components/buttom_logoText/button_submit.dart';
import 'package:projecto_registagro/components/formInput/input.dart';
import 'package:projecto_registagro/components/imageLogo/imagelogo.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  bool ischecked = false;
  final _crtl = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final _location = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _foneNumber = TextEditingController();
  final _passwordCtrl = TextEditingController();
  bool isObscure = true;

  final List<Map<String, String>> nifs = [
    {"nif": "5402132186"},
    {"nif": "5401144440"},
    {"nif": "5401003013"},
    {"nif": "5410003594"},
    {"nif": "5420009498"},
  ];

  @override
  void dispose() {
    _crtl.dispose();
    _emailCtrl.dispose();
    _passwordCtrl.dispose();
    super.dispose();
  }
  void _toggleObscure(){
    setState(() {
      isObscure = !isObscure;
    });
  }
  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Informe o email';
    }

    final emailRegex = RegExp(
      r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
    );

    if (!emailRegex.hasMatch(value)) {
      return 'Email inválido';
    }

    return null;
  }
  String? validateFoneNumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'Informe o seu número de tel.';
    }

    if (value.length != 9) {
      return 'O contacto deve ter exatamente 9 digítos!';
    }

    return null;
  }
  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Informe a senha';
    }

    if (value.length < 6) {
      return 'A senha deve ter no mínimo 6 caracteres';
    }

    return null;
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: ArrowBack(
          onPressed: () => {
            Navigator.pushReplacement(
              context,
              PageTransition(
                type: PageTransitionType.leftToRight,
                child: Homescreen(),
                duration: Duration(milliseconds: 350),
              ),
            ),
          },
        ),
      ),
      body: KeyboardVisibilityBuilder(
        builder: (context, isKeyboardVisible) {
          return AnimatedContainer(
            duration: Duration(milliseconds: 250),
            padding: EdgeInsets.only(
              top: isKeyboardVisible ? 30.h : 80.h,
              bottom: isKeyboardVisible ? 20.h : 80.h,
            ),
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    Imagelogo(height: 100.h),
                    Text(
                      "Get started",
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1,
                      ),
                    ),
                    SizedBox(height: 20),
                    Form(
                      key: _formKey,
                      child: Column(
                        spacing: 12,
                        children: [
                          Input(
                            controller: _crtl,
                            placeholder: "Insira o seu nome completo",
                            labelText: "Nome completo",
                            isObscure: false,
                            color: Color(0xF4F4F4F4),
                            icon: Icons.alternate_email,
                            keyboardType: TextInputType.text,
                            validator: (v) {
                              if (v == null || v.isEmpty) {
                                return "Por favor insira um Nome";
                              }
                              return null;
                            },
                          ),
                          Input(
                            controller: _foneNumber,
                            keyboardType: TextInputType.number,
                            isObscure: false,
                            placeholder: "Insira um nº de telefone",
                            labelText: "Tel",
                            icon: Icons.call,
                            validator: validateFoneNumber,
                          ),
                          Input(
                            controller: _emailCtrl,
                            keyboardType: TextInputType.emailAddress,
                            isObscure: false,
                            placeholder: "Insira o seu email",
                            labelText: "Email",
                            icon: Icons.alternate_email,
                            onChanged: (value) {
                              _emailCtrl.value =  TextEditingValue(
                                text: value.toLowerCase(),
                                selection: TextSelection.collapsed(offset: value.length)
                              );
                            },
                            validator: validateEmail,
                          ),
                          Input(
                            controller: _location,
                            placeholder: "Insira a sua localização",
                            labelText: "Localização",
                            isObscure: false,
                            color: Color(0xF4F4F4F4),
                            icon: Icons.place,
                            keyboardType: TextInputType.text,
                            validator: (v) {
                              if (v == null || v.isEmpty) {
                                return "Insira a localização, por favor!";
                              }
                              return null;
                            },
                          ),
                          Input(
                            controller: _passwordCtrl,
                            keyboardType: TextInputType.visiblePassword,
                            isObscure: isObscure,
                            placeholder: "Insira a sua senha",
                            labelText: "Senha",
                            sufixIcon: IconButton(
                              icon: Icon(
                                isObscure ? Icons.visibility : Icons.visibility_off,
                              ),
                              onPressed: _toggleObscure,
                              splashRadius: 20.r,
                            ),
                            icon: Icons.lock,
                            validator: validatePassword,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20),
                    ButtonSubmit(
                      tilte: "criar conta",
                      borderRadius: BorderRadius.circular(12.r),
                      padding: EdgeInsets.symmetric(horizontal: 0),
                      onPressed: () async {
                        final form = _formKey.currentState;
                        if (form == null) return;
                        if (!form.validate()) {
                          return;
                        }
                        showDialog(
                          context: context,
                          barrierDismissible: false,
                          builder: (BuildContext dialogContext) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          },
                        );
                        ElegantNotification.info(
                          title: Text("Enviando código"),
                          description: Text("Consulte o seu email."),
                          height: 80,
                        ).show(context);
                        await Future.delayed(const Duration(seconds: 4));
                        if (context.mounted) {
                          Navigator.of(context).pop();
                        }
                        if (context.mounted) {
                          Navigator.pushReplacement(
                            context,
                            PageTransition(
                              type: PageTransitionType.leftToRight,
                              child: const OtpScreen(),
                              duration: const Duration(milliseconds: 350),
                            ),
                          );
                        }
                      },
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Já tem uma conta?",
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.pushReplacement(
                                context,
                                PageTransition(
                                  type: PageTransitionType.rightToLeft,
                                  child: Login(),
                                  duration: Duration(milliseconds: 350),
                                ),
                              );
                            },
                            child: Text(
                              'Entrar',
                              style: TextStyle(
                                color: Color(0xFF61983D),
                                fontSize: 15.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
