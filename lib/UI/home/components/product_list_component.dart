// ignore_for_file: avoid_unnecessary_containers, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:manda_bai/Core/app_colors.dart';
import 'package:manda_bai/Core/app_fonts.dart';
import 'package:manda_bai/Model/product.dart';
import 'package:manda_bai/UI/description_product/pages/product_detail_page.dart';

class ProductListComponent extends StatelessWidget {
  Product product;

  ProductListComponent({required this.product});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ProdutoDetailPage(
            product: product,
          ),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.only(
            left: Get.width * 0.023,
            top: Get.height * 0.009,
            bottom: Get.height * 0.005),
        child: Container(
          width: Get.width * 0.38,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.white54, width: 1.0),
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.grey,
                blurRadius: 1.0,
                spreadRadius: 0.0,
                offset: Offset(1.0, 1.0), // changes position of shadow
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: Get.width,
                height: Get.height * 0.11,
                decoration: new BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10.0),
                      topRight: Radius.circular(10.0)),
                  color: Colors.white,
                  image: new DecorationImage(
                    fit: BoxFit.fill,
                    image: NetworkImage(product.image),
                  ),
                ),
              ),
              Padding(
                child: Text(
                  product.name,
                  maxLines: 1,
                  style: const TextStyle(
                    fontFamily: AppFonts.poppinsRegularFont,
                    fontSize: 12,
                    color: Colors.black,
                  ),
                ),
                padding: EdgeInsets.only(
                  left: Get.width * 0.03,
                  top: Get.width * 0.03,
                ),
              ),
              Container(
                padding: EdgeInsets.only(
                  left: Get.width * 0.01,
                ),
                width: Get.width,
                height: Get.height * 0.03,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                            left: Get.width * 0.02,
                          ),
                          child: Text(
                            product.price.toString(),
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontFamily: AppFonts.poppinsRegularFont,
                              fontSize: 10,
                              color: AppColors.greenColor,
                            ),
                          ),
                        ),
                         Padding(
                          padding: EdgeInsets.only(
                            left: Get.width * 0.01,
                          ),
                          child: Text(
                             '€',
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontFamily: AppFonts.poppinsRegularFont,
                              fontSize: 10,
                              color: AppColors.greenColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
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
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      // onTap: onTap,
    );
  }
}
