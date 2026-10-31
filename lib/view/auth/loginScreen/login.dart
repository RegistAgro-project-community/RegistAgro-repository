import 'package:elegant_notification/elegant_notification.dart';
import 'package:elegant_notification/resources/arrays.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:flutter_turnstile/flutter_turnstile.dart';
import 'package:page_transition/page_transition.dart';
import 'package:projecto_registagro/config/api_config.dart';
import 'package:projecto_registagro/repositories/auth/login.dart';
import 'package:projecto_registagro/services/auth_rate_limiter.dart';
import 'package:projecto_registagro/validators/auth_validators.dart';
import 'package:projecto_registagro/view/auth/signUp/signup.dart';
import 'package:projecto_registagro/components/button_submit/button_submit.dart';
import 'package:projecto_registagro/components/formInput/input.dart';
import 'package:projecto_registagro/components/imageLogo/imagelogo.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:projecto_registagro/view/pages/main_page/main_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
  bool isLoading = false;
  String? captchaToken;

    void _toggleObscure() {
    setState(() {
      isObscure = !isObscure;
    });
  }

  void _onTurnstileToken(String? token) {
      setState(() {
        captchaToken = token;
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
            padding: EdgeInsets.only(bottom: isKeyboardVisible ? 20.h : 0.h),
            child: SingleChildScrollView(
              child: Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Column(
                    children: [
                      Imagelogo(height: 150.h),
                      SizedBox(height: 24.h),
                      Text(
                        'Bem-vindo!',
                        style: TextStyle(
                          fontSize: 28.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 8.h),
                      Text(
                        'Faça login na sua conta \ne agroconecta-se',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 16.sp,
                          color: Colors.black54,
                        ),
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
                                                    placeholder: "Insira o seu email",
                                                    labelText: "Email",
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
                                                  SizedBox(height: 12.h),
                                                  Input(
                                                    controller: _passwordCtrl,
                                                    keyboardType: TextInputType.visiblePassword,
                                                    isObscure: isObscure,
                                                    placeholder: "Insira a sua senha",
                                                    labelText: "Senha",
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

                      SizedBox(height: 16.h),
                      ButtonSubmit(
                        borderRadius: BorderRadius.circular(12.r),
                        padding: EdgeInsets.symmetric(horizontal: 0),
                        onPressed: isLoading
                            ? null
                            : () async {
                                final form = _formKey.currentState;
                                if (form == null || !form.validate()) return;

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

                                                                                                final password = _passwordCtrl.text.trim();

                                                                                                final res = await login(context, email, password, captchaToken);

                                if (!mounted) return;
                                setState(() => isLoading = false);
                                
                                // Record attempt for rate limiting
                                final success = res.containsKey('message');
                                await AuthRateLimiter.recordAttempt(email, success);

                                if (success) {
                                  ElegantNotification.success(
                                    title: Text(res['message'] ?? 'Login realizado com sucesso'),
                                    description: const Text(
                                      "Seja bem-vindo de volta!",
                                      style: TextStyle(fontFamily: 'Inter', color: Colors.grey),
                                    ),
                                    icon: const SizedBox(),
                                    height: 75,
                                    // ignore: use_build_context_synchronously
                                    width: MediaQuery.of(context).size.width * .9,
                                    animation: AnimationType.fromTop,
                                    // ignore: use_build_context_synchronously
                                  ).show(context);

                                  final prefes = await SharedPreferences.getInstance();
                                  prefes.setString('last_route', '/MainPage');
                                  
                                  Navigator.pushAndRemoveUntil(
                                    // ignore: use_build_context_synchronously
                                    context,
                                    MaterialPageRoute(builder: (context) => MainPage()),
                                    (route) => false,
                                  );
                                } else {
                                  ElegantNotification.error(
                                    title: const Text('Error'),
                                    description: Text(
                                      res['error'] ?? 'Erro ao fazer login',
                                      style: const TextStyle(fontFamily: 'Inter', color: Colors.grey),
                                    ),
                                    icon: const SizedBox(),
                                    height: 75,
                                    // ignore: use_build_context_synchronously
                                    width: MediaQuery.of(context).size.width * .9,
                                    animation: AnimationType.fromTop,
                                    // ignore: use_build_context_synchronously
                                  ).show(context);
                                }
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
                              'Entrar',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16.sp,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 1.r,
                              ),
                            ),
                      ),

                      SizedBox(height: 8.h),
                      Align(
                        alignment: Alignment.center,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Não tem uma conta?',
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 15.sp,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            TextButton(
                              onPressed: () => {
                                Navigator.pushReplacement(
                                  context,
                                  PageTransition(
                                    type: PageTransitionType.rightToLeft,
                                    child: Signup(),
                                    duration: Duration(milliseconds: 350),
                                  ),
                                ),
                              },
                              child: Text(
                                'Criar conta',
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
            ),
          );
        },
      ),
    );
      }
    }