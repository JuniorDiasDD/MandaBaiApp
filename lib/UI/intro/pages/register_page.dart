import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:manda_bai/Core/app_colors.dart';
import 'package:manda_bai/Core/app_images.dart';
import 'package:manda_bai/UI/intro/components/colored_circle_component.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
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
              SizedBox(
                height: Get.height * 0.03,
              ),
              Image.asset(
                AppImages.appLogo,
                width: Get.width * 0.6,
                height: Get.height * 0.2,
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
                      height: Get.height * 0.06,
                      width: Get.width,
                      child: TextField(
                        obscureText: false,
                        decoration: InputDecoration(
                          prefixIcon:
                              Icon(Icons.person, color: AppColors.greenColor),
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
                      height: Get.height * 0.06,
                      width: Get.width,
                      child: TextField(
                        obscureText: false,
                        decoration: InputDecoration(
                          prefixIcon:
                              Icon(Icons.email, color: AppColors.greenColor),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(35),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                width: 1, color: AppColors.greenColor),
                            borderRadius: BorderRadius.circular(35),
                          ),
                          labelText: 'Email',
                          labelStyle: TextStyle(
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: Get.height * 0.01),
                    Container(
                      height: Get.height * 0.06,
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
                    SizedBox(height: Get.height * 0.01),
                    Container(
                      height: Get.height * 0.06,
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
                          labelText: 'Confirmar palavra-passe',
                          labelStyle: TextStyle(
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: Get.height * 0.01),
                    Container(
                      height: Get.height * 0.06,
                      width: Get.width,
                      child: TextField(
                        keyboardType: TextInputType.phone,
                        autocorrect: false,
                        obscureText: false,
                        decoration: InputDecoration(
                          prefixIcon:
                              Icon(Icons.phone, color: AppColors.greenColor),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(35),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                width: 1, color: AppColors.greenColor),
                            borderRadius: BorderRadius.circular(35),
                          ),
                          labelText: 'Telefone',
                          labelStyle: TextStyle(
                            color: Colors.grey,
                          ),
                        ),
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
                        child: Text('Registar'),
                        onPressed: () {},
                        shape: RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(30.0),
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
    );
  }
}
