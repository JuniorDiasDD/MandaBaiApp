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
  List<String> list_island = [
    'Santo Antão',
    'São Vicente',
    'São Nicolau',
    'Sal',
    'Boavista',
    'Maio',
    'Santiago',
    'Fogo',
    'Brava',
  ];
  @override
  Widget build(BuildContext context) {
    var child;
    return Scaffold(
      body: Column(
       
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
          Container(
            width: Get.width,
            height: Get.height * 0.06,
            margin: EdgeInsets.only(
              left: Get.width * 0.04,
              right: Get.width * 0.04,
            ),
            padding: EdgeInsets.only(
              left: Get.width * 0.04,
              right: Get.width * 0.04,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15.0),
              border: Border.all(
                  color: Theme.of(context).indicatorColor, style: BorderStyle.solid, width: 0.80),
            ),
            child: DropdownButton<String>(
              value: dropdownValue,
              icon: const Icon(
                Icons.arrow_drop_down,
              ),
              iconSize: Get.width * 0.05,
              elevation: 16,
              style: Theme.of(context).textTheme.headline4,
              borderRadius: BorderRadius.circular(15.0),
              underline: Container(
                height: 0,
                color: Colors.transparent,
              ),
              onChanged: (String? newValue) {
                setState(() {
                  dropdownValue = newValue!;
                });
              },
              items: list_island.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(
                    value,
                    style: Theme.of(context).textTheme.headline4,
                  ),
                );
              }).toList(),
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
                style: Theme.of(context).textTheme.headline5,
              ),
            ),
          ),
        ],
      ),
    );
  }

  _navigacao() async {
   // print(dropdownValue);
     var session = FlutterSession();
    await session.set('onboarding', true);
    await session.set('island', dropdownValue);
    Navigator.pushReplacementNamed(context, '/home');
  }
}
