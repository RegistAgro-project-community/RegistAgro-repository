import 'package:flutter/material.dart';
import 'package:projecto_registagro/pages/Autentications-Page/components/button_logoText/button_logoText.dart';
import 'package:projecto_registagro/pages/Autentications-Page/components/inputText/input.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  final _emailCtrl = TextEditingController();
  final _passCtrl = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

    final List<Map<String, String>> users = [
      {"email": "elias.matingo@gmail.com", "password": "@Anselmo98"},
      {"email": "claudio.cassoma@gmail.com", "password": "@cassoma777"},
      {"email": "leocania.melo@gmail.com", "password": "@melo123"},
      {"email": "debora.francisco@gmail.com", "password": "@francisco90"},
      {"email": "ildeberto.vasconcelos@gmail.com", "password": "@vasconcelos"},
    ];

  @override
  void dispose() {
    _emailCtrl.dispose();
    _passCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 24.h),
                  Text(
                    'Bem-vindo de volta!',
                    style: TextStyle(fontSize: 28.sp, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    'Faça login na sua conta \ne agroconecta-te',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16.sp, color: Colors.black54),
                  ),
                  SizedBox(height: 24.h),
                  Input(
                    controller: _emailCtrl,
                    keyboardType: TextInputType.emailAddress,
                    placeholder: "NIF / Email",
                    icon: Icons.alternate_email,
                    validator: (input) => input == null || input.isEmpty ? 'Informe o email' : null,
                  ),
                  SizedBox(height: 12.h),
                  Input(
                    controller: _passCtrl,
                    keyboardType: TextInputType.visiblePassword,
                    placeholder: "Senha",
                    icon: Icons.lock,
                    validator: (input) => input == null || input.isEmpty ? 'Informe a senha' : null,
                  ),
                  SizedBox(height: 8.h),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {},
                      child: Text(
                        'Esqueci a minha senha',
                        style: TextStyle(
                          color: Color(0xFF61983D),
                          fontSize: 17.sp,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 16.h),
                  ButtonLogotext(
                    onPressed: () {
                      final email = _emailController.text.trim();
                      final password = _passwordController.text.trim();
                      bool validUser  = users.any((user) => user['email'] == email && user['password'] == password);
                      if (_formKey.currentState?.validate() ?? false) {
                        // realizar login
                      }



                        if(validUser){
                          print("Enter to new page");
                        }else{
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                "Email ou senha inválidos!",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15.sp, 
                                  fontWeight: FontWeight.bold
                                ),
                              ),
                                backgroundColor: Colors.red,
                                behavior: SnackBarBehavior.floating,
                              )
                          );
                        }
                      },
                            
                    tilte: "Entrar",
                  ),
                  SizedBox(height: 8.h),
                  Align(
                    alignment: Alignment.center,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Não tem uma conta?", style: TextStyle(color: Colors.grey, fontSize: 17.sp, fontWeight: FontWeight.w400),),
                        TextButton(
                          onPressed: () {},
                          child: Text(
                            'Criar conta',
                            style: TextStyle(
                              color: Color(0xFF61983D),
                              fontSize: 17.sp,
                              fontWeight: FontWeight.bold
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
        ),
      );
  }
}