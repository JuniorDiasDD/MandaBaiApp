import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:manda_bai/Core/app_colors.dart';
import 'package:manda_bai/Core/app_fonts.dart';
import 'package:manda_bai/UI/home/components/carrega_saldo.dart';
import 'package:manda_bai/UI/home/pop_up/pop_up_message.dart';

class ItemNew extends StatefulWidget {
  String image, title;
  ItemNew({required this.image, required this.title});
  @override
  _ItemNewState createState() => _ItemNewState();
}

class _ItemNewState extends State<ItemNew> {
 
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //print(check.);
  }
  @override
  Widget build(BuildContext context) {
   
    return GestureDetector(
      onTap: () {
        if (widget.title == "Saldo CvMovel") {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return Carrega_Saldo();
              });
        }else if(widget.title=="Serviços da Câmara"){
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return Pop_up_Message();
              });

        }
      },
      child: Padding(
        padding: EdgeInsets.only(
          left: Get.width * 0.023,
          top: Get.height * 0.014,
          bottom: Get.height * 0.005,
        ),
        child: Container(
            width: Get.width * 0.3,
            height: Get.height * 0.15,
            decoration: new BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey,
                  blurRadius: 1.0,
                  spreadRadius: 0.0,
                  offset: Offset(0.5, 0.5), // changes position of shadow
                ),
              ],
             color:Theme.of(context).dialogBackgroundColor,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  widget.image,
                  width: Get.width * 0.15,
                  height: Get.width * 0.15,
                ),
                SizedBox(
                  height: Get.height * 0.01,
                ),
                Text(
                  widget.title,
                  style: TextStyle(
                    fontFamily: AppFonts.poppinsBoldFont,
                    fontSize: Get.width * 0.025,
                  ),
                ),
              ],
            )),
      ),
      // onTap: onTap,
    );
  }
}
