import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:manda_bai/Core/app_colors.dart';
import 'package:manda_bai/Core/app_fonts.dart';
import 'package:manda_bai/Core/app_images.dart';
import 'package:manda_bai/UI/intro/pages/onboarding_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 2)).then((_) async {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      var check = prefs.getString('onboarding');
      if (check.toString() == 'true' && check != null) {
        Navigator.pushReplacementNamed(context, '/home');
      } else {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => OnboardingPage()));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: Get.width,
            height: Get.height * 0.14,
            child: Image.asset(AppImages.appLogo),
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
            child: const Text(
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
