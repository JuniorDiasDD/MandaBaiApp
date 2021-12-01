import 'package:flutter/animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:manda_bai/Core/app_colors.dart';
import 'package:manda_bai/Core/app_fonts.dart';
import 'package:manda_bai/Core/app_images.dart';

class Popup_Island extends StatefulWidget {
  const Popup_Island({Key? key}) : super(key: key);

  @override
  _Popup_IslandState createState() => _Popup_IslandState();
}

class _Popup_IslandState extends State<Popup_Island> {
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
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
        child: Container(
          width: Get.width,
          height: Get.height * 0.45,
          margin:
              EdgeInsets.only(left: Get.width * 0.12, right: Get.width * 0.12),
          decoration: BoxDecoration(
            color: Theme.of(context).scaffoldBackgroundColor,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(

            children: [

              Padding(
                padding:  EdgeInsets.only(
                top: Get.height *0.04,),
                child: Text(
                  'Selecione a Ilha pretendida',
                  textAlign: TextAlign.start,

                  style: TextStyle(
                      fontFamily: AppFonts.poppinsRegularFont,
                      fontSize: Get.width * 0.038,
                ),
                ),
              ),
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
                  color: Colors.black38, style: BorderStyle.solid, width: 0.80),
            ),
            child: DropdownButton<String>(
              value: dropdownValue,
              icon: const Icon(
                Icons.arrow_drop_down,
              ),
              iconSize: Get.width * 0.05,
              elevation: 16,
              style: TextStyle(
                color: Colors.black,
                fontSize: Get.width * 0.04,
              ),
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
                    style: TextStyle(
                      fontFamily: AppFonts.poppinsRegularFont,
                      color: Colors.black,
                      fontSize: Get.width * 0.04,
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
          SizedBox(height: Get.height * 0.2),


              Container(
                height: Get.height * 0.07,
                width: Get.width * 0.36,
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
                      offset: Offset(2.0, 2.0), // changes position of shadow
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
