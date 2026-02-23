import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:projecto_registagro/view/auth/loginScreen/login.dart';
import 'package:page_transition/page_transition.dart';
import 'package:projecto_registagro/view/auth/signUp/signup.dart';
import 'package:projecto_registagro/components/buttom_logoText/button_submit.dart';


class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  // late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    // _controller = VideoPlayerController.asset("assets/videos/Muinho.mp4")
    //   ..initialize().then((_) {
    //     setState(() {}); 
    //     _controller.play();
    //     _controller.setLooping(true); 
    //   });
  }
  // @override
  // void dispose() {
  //   _controller.dispose();
  //   super.dispose();
  // }

  imageBackground(){
    return Image(
      image: AssetImage("assets/images/sol.jpeg"),
      height: double.infinity.h,
      width: double.infinity.w,
      fit: BoxFit.cover,
    );
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          // _controller.value.isInitialized ? FittedBox(
          //   fit: BoxFit.cover,
          //   child: SizedBox(
          //     width: _controller.value.size.width,
          //     height: _controller.value.size.height,
          //     child: VideoPlayer(_controller),
          //   ),
          //   ) : Container(color: Colors.transparent,),
          imageBackground(),
            Container(
                color: Colors.black.withOpacity(0.7),
                width: double.infinity.w,
                height: double.infinity.h,
            ),
            Flexible(
              fit: FlexFit.loose,
              child: Center(
                child:  Column(
                      mainAxisAlignment: MainAxisAlignment.center,
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
                        Padding(padding: const EdgeInsets.symmetric(vertical: 150)),
                        ButtonSubmit(
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
                        ButtonSubmit(
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
                    ),
                  )
              ),
        ],
      ),
    );
  }
}