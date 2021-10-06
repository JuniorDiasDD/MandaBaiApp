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
      padding: const EdgeInsets.all(13.0),
      child: Container(
        width: Get.width * 0.38,
        height: Get.height * 0.3,
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
              AppImages.fogao,
              width: Get.width * 0.4,
              height: Get.height * 0.1,
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
            Row(
            //  crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                IconButton(
                  padding: const EdgeInsets.all(0.0),
                  onPressed: () {},
                  icon: const Icon(Icons.favorite),
                  iconSize: Get.width * 0.05,
                ),
                IconButton(
                  padding: const EdgeInsets.all(0.0),
                  onPressed: () {},
                  icon: const Icon(Icons.shopping_cart),
                  iconSize: Get.width * 0.05,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
