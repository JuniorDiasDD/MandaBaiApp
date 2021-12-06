import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:manda_bai/Core/app_colors.dart';
import 'package:manda_bai/Core/app_fonts.dart';

class Pop_up_Message extends StatefulWidget {
  String mensagem;
  String caminho;
  IconData icon;
  Pop_up_Message(
      {Key? key, required this.mensagem, required this.icon, required this.caminho}) : super(key: key);

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
                style: Theme.of(context).textTheme.headline4,
              ),
              SizedBox(height: Get.height * 0.02),
              Container(
                height: Get.height * 0.07,
                width: Get.width * 0.3,
                decoration:  BoxDecoration(
                  color: AppColors.greenColor,
                  borderRadius: BorderRadius.all(
                    Radius.circular(35),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Theme.of(context).cardColor,
                      blurRadius: 2.0,
                      spreadRadius: 0.0,
                      offset: Offset(2.0, 2.0), 
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
