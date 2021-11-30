import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:manda_bai/Core/app_fonts.dart';
import 'package:manda_bai/Core/app_images.dart';

class Pop_up_Message extends StatefulWidget {
  const Pop_up_Message({Key? key}) : super(key: key);

  @override
  _Pop_up_MessageState createState() => _Pop_up_MessageState();
}

class _Pop_up_MessageState extends State<Pop_up_Message> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
        child: Container(
          width: Get.width,
          height: Get.height * 0.4,
          margin:
              EdgeInsets.only(left: Get.width * 0.12, right: Get.width * 0.12),
          decoration: BoxDecoration(
            color: Theme.of(context).scaffoldBackgroundColor,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            children: [

                  Icon(
                    Icons.info,
                    color: Colors.white,
                    size: Get.height * 0.25,
                  ),




        ],
          ),
        ),
      ),
    );
  }
}
