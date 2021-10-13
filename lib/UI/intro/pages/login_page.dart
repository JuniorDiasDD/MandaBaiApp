import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:get/get.dart';
import 'package:manda_bai/Core/app_colors.dart';
import 'package:manda_bai/Core/app_images.dart';
import 'package:manda_bai/UI/home/pages/home_page.dart';
import 'package:manda_bai/UI/intro/components/colored_circle_component.dart';
import 'package:manda_bai/UI/intro/pages/recovery_password_page.dart';
import 'package:manda_bai/UI/intro/pages/register_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
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
                height: Get.height * 0.05,
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
                  right: Get.height * 0.05,
                ),
                child: Column(
                  children: [
                    Container(
                      height: Get.height * 0.07,
                      width: Get.width,
                      child: TextField(
                        obscureText: false,
                        decoration: InputDecoration(
                          prefixIcon: Icon(
                            Icons.person,
                            color: AppColors.greenColor,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(35),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                width: 1, color: AppColors.greenColor),
                            borderRadius: BorderRadius.circular(35),
                          ),
                          labelText: 'User@gmail.com',
                          labelStyle: TextStyle(
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: Get.height * 0.01),
                    Container(
                      height: Get.height * 0.07,
                      width: Get.width,
                      child: TextField(
                        obscureText: true,
                        decoration: InputDecoration(
                          prefixIcon:
                              Icon(Icons.lock, color: AppColors.greenColor),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(35),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                width: 1, color: AppColors.greenColor),
                            borderRadius: BorderRadius.circular(35),
                          ),
                          labelText: 'Palavra-passe',
                          labelStyle: TextStyle(
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    ),
                    TextButton(
                      style: TextButton.styleFrom(
                        primary: Colors.black,
                        textStyle: const TextStyle(fontSize: 10),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => RecoveryPassword()),
                        );
                      },
                      child: const Text(
                        'Esueceu sua senha?',
                        style: TextStyle(
                          decoration: TextDecoration.underline,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: Get.height * 0.01,
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
                        child: Text('Login'),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => HomePage()),
                          );
                        },
                        shape: RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(30.0),
                        ),
                      ),
                    ),
                    TextButton(
                      style: TextButton.styleFrom(
                        primary: Colors.black,
                        textStyle: const TextStyle(fontSize: 10),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => RegisterPage()),
                        );
                      },
                      child: const Text(
                        'Registar agora',
                        style: TextStyle(
                          decoration: TextDecoration.underline,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ),
                    Column(
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Expanded(
                              child: new Container(
                                margin: const EdgeInsets.only(
                                    left: 10.0, right: 20.0),
                                child: Divider(
                                  color: Colors.black,
                                  height: 36,
                                ),
                              ),
                            ),
                            Text("OU"),
                            Expanded(
                              child: Container(
                                margin: const EdgeInsets.only(
                                    left: 20.0, right: 10.0),
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
                    Container(
                      child: Column(
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
                            child: Column(
                              children: [
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
                          ),
                        ],
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
  }
}
