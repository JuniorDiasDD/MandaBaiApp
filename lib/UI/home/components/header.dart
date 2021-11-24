import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:manda_bai/Core/app_fonts.dart';
import 'package:manda_bai/UI/about/pages/info_page.dart';

class Header extends StatefulWidget {
  String title;
  Header({required this.title});
  @override
  _HeaderState createState() => _HeaderState();
}

class _HeaderState extends State<Header> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          widget.title,
          style: TextStyle(
            fontFamily: AppFonts.poppinsRegularFont,
          ),
        ),
        IconButton(
          padding: EdgeInsets.only(
            right: Get.width * 0.02,
          ),
          onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const InfoPage(),
            ),
          ),
          icon: const Icon(
            Icons.info,
            color: Colors.white,
          ),
          iconSize: Get.width * 0.05,
          alignment: Alignment.centerRight,
        ),
      ],
    );
  }
}
