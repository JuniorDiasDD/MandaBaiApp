import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:manda_bai/Core/app_colors.dart';
import 'package:manda_bai/Core/app_fonts.dart';
import 'package:manda_bai/Core/app_images.dart';
import 'package:websafe_svg/websafe_svg.dart';

class ChooseIsland extends StatefulWidget {
  const ChooseIsland({Key? key}) : super(key: key);

  @override
  _ChooseIslandState createState() => _ChooseIslandState();
}

class _ChooseIslandState extends State<ChooseIsland> {
  String dropdownValue = 'Santiago';
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
              SizedBox(
                height: Get.height * 0.05,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 0.0, right: 20.0),
                child: Stack(
                  children: [
                    Align(
                      alignment: Alignment.topRight,
                      child: Image.asset(
                        AppImages.ilha_2,
                        height: Get.height * 0.35,
                        width: Get.width * 0.9,
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomLeft,
                      child: WebsafeSvg.asset(
                        AppImages.ilha_1,
                        height: Get.height * 0.4,
                        width: Get.width * 0.1,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: Get.height * 0.05,
              ),
              Padding(
                padding: EdgeInsets.only(
                  left: Get.width * 0.05,
                  right: Get.width * 0.05,
                ),
                child: DropdownSearch<String>(
                  dropdownSearchDecoration: InputDecoration(
                    focusColor: AppColors.greenColor,
                    hoverColor: AppColors.greenColor,
                    fillColor: AppColors.greenColor,
                    hintText: "Selecionar Ilha",
                    contentPadding: EdgeInsets.fromLTRB(12, 12, 0, 0),
                    border: OutlineInputBorder(),
                  ),
                  mode: Mode.MENU,
                  showSelectedItems: false,
                  dropdownSearchBaseStyle:
                      TextStyle(fontFamily: AppFonts.poppinsRegularFont),
                  items: [
                    'Santo Antão',
                    'São Vicente',
                    'São Nicolau',
                    'Sal',
                    'Boavista',
                    'Maio',
                    'Santiago',
                    'Fogo',
                    'Brava'
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
