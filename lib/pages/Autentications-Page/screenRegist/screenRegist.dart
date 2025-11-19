import 'package:flutter/material.dart';
import 'package:projecto_registagro/shared/buttom_logoText/button_logoTest.dart';
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
  final _ConfirmPasswordCrtl = TextEditingController();
  String selectedOption = "";

  bool isObscure = true;
  bool ischecked = true;


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
    _ConfirmPasswordCrtl.dispose();
    super.dispose();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20,),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Input(
              controller: _nameEpCrtl,
              placeholder: "Nome",
              labelText: "Nome",
              icon: Icons.domain,
              readOnly: true,
              showCursor: true,
              maxLenght: 255,
              keyboardType: TextInputType.text,

            ),
            SizedBox(height: 20,),
            Input(
              controller: _foneNumberCrtl,
              placeholder: "Telefone",
              labelText: "Telefone",
              icon: Icons.phone,
              readOnly: true,
              showCursor: true,
              maxLenght: 255,
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 20,),
            Input(
              controller: _emailCtrl,
              placeholder: "Email",
              labelText: "Email",
              icon: Icons.email,
              readOnly: true,
              showCursor: true,
              maxLenght: 255,
              keyboardType: TextInputType.emailAddress,
            ),
            SizedBox(height: 20,),
            Input(
              controller: _locationCrtl,
              placeholder: "Localização",
              labelText: "Localização",
              icon: Icons.location_on,
              readOnly: true,
              showCursor: true,
              maxLenght: 255,
              keyboardType: TextInputType.emailAddress,
            ),
            SizedBox(height: 20,),
            Input(
              controller: _passwordCtrl,
              placeholder: "Senha",
              labelText: "Senha",
              icon: Icons.lock,
              readOnly: false,
              keyboardType: TextInputType.visiblePassword,
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
              controller: _ConfirmPasswordCrtl,
              placeholder: "Confirmar senha",
              labelText: "Confirmar senha",
              icon: Icons.lock,
              readOnly: false,
              keyboardType: TextInputType.visiblePassword,
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
                        color: Colors.green,
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
    );
  }
}