import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:manda_bai/Core/app_colors.dart';

class ProductListComponent extends StatelessWidget {
  final String imageName;
  final String productName;
  final String priceProduct;

  const ProductListComponent({required this.imageName, required this.productName, required this.priceProduct});


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: Get.width * 0.38,
        height: Get.height * 0.1,
        decoration: BoxDecoration(
          border: Border.all(
              color: Colors.grey,
              width: 1.0
          ),
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),

            boxShadow: const [
              BoxShadow(
                color: Colors.grey,
                blurRadius: 2.0,
                //spreadRadius: 0.0,
                //offset: Offset(2.0, 2.0), // shadow direction: bottom right
              )
            ]

        ),
      ),
    );
  }
}
