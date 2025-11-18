import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:projecto_registagro/pages/Autentications-Page/loginScreen/login.dart';
import 'package:page_transition/page_transition.dart';
import 'package:projecto_registagro/pages/Autentications-Page/signUp/signUp.dart';
import 'package:projecto_registagro/shared/buttom_logoText/button_logoTest.dart';

class LogoText extends StatelessWidget {
  const LogoText({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image(
          image: AssetImage("assets/images/icone.png"),
          height: 200.0.h,
          width: 200.0.w,
          fit: BoxFit.cover,

        ),
        Text(
          "RegistAgro",
          style: TextStyle(
            color: Color.fromARGB(255, 110, 173, 68),
            fontSize: 25.sp,
            fontWeight: FontWeight.bold
            ),
        ),
        SizedBox(height: 10.h),
        Text(
          "Seu mercado de confiança para \nprodutos frescos e locais",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 18.sp,
            color: Colors.grey[300]
          ),
        ),
        SizedBox(height: MediaQuery.sizeOf(context).height * (.3 + .07),),
        ButtonLogotext(
          tilte: "Entrar",
          onPressed: () => {
            Navigator.pushReplacement(
              context, 
              PageTransition(
                type: PageTransitionType.rightToLeft,
                child: Login(),
                duration: Duration(milliseconds: 350)
              )
            )
          },
        ),
        SizedBox(height: 10.h),
        ButtonLogotext(
          tilte: "Criar conta",
          color: Color(0xFF61983D),
          backgroundColor: Colors.transparent,
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
        )

      ],
    );
  }
}