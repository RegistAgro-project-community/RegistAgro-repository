import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:page_transition/page_transition.dart';
import 'package:projecto_registagro/pages/Autentications-Page/homeScreen/homescreen.dart';
import 'package:projecto_registagro/shared/arraow_back/arrow_back.dart';
import 'package:projecto_registagro/shared/buttom_logoText/button_logoTest.dart';
import 'package:projecto_registagro/shared/formInput/input.dart';
import 'package:projecto_registagro/shared/imageLogo/imageLogo.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  bool ischecked = true;
  final _Crtl = TextEditingController();

  final List<Map<String, String>> nifs = [
      {"nif": "5402132186"},
      {"nif": "5401144440"},
      {"nif": "5401003013"},
      {"nif": "5410003594"},
      {"nif": "5420009498"},
    ];

    @override
    void dispose(){
      _Crtl.dispose();
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
            Input(
              controller: _Crtl,
              placeholder: "NIF",
              labelText: "Insira o seu NIF",
              maxLenght: 10,
              isObscure: false,
              icon: Icons.alternate_email,
              keyboardType: TextInputType.number,
              validator: (v) => v == null || v.isEmpty ? 'NIF inválido!' : null,
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
              onPressed: () {
                final nifInput = _Crtl.text.trim();
                bool validNIF = nifs.any((item) => item['nif'] == nifInput);
                if (validNIF) {
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          "Passed!",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 15.sp, 
                            fontWeight: FontWeight.bold
                          ),
                        ),
                          backgroundColor: Colors.green,
                          behavior: SnackBarBehavior.floating,
                        )
                    );
                }else{
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          "NIF inválido!",
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
            ),
            SizedBox(height: 20,),
            Align(
              alignment: Alignment.center,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Já tem uma conta?", style: TextStyle(color: Colors.grey, fontSize: 17.sp, fontWeight: FontWeight.w400),),
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      'Entrar',
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
    );
  }
}