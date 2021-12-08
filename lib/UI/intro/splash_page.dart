import 'package:flutter/material.dart';
import 'package:flutter_session/flutter_session.dart';
import 'package:get/get.dart';
import 'package:manda_bai/Controller/mandaBaiController.dart';
import 'package:manda_bai/Core/app_colors.dart';
import 'package:manda_bai/Core/app_fonts.dart';
import 'package:manda_bai/Core/app_images.dart';

import 'onboarding_screen.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
    final MandaBaiController mandaBaiController =
      Get.put(MandaBaiController());
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration(seconds: 2)).then((_) async {
      var check = await FlutterSession().get('onboarding');
      if (check == true) {
        Navigator.pushReplacementNamed(context, '/home');
      } else {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => OnboardingScreen()));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     // backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: Get.width,
            height: Get.height * 0.14,
            child: Image.asset(AppImages.appLogo2),
          ),
        ],
      ),
      bottomNavigationBar: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.only(
              bottom: Get.height * 0.04,
            ),
            child: Text(
              "Powered by MandaBai",
              style: TextStyle(
                  fontFamily: AppFonts.poppinsRegularFont,
                  color: AppColors.greenColor),
            ),
          ),
        ],
      ),
    );
  }
}
