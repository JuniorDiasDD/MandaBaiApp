import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:manda_bai/Core/app_colors.dart';
import 'package:manda_bai/Core/app_fonts.dart';
import 'package:manda_bai/Core/app_images.dart';

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
            color:Theme.of(context).scaffoldBackgroundColor,
            borderRadius: BorderRadius.circular(12),
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left:Get.width*0.04,),
                      child: Image.asset(
                        AppImages.cvmovel,
                        width: Get.width * 0.05,
                        height: Get.width * 0.05,
                      ),
                    ),
                    Text(
                      'Saldo CvMovel',

                          style: Theme.of(context).textTheme.headline1,
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
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(height: Get.height * 0.01),
                        Text(
                          'Número de Telemóvel',
                            style: Theme.of(context).textTheme.headline2,
                        ),
                        SizedBox(height: Get.height * 0.02),
                        Container(
                          width: Get.width * 0.055,
                          child: TextFormField(
                            controller: input_number,
                            keyboardType: TextInputType.number,
                            obscureText: false,
                            style: Theme.of(context).textTheme.headline4,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Theme.of(context).backgroundColor,
                              border: OutlineInputBorder(
                                borderRadius: new BorderRadius.circular(15.0),
                                borderSide: new BorderSide(),
                              ),
                              prefixIcon: Padding(
                                padding: EdgeInsets.all(0.0),
                                child: Icon(
                                  Icons.phone,

                                ), // icon is 48px widget.
                              ),
                              labelText: 'Numero',

                            ),
                            validator: (value) =>
                                value!.length==7 ? null : ' Número Inválido',

                          ),
                        ),
                        SizedBox(height: Get.height * 0.01),
                        Text(
                          'Montante',
                            style: Theme.of(context).textTheme.headline2,
                        ),
                        SizedBox(height: Get.height * 0.01),
                        Container(
                          width: Get.width * 0.055,
                          child: TextFormField(
                            controller: input_montante,
                            keyboardType: TextInputType.number,
                            obscureText: false,
                            style: Theme.of(context).textTheme.headline4,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Theme.of(context).backgroundColor,
                              border: OutlineInputBorder(
                                borderRadius: new BorderRadius.circular(15.0),
                                borderSide: new BorderSide(),
                              ),
                              prefixIcon: Padding(
                                padding: EdgeInsets.all(0.0),
                                child: Icon(
                                  Icons.attach_money,

                                ), // icon is 48px widget.
                              ),
                              labelText: 'Montante',

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
                              Radius.circular(15),
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Theme.of(context).cardColor,
                                blurRadius: 2.0,
                                spreadRadius: 0.0,
                                offset: Offset(
                                    2.0, 2.0), // changes position of shadow
                              ),
                            ],
                          ),
                          child: TextButton(
                            child: Text(
                              'Enviar Saldo',
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
