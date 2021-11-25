import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_session/flutter_session.dart';
import 'package:get/get.dart';
import 'package:manda_bai/Core/app_colors.dart';
import 'package:manda_bai/Core/app_fonts.dart';
import 'package:manda_bai/Core/app_images.dart';
import 'package:manda_bai/UI/intro/components/colored_circle_component.dart';

import 'package:websafe_svg/websafe_svg.dart';

import 'language_page.dart';

class ChooseIsland extends StatefulWidget {
  const ChooseIsland({Key? key}) : super(key: key);

  @override
  _ChooseIslandState createState() => _ChooseIslandState();
}

class _ChooseIslandState extends State<ChooseIsland> {
  String dropdownValue = 'Santiago';
  @override
  Widget build(BuildContext context) {
    var child;
    return Scaffold(
      body: Column(
        //  mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Align(
            alignment: Alignment.bottomLeft,
            child: ColoredCircleComponent(),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20.0, right: 20.0),
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.topRight,
                  child: Image.asset(
                    AppImages.ilha_2,
                    height: Get.height * 0.38,
                    width: Get.width * 0.99,
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(top: 5.0, right: 150.0, left: 1.0),
                  child: Align(
                    alignment: Alignment.bottomLeft,
                    child: WebsafeSvg.asset(
                      AppImages.homem,
                      height: Get.height * 0.4,
                      width: Get.width * 0.01,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: Get.height * 0.05),
          Padding(
            padding: EdgeInsets.only(
              left: Get.width * 0.05,
              right: Get.width * 0.05,
            ),
            child: DropdownSearch<String>(
              dropdownSearchDecoration: const InputDecoration(
                hintText: "Selecionar Ilha",
                contentPadding: EdgeInsets.fromLTRB(12, 12, 0, 0),
                border: OutlineInputBorder(),
              ),
              mode: Mode.DIALOG,
              showSelectedItems: false,
              dropdownSearchBaseStyle:
                  const TextStyle(fontFamily: AppFonts.poppinsRegularFont),
              items: const [
                'Santo Antão',
                'São Vicente',
                'São Nicolau',
                'Sal',
                'Boavista',
                'Maio',
                'Santiago',
                'Fogo',
                'Brava',
              ],
            ),
          ),
          SizedBox(height: Get.height * 0.2),
        ],
      ),
      bottomNavigationBar: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(" "),
          Padding(
            padding: EdgeInsets.only(
              right: 15,
              bottom: 10,
            ),
            child: TextButton(
              onPressed: () {
                _navigacao();
              },
              child: Text(
                "seguinte >",
                style: TextStyle(
                    fontFamily: AppFonts.poppinsRegularFont,
                    color: AppColors.greenColor),
              ),
            ),
          ),
        ],
      ),
    );
  }

  _navigacao() async {
    var session = FlutterSession();
    await session.set('onboarding', true);
    Navigator.pushReplacementNamed(context, '/home');
  }
}
