import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:page_transition/page_transition.dart';
import 'package:projecto_registagro/pages/Autentications-Page/homeScreen/homescreen.dart';
import 'package:projecto_registagro/pages/Autentications-Page/signUp/signup.dart';
import 'package:projecto_registagro/shared/arraow_back/arrow_back.dart';
import 'package:projecto_registagro/shared/buttom_logoText/button_logotest.dart';
import 'package:projecto_registagro/shared/formInput/input.dart';
import 'package:projecto_registagro/shared/imageLogo/imagelogo.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  final _emailCtrl = TextEditingController();
  final _passwordCtrl = TextEditingController();
  bool isObscure = true;
  

    final List<Map<String, String>> users = [
      {"email": "elias.matingo@gmail.com", "password": "@Anselmo98"},
      {"email": "claudio.cassoma@gmail.com", "password": "@cassoma777"},
      {"email": "leocania.melo@gmail.com", "password": "@melo123"},
      {"email": "debora.francisco@gmail.com", "password": "@francisco90"},
      {"email": "ildeberto.vasconcelos@gmail.com", "password": "@vasconcelos"},
    ];

    void _toggleObscure(){
      setState(() {
        isObscure = !isObscure;
      });
    }

  @override
  void dispose() {
    _emailCtrl.dispose();
    _passwordCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
     resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: ArrowBack(
          onPressed: ()  {
            Navigator.pushReplacement(
              context, 
              PageTransition(
                type: PageTransitionType.leftToRight,
                child: Homescreen(),
                duration: Duration(milliseconds: 350)
              )
            );
          },
        ),
      ),
      body: KeyboardVisibilityBuilder(
       builder: (context, isKeyboardVisible){
        return AnimatedContainer(
          duration: Duration(milliseconds: 250),
          padding: EdgeInsets.only(
            bottom: isKeyboardVisible ? 20.h : 0.h,
          ),
          child: SingleChildScrollView(
            child: Center(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Column(
                  children: [
                    Imagelogo(
                      height: 150.h,
                    ),
                    SizedBox(height: 24.h),
                    Text(
                      'Bem-vindo!',
                      style: TextStyle(fontSize: 28.sp, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      'Faça login na sua conta \ne agroconecta-te',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 16.sp, color: Colors.black54),
                    ),
                    SizedBox(height: 24.h),
                    Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          Input(
                            controller: _emailCtrl,
                            keyboardType: TextInputType.emailAddress,
                            isObscure: false,
                            placeholder: "Insira o seu NIF",
                            labelText: "NIF",
                            icon: Icons.alternate_email,
                            onChanged: (value) {
                              _emailCtrl.value =  TextEditingValue(
                                text: value.toLowerCase(),
                                selection: TextSelection.collapsed(offset: value.length)
                              );
                            },
                            validator: (input) => input == null || input.isEmpty ? 'Informe o email' : null,
                          ),
                          SizedBox(height: 12.h),
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
                            validator: (input) => input == null || input.isEmpty ? 'Informe a senha' : null,
                          ),
                        ],
                        ),
                    ),
                      
                    SizedBox(height: 16.h),
                    ButtonLogotext(
                      borderRadius: BorderRadius.circular(12.r),
                      padding: EdgeInsets.symmetric(horizontal: 0),
                      onPressed: () {
        
                        final email = _emailCtrl.text.trim();
                        final password = _passwordCtrl.text.trim();
        
                        if (_formKey.currentState!.validate()) {
                          bool validUser  = users.any((user) => 
                          user['email'] == email && user['password'] == password);
                          if(validUser){}
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
                          Text("Não tem uma conta?", style: TextStyle(color: Colors.grey, fontSize: 15.sp, fontWeight: FontWeight.w400),),
                          TextButton(
                            onPressed: () => {
                              Navigator.pushReplacement(
                               context,
                               PageTransition(
                                type: PageTransitionType.rightToLeft,
                                child: Signup(),
                                duration: Duration(milliseconds: 350)
                               ) 
                              )
                            },
                            child: Text(
                              'Criar conta',
                              style: TextStyle(
                                color: Color(0xFF61983D),
                                fontSize: 15.sp,
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
      ),
        );
      }
}