import 'package:flutter/material.dart';
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
        color: Colors.blue,
        decoration: BoxDecoration(
          border: Border.all(
              color: AppColors.yellowColor,
              width: 2.0
          ),
          color: Colors.red,
          borderRadius: BorderRadius.circular(12),

        ),
      ),
    );
  }
}
