import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:manda_bai/Core/app_colors.dart';
import 'package:manda_bai/Core/app_fonts.dart';
import 'package:manda_bai/Model/user.dart';
import 'package:manda_bai/UI/intro/components/colored_circle_component.dart';

class RecoveryPassword extends StatefulWidget {
  const RecoveryPassword({Key? key}) : super(key: key);

  @override
  _RecoveryPasswordState createState() => _RecoveryPasswordState();
}

class _RecoveryPasswordState extends State<RecoveryPassword> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final input_email = TextEditingController();
  final input_telefone = TextEditingController();
  bool statePassword = false;
  Future<void> validateAndSave() async {
    final FormState? form = _formKey.currentState;
    if (form!.validate()) {

    } else {
      print('Form is invalid');
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(
              children: [
                Align(
                  alignment: Alignment.bottomLeft,
                  child: ColoredCircleComponent(),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: 33.0),
                      child: IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Icon(Icons.arrow_back),
                        alignment: Alignment.topLeft,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 33.0),
                      child: Text(
                        'Esqueceu sua senha',
                        style: TextStyle(
                          fontFamily: AppFonts.poppinsBoldFont,
                          fontSize: 18.0,
                        ),
                      ),
                    ),
                    Text(
                      '       ',
                    ),
                  ],
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(
                left: Get.width * 0.05,
                right: Get.height * 0.05,
              ),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.only(top: 35.0),
                      height: Get.height * 0.25,
                      child: const Text(
                        'Por favor, digite seu e-mail registrado ou seu numero de telefone para redefinir sua senha ',
                      ),
                    ),
                    const Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        'E-mail ou número de telefone',
                      ),
                    ),
                    SizedBox(height: Get.height * 0.01),
                    Container(
                      height: Get.height * 0.07,
                      width: Get.width,
                      child: TextFormField(
                        obscureText: false,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                width: 1, color: AppColors.greenColor),
                            borderRadius: BorderRadius.circular(15.0),
                          ),

                          labelText: 'Email/Telefone',
                          labelStyle: Theme.of(context).textTheme.headline4,
                        ),
                        validator: (value) => EmailValidator.validate(value!)
                            ? null
                            : 'Emial inváido',
                        ),
                      ),


                    SizedBox(
                      height: Get.height * 0.05,
                    ),
                    Container(
                      height: Get.height * 0.07,
                      width: Get.width,
                      child: FlatButton(
                        padding: EdgeInsets.only(
                          left: Get.width * 0.05,
                          right: Get.height * 0.05,
                        ),
                        color: AppColors.greenColor,
                        textColor: Colors.white,
                        child: const Text('Enviar'),
                        onPressed: () {},
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
