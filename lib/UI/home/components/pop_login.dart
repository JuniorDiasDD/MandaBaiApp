import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:manda_bai/Core/app_colors.dart';
import 'package:manda_bai/Core/app_fonts.dart';
import 'package:manda_bai/Core/app_images.dart';

class Pop_Login extends StatefulWidget {
  const Pop_Login({Key? key}) : super(key: key);


  @override
  _Pop_LoginState createState() => _Pop_LoginState();
}

class _Pop_LoginState extends State<Pop_Login> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
        child: Container(
          width: Get.width,
          height: Get.height * 0.28,
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
                    Padding(
                      padding: EdgeInsets.only(
                        left: Get.width * 0.04,
                      ),
                      child: Container(
                        width: Get.width * 0.05,
                        height: Get.height * 0.04,
                        child: Icon(Icons.person,
                             size: Get.width * 0.06),
                      ),
                    ),
                    Text(
                      'LOGIN',
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
                SizedBox(height: Get.height * 0.03),
                Padding(
                    padding: EdgeInsets.only(
                      left: Get.width * 0.04,
                      right: Get.width * 0.04,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          'Deverá efectuar primeiramente o Login.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontFamily: AppFonts.poppinsRegularFont,
                              fontSize: Get.width * 0.038),
                        ),
                      ],
                    ),
                ),
                SizedBox(height: Get.height * 0.02),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    height: Get.height * 0.06,
                    width: Get.width *0.4,
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
                        'Login',
                        style: TextStyle(
                            fontFamily: AppFonts.poppinsBoldFont,
                            fontSize: Get.width * 0.04,
                            color: Colors.white),
                      ),
                      onPressed: () => Navigator.pushNamed(context, '/login'),
                    ),
                  ),
                ),
                SizedBox(height: Get.height * 0.01),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
