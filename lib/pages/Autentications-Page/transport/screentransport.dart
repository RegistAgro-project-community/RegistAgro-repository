import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:projecto_registagro/Models/sreentransport.dart';
import 'package:projecto_registagro/shared/buttom_logoText/button_logotest.dart';
import 'package:projecto_registagro/shared/formInput/input.dart';
import 'package:projecto_registagro/shared/truckGif/truckgif.dart';



class Screentransport extends StatefulWidget {
  const Screentransport({super.key});

  @override
  State<Screentransport> createState() => _ScreentransportState();
}

class _ScreentransportState extends State<Screentransport> {

  final _capacityCtrl = TextEditingController();
  String? selectedCapacity;
  String? selectedTransport;


  final List<String> options =[
    "🛻 ⦁ Leve - até 1 Tonelada",
    "🚚 ⦁ Médio - de 1 à 5 Toneladas",
    "🚛 ⦁ Pesado - de 5 à 15 Toneladas"
  ];

  @override
  void dispose(){
    super.dispose();
    _capacityCtrl.dispose();
  }

  listScreenTransport() {
    return Wrap(
      spacing: 8,
      runSpacing: 10,
      children: selectedTransports.map((transport) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 40,
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                border: Border.all(color: Color.fromARGB(50, 179, 176, 176)),
                color: Color(0xF4F4F4F4),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(transport, overflow: TextOverflow.visible),
                  IconButton(
                    iconSize: 13,
                    splashRadius: 1,
                    icon: Icon(Icons.clear, color: Colors.red,),
                    onPressed: () {
                      setState(() {
                        selectedTransports.remove(transport);
                        cars.add(DropdownButtonCars(car: transport));
                      });
                    },
                  )
                ],
              ),
            ),
          ],
        );
      }).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: KeyboardVisibilityBuilder(
        builder: (context, isKeyboardVisible) {
          return AnimatedContainer(
        duration: Duration(milliseconds: 250),
        padding: EdgeInsets.only(
          bottom: isKeyboardVisible ? 20.h : 0.h,
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                  Truckgif(),
                  SizedBox(height: 20,),
                  Input(
                    controller: _capacityCtrl,
                    placeholder: "Quatidade de transportes",
                    labelText: "Quantidade",
                    icon: Icons.balance,
                    keyboardType: TextInputType.number,
                  ),
                  SizedBox(height: 20,),
                  DropdownButton2(
                    isExpanded: true,
                    value: selectedCapacity,
                    buttonStyleData: ButtonStyleData(
                      height: 60,
                      width: MediaQuery.sizeOf(context).width,
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.grey.shade400),
                        color: Colors.white,
                      ),
                    ),
                    dropdownStyleData: DropdownStyleData(
                      maxHeight: 200,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10 ),
                        border: Border.all(color: Colors.grey.shade400),
                        color: Colors.white,
                      ),
                    ),
            
                    menuItemStyleData: MenuItemStyleData(
                      height: 40,
                    ),
            
                    hint: Row(
                        children: [
                          Icon(Icons.local_shipping_rounded, color: Colors.grey.shade700),
                          SizedBox(width: 10),
                          Text(
                            "Capacidade de transportes",
                            style: TextStyle(color: Colors.grey.shade700),
                          ),
                        ],
                      ),
                      // icon: Icon(Icons.keyboard_arrow_down),
                    items: options.map((String item) {
                      return DropdownMenuItem(
                          value: item,
                          child: Text(item, style: TextStyle(wordSpacing: 4),),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          selectedCapacity = value;
                        });
                    },
                    underline: SizedBox(), 
                    
                  ),
                  SizedBox(height: 20,),
                  DropdownButton2(
                      isExpanded: true,
                      buttonStyleData: ButtonStyleData(
                        height: 60,
                        width: MediaQuery.sizeOf(context).width,
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: Colors.grey.shade400),
                          color: Colors.white,
                        ),
                      ),
                      dropdownStyleData: DropdownStyleData(
                        maxHeight: 200,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10 ),
                          border: Border.all(color: Colors.grey.shade400),
                          color: Colors.white,
                        ),
                      ),
            
                      menuItemStyleData: MenuItemStyleData(
                        height: 40,
                      ),
            
                      hint: Row(
                          children: [
                            Icon(Icons.local_shipping_rounded, color: Colors.grey.shade700),
                            SizedBox(width: 10),
                            Text(
                              "Tipos de transportes",
                              style: TextStyle(color: Colors.grey.shade700),
                            ),
                          ],
                        ),
                        // icon: Icon(Icons.keyboard_arrow_down),
                        items: cars.map((item) => DropdownMenuItem<String>(
                                value: item.car,
                                child: Text(item.car),
                              )
                        ).toList(),
                        onChanged: (value) => {
                          setState(() {
                            selectedTransports.add(value!);
                            cars.removeWhere((item) => item.car == value);
                            selectedTransport = null;
                          })
            
                        },
                      underline: SizedBox(), 
                    ),
                    SizedBox(height: 5,),
                    Flexible(
                      child: listScreenTransport(),
                    ),
                    SizedBox(height: 20,),
                    ButtonLogotext(
                      tilte: "Cadastrar",
                      borderRadius: BorderRadius.circular(12),
                      padding: EdgeInsets.symmetric(horizontal: 0),
                      onPressed: () => {},
                    )
                  ],
                ),
              ),
            )
          );
        },
      )
      );
    }
}


