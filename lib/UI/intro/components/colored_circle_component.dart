import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:manda_bai/Core/app_colors.dart';

class ColoredCircleComponent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(100),
              topRight: Radius.circular(100),
            ),
            color: AppColors.greenColor,
            shape: BoxShape.rectangle,
          ),
          height: Get.height * 0.15,
          width: Get.width * 0.15,
        ),
        Container(
          height: Get.height * 0.08,
          width: Get.width * 0.25,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(50),
              bottomLeft: Radius.circular(50),
            ),
            color: AppColors.yellowColor,
            shape: BoxShape.rectangle,
          ),
        ),
      ],
    );
  }
}
