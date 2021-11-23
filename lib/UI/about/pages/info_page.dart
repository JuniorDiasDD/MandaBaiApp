import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:manda_bai/Controller/static_config.dart';
import 'package:manda_bai/Core/app_colors.dart';
import 'package:manda_bai/Core/app_fonts.dart';
import 'package:readmore/readmore.dart';

class InfoPage extends StatelessWidget {
  const InfoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding:
            EdgeInsets.only(left: Get.width * 0.04, right: Get.width * 0.04),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: Get.height * 0.08),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    child: IconButton(
                      // padding: EdgeInsets.all(0.0),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(
                        Icons.arrow_back,
                        color: Colors.black,
                      ),
                      alignment: Alignment.centerRight,
                    ),
                  ),
                  Text(
                    'Sobre Nós',
                    style: TextStyle(
                        fontFamily: AppFonts.poppinsBoldFont,
                        fontSize: Get.width * 0.05),
                  ),
                  Container(
                    width: Get.width * 0.08,
                  ),
                ],
              ),
              SizedBox(height: Get.height * 0.02),
              Padding(
                padding: EdgeInsets.only(
                    left: Get.width * 0.01, right: Get.width * 0.01),
                child: Column(
                  children: [
                    Text(
                      'MandaBai, somos mais que uma Empresa!',
                      style: TextStyle(
                          fontFamily: AppFonts.poppinsBoldFont,
                          color: AppColors.greenColor,
                          fontSize: Get.width * 0.05),
                    ),
                    SizedBox(height: Get.height * 0.02),
                ReadMoreText(
                  description_mandabai,
                  trimLines: 2,
                  colorClickableText: AppColors.greenColor,
                  trimMode: TrimMode.Line,
                  trimCollapsedText: 'Ver mais',
                  trimExpandedText: 'Fechar',
                  style: TextStyle(fontSize: 14, fontFamily: AppFonts.poppinsRegularFont, color: Colors.black),
                  moreStyle: TextStyle(fontSize: 14, fontFamily: AppFonts.poppinsRegularFont, color: AppColors.greenColor),
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