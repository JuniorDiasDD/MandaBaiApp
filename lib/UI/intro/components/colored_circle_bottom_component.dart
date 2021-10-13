import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:manda_bai/Core/app_colors.dart';

class ColoredCircleBottomComponent extends StatefulWidget {
  const ColoredCircleBottomComponent({Key? key}) : super(key: key);

  @override
  _ColoredCircleBottomComponentState createState() =>
      _ColoredCircleBottomComponentState();
}

class _ColoredCircleBottomComponentState
    extends State<ColoredCircleBottomComponent> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: Get.height * 0.0385),
      child: Stack(
        alignment: Alignment.bottomRight,
        children: [
          Container(
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(100),
                topLeft: Radius.circular(100),
              ),
              color: AppColors.greenColor,
              shape: BoxShape.rectangle,
            ),
            height: Get.height * 0.1,
            width: Get.width * 0.35,
          ),
          Container(
            height: Get.height * 0.18,
            width: Get.width * 0.16,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(100),
                topLeft: Radius.circular(100),
              ),
              color: AppColors.yellowColor,
              shape: BoxShape.rectangle,
            ),
          ),
        ],
      ),
    );
  }
}
