import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:get/get.dart';
import 'package:manda_bai/Core/app_colors.dart';
import 'package:manda_bai/Core/app_fonts.dart';
import 'package:manda_bai/Core/app_images.dart';
import 'package:manda_bai/UI/authention/pages/recovery_password_page.dart';
import 'package:manda_bai/UI/intro/components/colored_circle_component.dart';


class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final input_username = TextEditingController();
  final input_senha = TextEditingController();

  Future<void> validateAndSave() async {
    final FormState? form = _formKey.currentState;
    if (form!.validate()) {
          Navigator.pushReplacementNamed(context, '/home');
      print('Form is valid');
    } else {
      print('Form is invalid');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
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
              SizedBox(
                height: Get.height * 0.02,
              ),
              Image.asset(
                AppImages.appLogo,
                width: Get.width * 0.6,
                height: Get.height * 0.15,
              ),
              SizedBox(
                height: Get.height * 0.05,
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
                      Align(
                        alignment: Alignment.topLeft,
                        child: TextButton(
                          style: TextButton.styleFrom(
                            primary: Colors.black,
                            textStyle: TextStyle(fontSize: Get.width * 0.025),
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => RecoveryPassword()),
                            );
                          },
                          child: const Text(
                            'Esqueceu sua senha?',
                            style: TextStyle(
                              fontStyle: FontStyle.italic,
                              fontFamily: AppFonts.poppinsRegularFont,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: Get.height * 0.01,
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
                              offset: Offset(
                                  2.0, 2.0), // changes position of shadow
                            ),
                          ],
                        ),
                        child: TextButton(
                          child: Text(
                            'Entrar',
                            style: TextStyle(
                                fontFamily: AppFonts.poppinsRegularFont,
                                fontSize: Get.width * 0.035,
                                color: Colors.white),
                          ),
                          onPressed: validateAndSave,
                        ),
                      ),
                      SizedBox(
                        height: Get.height * 0.01,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Não possui uma conta?",
                            style: TextStyle(
                                fontFamily: AppFonts.poppinsRegularFont,
                                fontSize: Get.width * 0.03),
                          ),
                          TextButton(
                            style: TextButton.styleFrom(
                              primary: Colors.black,
                              textStyle: TextStyle(fontSize: Get.width * 0.03),
                            ),
                            onPressed: () {
                               Navigator.pushNamed(context, '/register');
                            },
                            child: const Text(
                              'Registar agora',
                              style: TextStyle(
                                decoration: TextDecoration.underline,
                                fontStyle: FontStyle.italic,
                                fontFamily: AppFonts.poppinsItalicFont,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: Get.height * 0.01,
                      ),
                      Column(
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Expanded(
                                child: new Container(
                                  width: Get.width * 0.4,
                                  child: Divider(
                                    color: Colors.black,
                                    height: 36,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                  left: Get.width * 0.05,
                                  right: Get.width * 0.05,
                                ),
                                child: Text("ou"),
                              ),
                              Expanded(
                                child: Container(
                                  width: Get.width * 0.4,
                                  child: const Divider(
                                    color: Colors.black,
                                    height: 36,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(
                        height: Get.height * 0.02,
                      ),
                      Column(
                        children: [
                          Container(
                            width: Get.width,
                            child: SignInButton(
                              Buttons.Google,
                              text: "Login com Google",
                              onPressed: () {},
                            ),
                          ),
                          Container(
                            width: Get.width,
                            child: SignInButton(
                              Buttons.Facebook,
                              text: "Login com Facebook",
                              onPressed: () {},
                            ),
                          ),
                        ],
                      ),
                    ],
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
