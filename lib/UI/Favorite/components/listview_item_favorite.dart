import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:manda_bai/Controller/cart_controller.dart';
import 'package:manda_bai/Core/app_colors.dart';
import 'package:manda_bai/Core/app_fonts.dart';

import 'package:manda_bai/Model/cart_model.dart';

class ItemFavoriteComponent extends StatefulWidget {
  // final CartPageController cartPageController = Get.find();
  final String name, image;
  double price;
  int amount;
  int id;
  ItemFavoriteComponent(
      {required this.id,
      required this.name,
      required this.image,
      required this.amount,
      required this.price});

  @override
  _ItemFavoriteComponentState createState() => _ItemFavoriteComponentState();
}

class _ItemFavoriteComponentState extends State<ItemFavoriteComponent> {
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          const EdgeInsets.only(top: 4.0, left: 2.0, right: 2.0, bottom: 4.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: const [
            BoxShadow(
              color: Colors.grey,
              blurRadius: 2.0,
              //spreadRadius: 0.0,
              offset: Offset(2.0, 2.0), // shadow direction: bottom right
            )
          ],
        ),
        width: Get.width,
        height: Get.height * 0.15,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              widget.image,
              width: Get.width * 0.2,
              height: Get.height * 0.2,
              alignment: Alignment.center,
            ),
            Container(
              margin: EdgeInsets.only(
                left: 10,
              ),
              width: Get.width * 0.62,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        widget.name,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontFamily: AppFonts.poppinsBoldFont,
                          fontSize: 15,
                          color: Colors.black,
                        ),
                      ),
                      Checkbox(
                        checkColor: Colors.white,
                        activeColor: AppColors.greenColor,
                        value: isChecked,
                        onChanged: (bool? value) {
                          setState(() {
                            isChecked = value!;
                          });
                        },
                      ),
                    ],
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Padding(
                      padding: EdgeInsets.only(right: Get.width * 0.02),
                      child: Text(
                        widget.price.toString(),
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontFamily: AppFonts.poppinsBoldFont,
                          fontSize: 15,
                          color: AppColors.greenColor,
                        ),
                      ),
                    ),
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
