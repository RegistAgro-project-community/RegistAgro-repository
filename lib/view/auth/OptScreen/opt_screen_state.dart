// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'package:elegant_notification/elegant_notification.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:projecto_registagro/repositories/auth/signup.dart';
import 'package:projecto_registagro/view/auth/signUp/signup.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({super.key});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  String otpCode = "";
  bool isLoading = false;

  int resendCounter = 60;
  bool canResend = false;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    startResendTimer();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void startResendTimer() {
    setState(() {
      resendCounter = 60;
      canResend = false;
    });

    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (resendCounter <= 1) {
        timer.cancel();
        setState(() {
          canResend = true;
          resendCounter = 0;
        });
      } else {
        setState(() {
          resendCounter--;
        });
      }
    });
  }

  void validateOtp() async {
    if (otpCode.length != 6 || isLoading) return;

    setState(() {
      isLoading = true;
    });

    await Future.delayed(const Duration(seconds: 2));

    bool otpIsCorrect = otpCode == "123456";

    setState(() {
      isLoading = false;
    });

    if (otpIsCorrect) {
      ElegantNotification.success(
        title: Text("Sucesso"),
        description: Text("Operação concluída com êxito!"),
        height: 80,
      ).show(context);

      Future.delayed(const Duration(seconds: 1), () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const Signup()),
        );
      });
    } else {
      ElegantNotification.error(
        title: Text("Erro"),
        description: Text("Código incorreto. Por favor, tente novamente!"),
        height: 80,
      ).show(context);
    }
  }
  
  void resendCode() async {
    if (!canResend) return;
    ElegantNotification.info(
      title: Text("Código reenviado"),
      description: Text("Um novo OTP foi enviado para o seu email."),
      height: 80,
    ).show(context);

    startResendTimer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image(
                image: AssetImage("assets/images/icone.png"),
                height: 100.0.h,
                width: 100.0.w,
                fit: BoxFit.cover,
              ),
              Text(
                "RegistAgro",
                style: TextStyle(
                  color: Color.fromARGB(255, 110, 173, 68),
                  fontSize: 25.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 30),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: PinCodeTextField(
                  appContext: context,
                  length: 6,
                  cursorColor: Colors.green,
                  keyboardType: TextInputType.number,
                  animationType: AnimationType.fade,
                  onChanged: (value) {
                    setState(() {
                      otpCode = value;
                    });
                  },
                  onCompleted: isLoading 
                  ? null 
                  : (value) async {
                    setState(() => isLoading = true);
                    otpCode = value;

                    final signupClass = SignupValidations();

                    await signupClass.validateOtp(context, otpCode);

                    if (!mounted) return;
                    setState(() => isLoading = false);
                  },
                  pinTheme: PinTheme(
                    shape: PinCodeFieldShape.box,
                    borderRadius: BorderRadius.circular(10),
                    fieldHeight: 50,
                    fieldWidth: 50,
                    activeFillColor: Colors.green.shade100,
                    inactiveFillColor: Colors.green.shade50,
                    selectedFillColor: Colors.green.shade200,
                    inactiveColor: Colors.grey,
                    selectedColor: Colors.green,
                    activeColor: Colors.green,
                  ),
                ),
              ),
              SizedBox(height: 40),
              SizedBox(
                width: MediaQuery.sizeOf(context).width * 0.8.w,
                height: 40.h,
                child: ElevatedButton(
                  onPressed: isLoading 
                  ? null 
                  : () async {

                    setState(() => isLoading = true);

                    final signupClass = SignupValidations();

                    await signupClass.validateOtp(context, otpCode);
                    
                    if (!mounted) return;
                    setState(() => isLoading = false);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: isLoading ? null : const Color(0xFF61983D),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    elevation: 0,
                  ),
                  child: isLoading
                      ? SizedBox(
                          height: 22,
                          width: 22,
                          child: CircularProgressIndicator(
                            strokeWidth: 3,
                            color: Color(0xFF61983D),
                          ),
                        )
                      : Text(
                          "Continuar",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 17.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                ),
              ),
              SizedBox(height: 20),
              TextButton(
                onPressed: canResend ? resendCode : null,
                child: Text(
                  canResend
                      ? "Reenviar código"
                      : "Reenviar em $resendCounter s",
                  style: TextStyle(
                    color: canResend ? Colors.blue : Colors.grey,
                    fontSize: 14.sp,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
