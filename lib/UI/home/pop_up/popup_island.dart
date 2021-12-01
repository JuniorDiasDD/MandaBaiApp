import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:manda_bai/Core/app_colors.dart';
import 'package:manda_bai/Core/app_fonts.dart';

class Popup_Island extends StatefulWidget {
  const Popup_Island({Key? key}) : super(key: key);

  @override
  _Popup_IslandState createState() => _Popup_IslandState();
}

class _Popup_IslandState extends State<Popup_Island> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.transparent,
      body: Center (
        child: Container(
          width: Get.width,
          height: Get.height * 0.3,
          margin:
          EdgeInsets.only(left: Get.width * 0.12, right: Get.width * 0.12),
          decoration: BoxDecoration(
            color: Theme.of(context).scaffoldBackgroundColor,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(
                  top: Get.height * 0.04,
                ),
                child: Icon(
                  Icons.error_outline,
                  color: Colors.grey,
                  size: Get.height * 0.09,
                ),
              ),
              SizedBox(height: Get.height * 0.01),
              Text(
                'ERRO',
                style: TextStyle(
                    fontFamily: AppFonts.poppinsRegularFont,
                    fontSize: Get.width * 0.05,
                    color: Colors.grey),
              ),
              SizedBox(height: Get.height * 0.02),
              Container(
                height: Get.height * 0.07,
                width: Get.width * 0.3,
                decoration: BoxDecoration(
                  color: AppColors.greenColor,
                  borderRadius: BorderRadius.all(
                    Radius.circular(35),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey,
                      blurRadius: 2.0,
                      spreadRadius: 0.0,
                      offset: Offset(
                          2.0, 2.0), // changes position of shadow
                    ),
                  ],
                ),

                child: TextButton(
                  child: Text(
                    'OK',
                    style: TextStyle(
                        fontFamily: AppFonts.poppinsBoldFont,
                        fontSize: Get.width * 0.035,
                        color: Colors.white),
                  ),
                  onPressed: () => Navigator.pop(
                    context,

                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

