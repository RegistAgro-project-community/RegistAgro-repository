import 'package:elegant_notification/elegant_notification.dart';
import 'package:elegant_notification/resources/arrays.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_turnstile/flutter_turnstile.dart';
import 'package:page_transition/page_transition.dart';
import 'package:projecto_registagro/config/api_config.dart';
import 'package:projecto_registagro/repositories/auth/signup.dart';
import 'package:projecto_registagro/services/auth_rate_limiter.dart';
import 'package:projecto_registagro/validators/auth_validators.dart';
import 'package:projecto_registagro/view/auth/loginScreen/login.dart';
import 'package:projecto_registagro/components/button_submit/button_submit.dart';
import 'package:projecto_registagro/components/formInput/input.dart';
import 'package:projecto_registagro/components/imageLogo/imagelogo.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  bool ischecked = false;
  final _name = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final _province = TextEditingController();
  final _location = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _foneNumber = TextEditingController();
  final _passwordCtrl = TextEditingController();
  final _passwordConfirm = TextEditingController();
  bool isObscure = true;
  bool isObscureConfirm = true;
  bool isLoading = false;
  String? captchaToken;

    @override
  void dispose() {
    _name.dispose();
    _emailCtrl.dispose();
    _passwordCtrl.dispose();
    _passwordConfirm.dispose();
    super.dispose();
  }

  void _toggleObscure() {
    setState(() {
      isObscure = !isObscure;
    });
  }
  void _toggleObscureConfirm() {
    setState(() {
      isObscureConfirm = !isObscureConfirm;
    });
  }

  void _onTurnstileToken(String? token) {
      setState(() {
        captchaToken = token;
      });
    }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
              Icons.arrow_back_ios_new, color: const Color(0xFF61983D)
            ),
          onPressed: () => Navigator.pop(context),
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
                      'Informe seus dados',
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
                            controller: _name,
                            placeholder: 'Insira o seu nome completo',
                            labelText: 'Nome completo',
                            isObscure: false,
                            color: Color(0xF4F4F4F4),
                            icon: Icons.alternate_email,
                            keyboardType: TextInputType.text,
                            validator: (v) {
                              if (v == null || v.isEmpty) {
                                return 'Por favor insira um Nome';
                              }
                              return null;
                            },
                          ),
                          Input(
                            controller: _foneNumber,
                            keyboardType: TextInputType.number,
                            isObscure: false,
                            placeholder: 'Insira um nº de telefone',
                            labelText: 'Telefone',
                            icon: Icons.call,
                            validator: AuthValidators.validatePhone,
                          ),
                          Input(
                            controller: _emailCtrl,
                            keyboardType: TextInputType.emailAddress,
                            isObscure: false,
                            placeholder: 'Insira o seu email',
                            labelText: 'Email',
                            icon: Icons.alternate_email,
                            onChanged: (value) {
                              _emailCtrl.value = TextEditingValue(
                                text: value.toLowerCase(),
                                selection: TextSelection.collapsed(
                                  offset: value.length,
                                ),
                              );
                            },
                            validator: AuthValidators.validateEmail,
                          ),
                          Input(
                            controller: _province,
                            placeholder: 'Insira a sua província',
                            labelText: 'Província',
                            isObscure: false,
                            color: Color(0xF4F4F4F4),
                            icon: Icons.place,
                            keyboardType: TextInputType.text,
                            validator: (v) {
                              if (v == null || v.isEmpty) {
                                return 'Este campo é obrigatório!';
                              }
                              return null;
                            },
                          ),
                          Input(
                            controller: _location,
                            placeholder: 'Município, Bairro, Rua',
                            labelText: 'Localização',
                            isObscure: false,
                            color: Color(0xF4F4F4F4),
                            icon: Icons.place,
                            keyboardType: TextInputType.text,
                            validator: (v) {
                              if (v == null || v.isEmpty) {
                                return 'Este campo é obrigatório!';
                              }
                              return null;
                            },
                          ),
                          Input(
                            controller: _passwordCtrl,
                            keyboardType: TextInputType.visiblePassword,
                            isObscure: isObscure,
                            placeholder: 'Insira a sua senha',
                            labelText: 'Senha',
                            sufixIcon: IconButton(
                              icon: Icon(
                                isObscure
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                              ),
                              onPressed: _toggleObscure,
                              splashRadius: 20.r,
                            ),
                            icon: Icons.lock,
                            validator: AuthValidators.validatePassword,
                          ),
                          Input(
                            controller: _passwordConfirm,
                            keyboardType: TextInputType.visiblePassword,
                            isObscure: isObscureConfirm,
                            placeholder: 'Confirma sua senha',
                            labelText: 'Senha',
                            sufixIcon: IconButton(
                              icon: Icon(
                                isObscureConfirm
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                              ),
                              onPressed: _toggleObscureConfirm,
                              splashRadius: 20.r,
                            ),
                            icon: Icons.lock,
                            validator: AuthValidators.validatePassword,
                          ),
                          // Turnstile CAPTCHA
                                                    CloudFlareTurnstile(
                                                      siteKey: ApiConfig.turnstileSiteKey,
                                                      action: 'auth',
                                                      onTokenReceived: _onTurnstileToken,
                                                      options: TurnstileOptions(
                                                        theme: TurnstileTheme.light,
                                                        language: 'pt',
                                                      ),
                                                    ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20),
                    ButtonSubmit(
                      borderRadius: BorderRadius.circular(12.r),
                      padding: EdgeInsets.symmetric(horizontal: 0),
                      onPressed: isLoading
                      ? null
                      : () async {
                          final form = _formKey.currentState;
                          if (form == null) return;
                          if (!form.validate()) {
                            return;
                          }

                          // Check Turnstile token
                                                                              if (captchaToken == null || captchaToken!.isEmpty) {
                            if (mounted) {
                              ElegantNotification.error(
                                title: const Text('Verificação necessária'),
                                description: Text(
                                  'Complete o desafio de segurança.',
                                  style: const TextStyle(fontFamily: 'Inter', color: Colors.grey),
                                ),
                                icon: const SizedBox(),
                                height: 75,
                                width: MediaQuery.of(context).size.width * .9,
                                animation: AnimationType.fromTop,
                              ).show(context);
                            }
                            return;
                          }

                          // Rate limit check
                          final email = _emailCtrl.text.trim();
                          final canAttempt = await AuthRateLimiter.canAttempt(email);
                          if (!canAttempt) {
                            final mins = await AuthRateLimiter.getRemainingMinutes(email);
                            if (mounted) {
                              ElegantNotification.error(
                                title: const Text('Bloqueado'),
                                description: Text(
                                  'Muitas tentativas. Tente em $mins min.',
                                  style: const TextStyle(fontFamily: 'Inter', color: Colors.grey),
                                ),
                                icon: const SizedBox(),
                                height: 75,
                                width: MediaQuery.of(context).size.width * .9,
                                animation: AnimationType.fromTop,
                              ).show(context);
                            }
                            return;
                          }

                          setState(() => isLoading = true);

                                                    // Check Turnstile token
                                                    if (captchaToken == null || captchaToken!.isEmpty) {
                                                      if (mounted) {
                                                        ElegantNotification.error(
                                                          title: const Text('Verificação necessária'),
                                                          description: Text(
                                                            'Complete o desafio de segurança.',
                                                            style: const TextStyle(fontFamily: 'Inter', color: Colors.grey),
                                                          ),
                                                          icon: const SizedBox(),
                                                          height: 75,
                                                          width: MediaQuery.of(context).size.width * .9,
                                                          animation: AnimationType.fromTop,
                                                        ).show(context);
                                                      }
                                                      setState(() => isLoading = false);
                                                      return;
                                                    }

                                                    final signupClass = SignupValidations(
                            name:  _name.text,
                            email:  _emailCtrl.text,
                            phone:  _foneNumber.text,
                            province:  _province.text,
                            adress:  _location.text,
                            pass1:  _passwordCtrl.text,
                            pass2:  _passwordConfirm.text,
                            captchaToken: captchaToken,
                          );

                          await signupClass.sendEmail(context);

                          // Record attempt for rate limiting
                          final success = false; // Signup doesn't return success immediately, OTP needed
                          await AuthRateLimiter.recordAttempt(email, success);

                          if (!mounted) return;
                          setState(() => isLoading = false);
                        },
                      child: isLoading
                          ? SizedBox(
                              width: 22.w,
                              height: 22.h,
                              child: CircularProgressIndicator(
                                color: Color(0xFF61983D),
                                strokeWidth: 3,
                              ),
                            )
                          : Text(
                              'Criar conta',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.w500
                              ),
                            ),
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Já tem uma conta?',
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
