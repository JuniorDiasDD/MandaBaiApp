import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:manda_bai/Core/app_colors.dart';
import 'package:manda_bai/Core/app_fonts.dart';

class ButtonUI extends StatefulWidget {
  final String label;
//  final IconData? icon;
  // final ButtonType buttonType;
  final VoidCallback action;

 const ButtonUI(
      {required this.label,
      // this.icon,
      required this.action,
      Key? key})
      : super(key: key);

  @override
  State<ButtonUI> createState() => _ButtonUIState();
}

class _ButtonUIState extends State<ButtonUI> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: Get.height * 0.07,
      width: Get.width,
      decoration: BoxDecoration(
        color: AppColors.greenColor,
        borderRadius: BorderRadius.all(
          Radius.circular(15),
        ),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).cardColor,
            blurRadius: 2.0,
            spreadRadius: 0.0,
            offset: Offset(2.0, 2.0), // changes position of shadow
          ),
        ],
      ),
      child: TextButton(
        child: Text(
         widget.label,
          style: TextStyle(
              fontFamily: AppFonts.poppinsRegularFont,
              fontSize: Get.width * 0.035,
              color: Colors.white),
        ),
        onPressed: widget.action,
      ),
    );
  }
}
