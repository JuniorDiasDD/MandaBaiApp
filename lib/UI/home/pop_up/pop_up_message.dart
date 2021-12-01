import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:manda_bai/Core/app_colors.dart';
import 'package:manda_bai/Core/app_fonts.dart';
import 'package:manda_bai/Core/app_images.dart';
import 'package:manda_bai/UI/home/pages/start_page.dart';

class Pop_up_Message extends StatefulWidget {
  String mensagem;
  String caminho;
  IconData icon;
  Pop_up_Message(
      {required this.mensagem, required this.icon, required this.caminho});

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
          height: Get.height * 0.3,
          margin:
              EdgeInsets.only(left: Get.width * 0.12, right: Get.width * 0.12),
          decoration: BoxDecoration(
            color: Theme.of(context).scaffoldBackgroundColor,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(
                  top: Get.height * 0.04,
                ),
                child: Icon(
                  widget.icon,
                  color: widget.caminho!="erro" ? Colors.green : Colors.red,
                  size: Get.height * 0.09,
                ),
              ),
              SizedBox(height: Get.height * 0.01),
              Text(
                widget.mensagem,
                style: TextStyle(
                    fontFamily: AppFonts.poppinsRegularFont,
                    fontSize: Get.width * 0.05,
                    color: Colors.grey),
              ),
              SizedBox(height: Get.height * 0.02),
              Container(
                height: Get.height * 0.07,
                width: Get.width * 0.3,
                decoration: BoxDecoration(
                  color: AppColors.greenColor,
                  borderRadius: BorderRadius.all(
                    Radius.circular(35),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey,
                      blurRadius: 2.0,
                      spreadRadius: 0.0,
                      offset: Offset(2.0, 2.0), // changes position of shadow
                    ),
                  ],
                ),
                child: TextButton(
                    child: Text(
                      'OK',
                      style: TextStyle(
                          fontFamily: AppFonts.poppinsBoldFont,
                          fontSize: Get.width * 0.035,
                          color: Colors.white),
                    ),
                    onPressed: () {
                      if (widget.caminho == "home") {
                        Navigator.pushReplacementNamed(context, '/home');
                      } else if (widget.caminho == "erro") {
                        Navigator.pop(context);
                      }
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
