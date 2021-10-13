import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:manda_bai/Core/app_colors.dart';
import 'package:manda_bai/Core/app_fonts.dart';
import 'package:manda_bai/Core/app_images.dart';
import 'package:manda_bai/UI/intro/components/colored_circle_component.dart';
import 'package:manda_bai/UI/intro/pages/begin_session_page.dart';
import 'package:websafe_svg/websafe_svg.dart';

class LanguagePage extends StatefulWidget {
  const LanguagePage({Key? key}) : super(key: key);

  @override
  _LanguagePageState createState() => _LanguagePageState();
}

class _LanguagePageState extends State<LanguagePage> {
  String dropdownValue = 'Português';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Align(
            alignment: Alignment.bottomLeft,
            child: ColoredCircleComponent(),
          ),
          /* children: [
          SizedBox(height: Get.height * 0.05),
          SizedBox(
            width: Get.width,
          ),
          SizedBox(
            height: Get.height * 0.05,
          ),*/
          Padding(
            padding: const EdgeInsets.only(left: 20.0, right: 20.0),
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.topCenter,
                  child: WebsafeSvg.asset(
                    AppImages.world,
                    height: Get.height * 0.4,
                    width: Get.width * 0.1,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: Get.height * 0.05),
          Padding(
            padding: const EdgeInsets.only(
              left: 20.0,
              right: 20.0,
            ),
            child: DropdownSearch<String>(
              dropdownSearchDecoration: const InputDecoration(
                hintText: "Selecionar Idioma",
                contentPadding: EdgeInsets.fromLTRB(12, 12, 0, 0),
                border: OutlineInputBorder(),
              ),
              mode: Mode.DIALOG,
              showSelectedItems: false,
              dropdownSearchBaseStyle:
                  const TextStyle(fontFamily: AppFonts.poppinsRegularFont),
              items: const [
                'Português',
                'Francês',
                'Inglês',
                'Holandês',
              ],
            ),
          ),
          SizedBox(height: Get.height * 0.2),
          Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: const EdgeInsets.only(left: 20.0, right: 20.0),
              child: TextButton(
                style: TextButton.styleFrom(
                  primary: Colors.black,
                  textStyle: const TextStyle(fontSize: 10),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const BeginSession(),
                    ),
                  );
                },
                child: const Text(
                  'Seguinte',
                  style: TextStyle(
                    color: AppColors.greenColor,
                    fontSize: 15.0,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
