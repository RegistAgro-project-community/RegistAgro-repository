import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:page_transition/page_transition.dart';
import 'package:projecto_registagro/pages/Autentications-Page/screenRegist/text.dart';
import 'package:projecto_registagro/pages/Autentications-Page/transport/screentransport.dart';
import 'package:projecto_registagro/shared/buttom_logoText/button_logotest.dart';
import 'package:projecto_registagro/shared/formInput/input.dart';

class Screenregist extends StatefulWidget {
  const Screenregist({super.key});

  @override
  State<Screenregist> createState() => _ScreenregistState();
}


class _ScreenregistState extends State<Screenregist> {
  final _nameEpCrtl = TextEditingController();
  final _foneNumberCrtl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _locationCrtl =TextEditingController();
  final _passwordCtrl = TextEditingController();
  final _confirmpasswordCrtl = TextEditingController();
  String selectedOption = "";

  bool isObscure = true;

  void _toggleObscure(){
    setState(() {
      isObscure = !isObscure;
    });
  }

  @override
  void dispose() {
    _nameEpCrtl.dispose();
    _foneNumberCrtl.dispose();
    _emailCtrl.dispose();
    _locationCrtl.dispose();
    _passwordCtrl.dispose();
    _confirmpasswordCrtl.dispose();
    super.dispose();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
     appBar: AppBar(
      
        title: Text(
          "Dados da empresa",
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
        ),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(2),
          child: Container(
            color: Colors.green,
            width: double.infinity, 
            height: 2,
          ),
        ),
      ),
      body: KeyboardVisibilityBuilder(
        builder: (context, isKeyboardVisible) {
          return AnimatedContainer(
            duration: Duration(milliseconds: 250),
            padding: EdgeInsets.only(
              bottom: isKeyboardVisible ? 20.h : 0.h,
            ),
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20,),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MyText(title: "Nome da empresa:"),
                    SizedBox(height: 5,),
                    Input(
                      controller: _nameEpCrtl,
                      placeholder: "Nome",
                      labelText: "Nome",
                      icon: Icons.domain,
                      readOnly: true,
                      // enabled: true,
                      showCursor: true,
                      maxLenght: 255,
                      keyboardType: TextInputType.text,
                      color: Color(0xF4F4F4F4),

                    ),
                    SizedBox(height: 20,),
                    MyText(title: "Telefone da empresa:"),
                    SizedBox(height: 5,),
                    Input(
                      controller: _foneNumberCrtl,
                      placeholder: "Telefone",
                      labelText: "Telefone",
                      icon: Icons.phone,
                      readOnly: true,
                      // enabled: true,
                      showCursor: true,
                      maxLenght: 255,
                      keyboardType: TextInputType.phone,
                      color: Color(0xF4F4F4F4),
                    ),
                    SizedBox(height: 20,),
                    MyText(title: "Email da empresa:"),
                    SizedBox(height: 5,),
                    Input(
                      controller: _emailCtrl,
                      placeholder: "Email",
                      labelText: "Email",
                      icon: Icons.email,
                      readOnly: true,
                      // enabled: true,
                      showCursor: true,
                      maxLenght: 255,
                      keyboardType: TextInputType.emailAddress,
                      color: Color(0xF4F4F4F4),
                    ),
                    SizedBox(height: 20,),
                    MyText(title: "Endereço da empresa:"),
                    SizedBox(height: 5,),
                    // DropdownButtonFormField<UserRole>(
                    //   value: values,
                    //   decoration: const InputDecoration(
                    //     labelText: 'Função',
                    //     border: OutlineInputBorder(),
                    //   ),
                    //   items: const [
                    //     DropdownMenuItem(
                    //       value: UserRole.employee,
                    //       child: Text('Colaborador'),
                    //     ),
                    //     DropdownMenuItem(
                    //       value: UserRole.driver,
                    //       child: Text('Motorista'),
                    //     ),
                    //   ],
                    //   onChanged: (role) => setState(() => _role = role!),
                    // ),
                    SizedBox(height: 20,),
                    Input(
                      controller: _passwordCtrl,
                      placeholder: "Senha",
                      labelText: "Senha",
                      icon: Icons.lock,
                      readOnly: false,
                      keyboardType: TextInputType.visiblePassword,
                      color: Colors.white,
                      sufixIcon: IconButton(
                        icon: Icon(
                          isObscure ? Icons.visibility : Icons.visibility_off,
                        ),
                        onPressed: _toggleObscure,
                        splashRadius: 20,
                      ),
                    ),
                    SizedBox(height: 20,),
                    Input(
                      controller: _confirmpasswordCrtl,
                      placeholder: "Confirmar senha",
                      labelText: "Confirmar senha",
                      icon: Icons.lock,
                      readOnly: false,
                      keyboardType: TextInputType.visiblePassword,
                      color: Colors.white,
                      sufixIcon: IconButton(
                        icon: Icon(
                          isObscure ? Icons.visibility : Icons.visibility_off,
                        ),
                        onPressed: _toggleObscure,
                        splashRadius: 20,
                      ),
                    ),
                    SizedBox(height: 20,),
                    Row(
                      children: [
                        Expanded(
                          child: RadioListTile(
                            title: const Text(
                              "Sim",
                              style: TextStyle(
                                color: Color.fromARGB(255, 77, 177, 80),
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            value: "Sim",
                            groupValue: selectedOption,
                            activeColor: Colors.green,
                            onChanged: (value) {
                              setState(() {
                                selectedOption = value.toString();
                              });
                              Future.delayed(Duration(milliseconds: 300), () {
                                 if (!context.mounted) return;
                                  Navigator.pushReplacement(
                                    context,
                                    PageTransition(
                                      type: PageTransitionType.bottomToTop,
                                      child: Screentransport(),
                                      duration: const Duration(milliseconds: 500),
                                    ),
                                  );
                              });                            
                            },
                          ),
                        ),
                        Expanded(
                          child: RadioListTile(
                            title: const Text(
                              "Não",
                              style: TextStyle(
                                color: Colors.green,
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            value: "Não",
                            groupValue: selectedOption,
                            activeColor: Colors.green,
                            onChanged: (value) {
                              setState(() {
                                selectedOption = value.toString();
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 30,),
                    ButtonLogotext(
                      tilte: "Cadastrar",
                      borderRadius: BorderRadius.circular(10),
                      onPressed: () => {},
                    )
                  ],
                ),
              ),
            ),
          );
        } 
      
      )
    );
  }
}