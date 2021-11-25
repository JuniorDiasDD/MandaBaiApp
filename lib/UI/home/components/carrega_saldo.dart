import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:manda_bai/Core/app_colors.dart';
import 'package:manda_bai/Core/app_fonts.dart';

class Carrega_Saldo extends StatefulWidget {
  const Carrega_Saldo({Key? key}) : super(key: key);

  @override
  _Carrega_SaldoState createState() => _Carrega_SaldoState();
}

class _Carrega_SaldoState extends State<Carrega_Saldo> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final input_number = TextEditingController();
  final input_montante = TextEditingController();
  Future<void> validateAndSave() async {
    final FormState? form = _formKey.currentState;
    if (form!.validate()) {
      //Navigator.pushReplacementNamed(context, '/home');
      print('Form is valid');
    } else {
      print('Form is invalid');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
        child: Container(
          width: Get.width,
          height: Get.height * 0.5,
          margin:
              EdgeInsets.only(left: Get.width * 0.12, right: Get.width * 0.12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: Get.width * 0.08,
                    ),
                    Text(
                      'Instruções',
                      style: TextStyle(
                          fontFamily: AppFonts.poppinsBoldFont,
                          fontSize: Get.width * 0.04),
                    ),
                    IconButton(
                      icon: Icon(Icons.close),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(
                    left: Get.width * 0.05,
                    right: Get.width * 0.05,
                  ),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        SizedBox(height: Get.height * 0.01),
                        Text(
                          'Número de Telemóvel',
                          style: TextStyle(
                              fontFamily: AppFonts.poppinsBoldFont,
                              fontSize: Get.width * 0.036),
                        ),
                        SizedBox(height: Get.height * 0.02),
                        Container(
                          width: Get.width * 0.055,
                          child: TextFormField(
                            controller: input_number,
                            keyboardType: TextInputType.number,
                            obscureText: false,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              border: OutlineInputBorder(
                                borderRadius: new BorderRadius.circular(35.0),
                                borderSide: new BorderSide(),
                              ),
                              prefixIcon: Padding(
                                padding: EdgeInsets.all(0.0),
                                child: Icon(
                                  Icons.phone,
                                  color: Colors.grey,
                                ), // icon is 48px widget.
                              ),
                              labelText: 'Numero',
                              labelStyle: TextStyle(
                                color: Colors.grey,
                              ),
                            ),
                            validator: (value) =>
                                value!.isEmpty ? 'Insira o Numero' : null,
                          ),
                        ),
                        SizedBox(height: Get.height * 0.01),
                        Text(
                          'Montante',
                          style: TextStyle(
                              fontFamily: AppFonts.poppinsBoldFont,
                              fontSize: Get.width * 0.036),
                        ),
                        SizedBox(height: Get.height * 0.01),
                        Container(
                          width: Get.width * 0.055,
                          child: TextFormField(
                            controller: input_montante,
                            keyboardType: TextInputType.number,
                            obscureText: false,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              border: OutlineInputBorder(
                                borderRadius: new BorderRadius.circular(35.0),
                                borderSide: new BorderSide(),
                              ),
                              prefixIcon: Padding(
                                padding: EdgeInsets.all(0.0),
                                child: Icon(
                                  Icons.attach_money,
                                  color: Colors.grey,
                                ), // icon is 48px widget.
                              ),
                              labelText: 'Montante',
                              labelStyle: TextStyle(
                                color: Colors.grey,
                              ),
                            ),
                            validator: (value) =>
                                value!.isEmpty ? 'Insira o Montante' : null,
                          ),
                        ),
                        SizedBox(height: Get.height * 0.03),
                        Container(
                          height: Get.height * 0.07,
                          width: Get.width,
                          decoration: BoxDecoration(
                            color: AppColors.greenColor,
                            borderRadius: BorderRadius.all(
                              Radius.circular(35),
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey,
                                blurRadius: 2.0,
                                spreadRadius: 0.0,
                                offset: Offset(
                                    2.0, 2.0), // changes position of shadow
                              ),
                            ],
                          ),
                          child: TextButton(
                            child: Text(
                              'Registar',
                              style: TextStyle(
                                  fontFamily: AppFonts.poppinsRegularFont,
                                  fontSize: Get.width * 0.035,
                                  color: Colors.white),
                            ),
                            onPressed: validateAndSave,
                          ),
                        ),
                        SizedBox(height: Get.height * 0.02),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
