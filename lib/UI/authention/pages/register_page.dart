import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_pw_validator/Resource/Strings.dart';
import 'package:flutter_pw_validator/flutter_pw_validator.dart';
import 'package:get/get.dart';
import 'package:manda_bai/Core/app_colors.dart';
import 'package:manda_bai/Core/app_fonts.dart';
import 'package:manda_bai/Core/app_images.dart';
import 'package:manda_bai/UI/intro/components/colored_circle_component.dart';


class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final input_email = TextEditingController();
  final input_numero = TextEditingController();
  final input_username = TextEditingController();
  final input_senha = TextEditingController();
  final input_nome = TextEditingController();
  Future<void> validateAndSave() async {
    final FormState? form = _formKey.currentState;
    if (form!.validate()) {
      print('Form is valid');
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
                Container(
                  margin: EdgeInsets.only(top: 33.0),
                  width: Get.width,
                  child: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(Icons.arrow_back),
                    alignment: Alignment.topLeft,
                  ),
                ),
              ],
            ),
            Image.asset(
              AppImages.appLogo,
              width: Get.width * 0.6,
              height: Get.height * 0.1,
            ),
            SizedBox(
              height: Get.height * 0.03,
            ),
            Padding(
              padding: EdgeInsets.only(
                left: Get.width * 0.05,
                right: Get.width * 0.05,
              ),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: input_nome,
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
                            Icons.person,
                            color: Colors.grey,
                          ), // icon is 48px widget.
                        ),
                        labelText: 'Nome',
                        labelStyle: TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                      validator: (value) =>
                          value!.isEmpty ? 'Insira o Nome' : null,
                    ),
                    SizedBox(height: Get.height * 0.01),
                    TextFormField(
                      controller: input_email,
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
                            Icons.email,
                            color: Colors.grey,
                          ), // icon is 48px widget.
                        ),
                        labelText: 'Email',
                        labelStyle: TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                      validator: (value) =>
                          value!.isEmpty ? 'Insira o email' : null,
                    ),
                    SizedBox(height: Get.height * 0.01),
                    TextFormField(
                      keyboardType: TextInputType.phone,
                      controller: input_numero,
                      autocorrect: false,
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
                        labelText: 'Telefone',
                        labelStyle: TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                      validator: (value) =>
                          value!.isEmpty ? 'Insira o Número' : null,
                    ),
                    SizedBox(height: Get.height * 0.01),
                    TextFormField(
                      controller: input_username,
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
                            Icons.person,
                            color: Colors.grey,
                          ), // icon is 48px widget.
                        ),
                        labelText: 'Utilizador',
                        labelStyle: TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                      validator: (value) =>
                          value!.isEmpty ? 'Insira o Utilizador' : null,
                    ),
                    SizedBox(height: Get.height * 0.01),
                    TextFormField(
                      controller: input_senha,
                      obscureText: true,
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
                            Icons.lock,
                            color: Colors.grey,
                          ), // icon is 48px widget.
                        ),
                        labelText: 'Palavra-passe',
                        labelStyle: TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                      validator: (value) =>
                          value!.isEmpty ? 'Insira a senha' : null,
                    ),
                    SizedBox(height: Get.height * 0.005),
                    FlutterPwValidator(
                    controller: input_senha,
                    minLength: 8,
                    uppercaseCharCount: 1,
                    numericCharCount: 2,
                    specialCharCount: 1,
                    width: 400,
                    height: 150,
                 //   strings:FrenchStrings(),
                    onSuccess: () {
                      print("Matched");
                      Scaffold.of(context).showSnackBar(new SnackBar(
                          content: new Text("Password is matched")));
                    },
                  ),
                   
                    SizedBox(
                      height: Get.height * 0.02,
                    ),
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
                            offset:
                                Offset(2.0, 2.0), // changes position of shadow
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
    );
  }
}
class FrenchStrings implements FlutterPwValidatorStrings {
  @override
  final String atLeast = 'Au moins - caractères';
  @override
  final String uppercaseLetters = '- Lettres majuscules';
  @override
  final String numericCharacters = '- Chiffres';
  @override
  final String specialCharacters = '- Caractères spéciaux';
}
