import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:manda_bai/Core/app_colors.dart';
import 'package:manda_bai/Core/app_fonts.dart';
import 'package:manda_bai/Core/app_images.dart';
import 'package:websafe_svg/websafe_svg.dart';

class ListViewItemComponent extends StatelessWidget {
  final String categoryName;
  const ListViewItemComponent({required this.categoryName});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
             color: AppColors.greenColor,
              width: 2.0
          ),
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),


          /*boxShadow: const [
            BoxShadow(
              color: Colors.grey,
              blurRadius: 2.0,
              //spreadRadius: 0.0,
              offset: Offset(2.0, 2.0), // shadow direction: bottom right
            )
          ],*/
        ),
        padding: const EdgeInsets.only(top: 10.0, left: 10.0, right: 10.0),
        width: Get.width * 0.24,
        height: Get.height * 0.1,
        child: Text(
          categoryName,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontFamily: AppFonts.poppinsRegularFont,
            fontSize: 10,
            color: AppColors.greenColor,
          ),
        ),
      ),
    );
  }
}
