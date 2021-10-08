// ignore_for_file: avoid_unnecessary_containers

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:manda_bai/Core/app_colors.dart';
import 'package:manda_bai/Core/app_fonts.dart';
import 'package:manda_bai/Core/app_images.dart';

class ProductListComponent extends StatelessWidget {
  final String imageName;
  final String productName;
  final String priceProduct;

  const ProductListComponent(
      {required this.imageName,
      required this.productName,
      required this.priceProduct});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, top: 10.0),
      child: Container(
        width: Get.width * 0.44,
        //height: Get.height * 0.3,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.white54, width: 1.0),
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              AppImages.tv,
              width: Get.width * 0.8,
              height: Get.height * 0.1,
              alignment: Alignment.center,
            ),
            Container(
              child: Text(
                productName,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontFamily: AppFonts.poppinsRegularFont,
                  fontSize: 12,
                  color: Colors.black,
                ),
              ),
              padding: const EdgeInsets.only(
                left: 7.0,
              ),
            ),
            Container(
              padding: const EdgeInsets.only(left: 7.0, top: 5.0),
              width: Get.width * 0.8,
              height: Get.height * 0.05,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    priceProduct,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontFamily: AppFonts.poppinsRegularFont,
                      fontSize: 10,
                      color: AppColors.greenColor,
                    ),
                  ),
                  /*IconButton(
                    icon: new Icon(Icons.volume_up),
                    alignment: Alignment.centerRight,
                    padding: new EdgeInsets.all(0.0),
                    onPressed: () {},
                  ),
                  IconButton(
                    icon: new Icon(Icons.volume_up),
                    alignment: Alignment.centerLeft,
                    padding: new EdgeInsets.all(0.0),
                    onPressed: () {},
                  )*/
                  IconButton(
                    padding: const EdgeInsets.all(0.0),
                    onPressed: () {},
                    icon: const Icon(Icons.favorite_outline_outlined),
                    iconSize: Get.width * 0.05,
                    alignment: Alignment.centerRight,
                  
                  ),
                  IconButton(
                    padding: const EdgeInsets.all(0.0),
                    onPressed: () {},
                    icon: const Icon(Icons.shopping_cart_outlined),
                    iconSize: Get.width * 0.05,
                    alignment: Alignment.center,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
