import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:page_transition/page_transition.dart';
import 'package:projecto_registagro/pages/Autentications-Page/homeScreen/homescreen.dart';
import 'package:projecto_registagro/pages/Autentications-Page/loginScreen/login.dart';
import 'package:projecto_registagro/pages/Autentications-Page/screenRegist/screenregist.dart';
import 'package:projecto_registagro/shared/arraow_back/arrow_back.dart';
import 'package:projecto_registagro/shared/buttom_logoText/button_logotest.dart';
import 'package:projecto_registagro/shared/formInput/input.dart';
import 'package:projecto_registagro/shared/imageLogo/imagelogo.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  bool ischecked = true;
  final _crtl = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  final List<Map<String, String>> nifs = [
      {"nif": "5402132186"},
      {"nif": "5401144440"},
      {"nif": "5401003013"},
      {"nif": "5410003594"},
      {"nif": "5420009498"},
    ];

    @override
    void dispose(){
      _crtl.dispose();
      super.dispose();
    }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: ArrowBack(
            onPressed: () => {
              Navigator.pushReplacement(
                context,
                PageTransition(
                  type: PageTransitionType.leftToRight,
                  child: Homescreen(),
                  duration: Duration(milliseconds: 350)
                )
              )
            },
          ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 100),
        child: Column(
          children: [
            
            Imagelogo(height: 150.h,),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Crie uma conta", style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold, letterSpacing: 1),),
                SizedBox(height: 8,),
                Text("Crie a sua conta na plataforma e \nagroconecta-te!", textAlign: TextAlign.center, style: TextStyle(color: Colors.grey, fontWeight: FontWeight.w400, fontSize: 18),)
              ],
            ),
            SizedBox(height: 20,),
            Form(
              key: _formKey,
              child: Column(
                children: [
                   Input(
                    controller: _crtl,
                    placeholder: "NIF",
                    labelText: "Insira o seu NIF",
                    maxLenght: 10,
                    isObscure: false,
                    readOnly: false,
                    // enabled: true,
                    showCursor: true,
                    color: Color(0xF4F4F4F4),
                    icon: Icons.alternate_email,
                    keyboardType: TextInputType.number,
                    validator: (v) {
                      if (v == null || v.isEmpty){
                        return "Por favor insira um NIF";
                      }
                      if (v.length != 10){
                        return "O NIF deve ter pelo menos 10 dígitos";
                      }
                      return null;
                    },
                  ),
                ],
            ),
            ),
           
            // Align(
            //   alignment: Alignment.centerRight,
            //   child: CheckboxListTile(
            //     value: ischecked,
            //     activeColor: Colors.green,
            //     title: const Text("Remember me", style: TextStyle(color: Colors.green, fontSize: 17, fontWeight: FontWeight.bold),),
            //     onChanged: (value) => {
            //       setState(() {
            //         ischecked = !ischecked;
            //       })
            //     },
            //     controlAffinity: ListTileControlAffinity.platform,
            //   )
            // ),
            SizedBox(height: 20,),
            ButtonLogotext(
              tilte: "Verificar NIF",
              borderRadius: BorderRadius.circular(12.r),
              padding: EdgeInsets.symmetric(horizontal: 0),
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  // Exemplo de feedback de carregamento
                  showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (context) => Center(
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
                      ),
                    ),
                  );

                  await Future.delayed(Duration(seconds: 2));

                  if (mounted) {
                    // Usei o addPostFrameCallback para garantir que a navegação aconteça no próximo ciclo de renderização
                    WidgetsBinding.instance.addPostFrameCallback((_) async {

                      Navigator.of(context).pop();

                      Navigator.pushReplacement(
                        context,
                        PageTransition(
                          type: PageTransitionType.bottomToTop,
                          child: Screenregist(),
                          duration: Duration(milliseconds: 500),
                        ),
                      );
                    });
                  }
                }
              },
            ),
            SizedBox(height: 20,),
            Align(
              alignment: Alignment.center,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Já tem uma conta?", style: TextStyle(color: Colors.grey, fontSize: 15.sp, fontWeight: FontWeight.w400),),
                  TextButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                      context,
                      PageTransition(
                        type: PageTransitionType.rightToLeft,
                        child: Login(),
                        duration: Duration(milliseconds: 350)
                      )  
                      );
                    },
                    child: Text(
                      'Entrar',
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
    );
  }
}