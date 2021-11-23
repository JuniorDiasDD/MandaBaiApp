import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:manda_bai/Core/app_colors.dart';
import 'package:manda_bai/Core/app_fonts.dart';
import 'package:manda_bai/Core/app_images.dart';
import 'package:manda_bai/UI/authention/pages/login_page.dart';
import 'package:manda_bai/UI/authention/pages/register_page.dart';
import 'package:manda_bai/UI/home/pages/home_page.dart';
import 'package:manda_bai/UI/intro/components/colored_circle_bottom_component.dart';
import 'package:manda_bai/UI/intro/components/colored_circle_component.dart';


import 'package:websafe_svg/websafe_svg.dart';

class BeginSession extends StatefulWidget {
  const BeginSession({Key? key}) : super(key: key);

  @override
  _BeginSessionState createState() => _BeginSessionState();
}

class _BeginSessionState extends State<BeginSession> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Align(
            alignment: Alignment.bottomLeft,
            child: ColoredCircleComponent(),
          ),
          SizedBox(
            height: Get.height * 0.001,
          ),
          Container(
            width: Get.width,
          ),
          WebsafeSvg.asset(AppImages.appIniciarSessao),
          SizedBox(
            height: Get.height * 0.03,
          ),
          Text(
            'Bem-Vindo (a)',
            style: TextStyle(fontFamily: AppFonts.poppinsBoldFont),
          ),
          SizedBox(
            height: Get.height * 0.08,
          ),
          TextButton(
            style: TextButton.styleFrom(
              primary: Colors.black,
              textStyle: const TextStyle(
                  fontSize: 15, fontFamily: AppFonts.poppinsBoldFont),
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => HomePage()),
              );
            },
            child: const Text(
              'Ir para Home',
              style: TextStyle(
                decoration: TextDecoration.underline,
                // fontStyle: FontStyle.italic,
              ),
            ),
          ),
          ButtonTheme(
            height: Get.height * 0.05,
            child: ButtonBar(
              alignment: MainAxisAlignment.center,
              children: <Widget>[
                RaisedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => LoginPage()),
                    );
                  },
                  color: Colors.white,
                  textColor: AppColors.greenColor,
                  child: Container(
                      width: Get.width * 0.4,
                      alignment: Alignment.center,
                      child: Text('Login')),
                  shape: RoundedRectangleBorder(
                    side: const BorderSide(color: AppColors.greenColor),
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                ),
                RaisedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => RegisterPage()),
                    );
                  },
                  color: AppColors.greenColor,
                  textColor: Colors.white,
                  child: Container(
                      width: Get.width * 0.4,
                      alignment: Alignment.center,
                      child: Text('Registar')),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: ColoredCircleBottomComponent(),
          ),
        ],
      ),
    );
  }
}
