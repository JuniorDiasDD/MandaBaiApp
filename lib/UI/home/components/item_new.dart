import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:manda_bai/Core/app_colors.dart';
import 'package:manda_bai/Core/app_fonts.dart';

class ItemNew extends StatefulWidget {
  String image,title;
  ItemNew({required this.image,required this.title});
  @override
  _ItemNewState createState() => _ItemNewState();
}

class _ItemNewState extends State<ItemNew> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Padding(
        padding: EdgeInsets.only(
          left: Get.width * 0.023,
          top: Get.height * 0.009,
          bottom: Get.height * 0.005,
        ),
        child: Container(
            width: Get.width * 0.3,
            height: Get.height * 0.15,
            decoration: new BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey,
                  blurRadius: 1.0,
                  spreadRadius: 0.0,
                  offset: Offset(0.5, 0.5), // changes position of shadow
                ),
              ],
              color: Colors.white,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  widget.image,
                  width:Get.width*0.2,
                  height:Get.width*0.2,
                ),
                SizedBox(
              height: Get.height * 0.01,
            ),
                Text(
                    widget.title,
                    style: TextStyle(
                      fontFamily: AppFonts.poppinsBoldFont,
                      fontSize: Get.width*0.025,
                    ),
                  ),
              ],
            )),
      ),
      // onTap: onTap,
    );
  }
}
