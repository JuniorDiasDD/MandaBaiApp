import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:manda_bai/Core/app_colors.dart';
import 'package:manda_bai/Core/app_fonts.dart';
import 'package:manda_bai/Core/app_images.dart';
import 'package:manda_bai/UI/home/pages/category_page.dart';
import 'package:manda_bai/UI/home/pages/start_page.dart';
import 'package:websafe_svg/websafe_svg.dart';

class ListViewItemComponent extends StatelessWidget {
  final String categoryName;

  // ignore: use_key_in_widget_constructors
  const ListViewItemComponent({required this.categoryName});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: Get.width * 0.023,bottom: Get.width * 0.01,),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.greenColor, width: 1.0),
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
              BoxShadow(
                color: Colors.grey,
                blurRadius: 1.0,
                spreadRadius: 0.0,
                offset: Offset(0.5, 0.5), // changes position of shadow
              ),
            ],
        ),        
        width: Get.width * 0.3,
        height: Get.height * 0.1,
        child: TextButton(
          onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const CategoryPage(),
            ),
          ),
          child: Text(                     
            categoryName,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: AppFonts.poppinsRegularFont,
              fontSize: Get.height * 0.013,
              color: AppColors.greenColor,
            ),
          ),
        ),
      ),
    );
  }
}
