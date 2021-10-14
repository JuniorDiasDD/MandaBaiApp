// ignore_for_file: avoid_unnecessary_containers, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:manda_bai/Core/app_colors.dart';
import 'package:manda_bai/Core/app_fonts.dart';

class ProductListComponent extends StatelessWidget {
  final String imageName;
  final String productName;
  final String priceProduct;
  final Function()? onTap;

  const ProductListComponent(
      {required this.imageName,
      required this.productName,
      required this.priceProduct,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Padding(
        padding:
            EdgeInsets.only(left: Get.width * 0.023, top: Get.height * 0.009),
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
                imageName,
                width: Get.width * 0.8,
                height: Get.height * 0.1,
                alignment: Alignment.center,
              ),
              Container(
                child: Text(
                  productName,
                  style: const TextStyle(
                    fontFamily: AppFonts.poppinsRegularFont,
                    fontSize: 12,
                    color: Colors.black,
                  ),
                ),
                padding: EdgeInsets.only(
                  left: Get.width * 0.03,
                ),
              ),
              Container(
                padding: EdgeInsets.only(left: Get.width * 0.01, top: Get.height * 0.01),
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
      ),
      onTap: onTap,
    );
  }
}
