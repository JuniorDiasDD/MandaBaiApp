import 'package:flutter/material.dart';
import 'package:flutter_onboarding_screen/OnbordingData.dart';
import 'package:flutter_onboarding_screen/flutteronboardingscreens.dart';
import 'package:manda_bai/Core/app_images.dart';

import 'pages/choose_island_page.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final List<OnbordingData> list = [
    OnbordingData(
      imagePath: AppImages.firstOnboardingImage,
      desc: "Ajude a sua família lá dentro, cá fora.",
    ),
    OnbordingData(
      imagePath: AppImages.secondOnboardingImage,
      //  title: "Order",
      desc: "Aceda a loja e compre os produtos que pretende.",
    ),
    OnbordingData(
      imagePath: AppImages.thirdOnboardingImage,
      // title: "Eat",
      desc:
          "Faça o pagamento online e os produtos serão entregues ao domicílio.",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IntroScreen(
        list,
        MaterialPageRoute(builder: (context) => ChooseIsland()),
      ),
    );
  }
}
