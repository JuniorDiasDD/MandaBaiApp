import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:manda_bai/Core/app_colors.dart';
import 'package:manda_bai/Core/app_fonts.dart';
import 'package:manda_bai/Core/app_images.dart';
import 'package:manda_bai/UI/home/pages/home_page.dart';
import 'package:manda_bai/UI/pages/Registar.dart';
import 'package:manda_bai/UI/pages/login.dart';
import 'package:manda_bai/main.dart';
import 'package:websafe_svg/websafe_svg.dart';

class IniciarSessao extends StatefulWidget {
  const IniciarSessao({Key? key}) : super(key: key);

  @override
  _IniciarSessaoState createState() => _IniciarSessaoState();
}

class _IniciarSessaoState extends State<IniciarSessao> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: Get.height * 0.05,
              ),
              Container(
                width: Get.width,
                child: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(Icons.arrow_back),
                  alignment: Alignment.topLeft,
                ),
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
                height: Get.height * 0.1,
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
                          MaterialPageRoute(builder: (context) => Login()),
                        );
                      },
                      color: AppColors.greenColor,
                      textColor: Colors.white,
                      child: Container(
                          width: Get.width * 0.4,
                          alignment: Alignment.center,
                          child: Text('Login')),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                    ),
                    RaisedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Registar()),
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
            ],
          ),
        ),
      ),
    );
  }
}
