import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:manda_bai/Core/app_colors.dart';
import 'package:manda_bai/Core/app_fonts.dart';
import 'package:manda_bai/UI/home/pages/home_page.dart';

class PopupMessageInternet extends StatefulWidget {
  String mensagem;
  IconData icon;
  PopupMessageInternet({Key? key, required this.mensagem, required this.icon})
      : super(key: key);

  @override
  _PopupMessageInternetState createState() => _PopupMessageInternetState();
}

class _PopupMessageInternetState extends State<PopupMessageInternet> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        return new Future(() => false);
      },
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(
          child: Container(
            width: Get.width,
            height: Get.height * 0.05,
            margin: EdgeInsets.only(
                left: Get.width * 0.15, right: Get.width * 0.15,top:Get.width * 0.15),
            decoration: BoxDecoration(
              color: Theme.of(context).scaffoldBackgroundColor,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Icon(
                      widget.icon,
                      color:Colors.red,
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.only(
                      left: 10.0,
                      right: 10.0,
                    ),
                    child: Text(
                      widget.mensagem,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.headline4,
                    ),
                  ),
                  SizedBox(height: Get.height * 0.02),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
