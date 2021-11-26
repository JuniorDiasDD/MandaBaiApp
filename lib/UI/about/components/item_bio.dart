import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:manda_bai/Controller/static_config.dart';
import 'package:manda_bai/Core/app_colors.dart';
import 'package:manda_bai/Core/app_fonts.dart';
import 'package:readmore/readmore.dart';

class Item_Bio extends StatefulWidget {
  const Item_Bio({Key? key}) : super(key: key);

  @override
  _Item_BioState createState() => _Item_BioState();
}

class _Item_BioState extends State<Item_Bio> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: Get.width * 0.003,
        bottom: Get.width * 0.01,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: Get.height*0.01),
              Text(
                'Carlos Pereira',
                style: TextStyle(
                    fontFamily: AppFonts.poppinsRegularFont,

                    fontSize: Get.width * 0.03),
              ),
              SizedBox(height: Get.height * 0.002),
              Text(
                'Fundador ',
                style: TextStyle(
                    fontFamily: AppFonts.poppinsBoldFont,

                    fontSize: Get.width * 0.03),
              ),
              SizedBox(height: Get.height * 0.01),
              Container(
                width: Get.width * 0.3,
                height: Get.height * 0.18,
                decoration: new BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  color: Colors.white,
                  image: new DecorationImage(
                    fit: BoxFit.fill,
                    image: NetworkImage(
                        'https://bebemamae.com/wp-content/uploads/2021/08/junior-lima-otto-monica-benini-lara.jpg'),
                  ),
                ),
              ),
            ],
          ),
          Column(
            children: [
              Padding(
                padding: EdgeInsets.only(top: Get.height * 0.06),
                child: Container(
                  width: Get.width * 0.52,
                  height: Get.height * 0.2,
                  child: ListView(
                    padding: EdgeInsets.all(0.0),
                    children: [
                      Text(
                        description_carlos,
                        textAlign: TextAlign.justify,
                        style: TextStyle(
                            fontFamily: AppFonts.poppinsRegularFont,

                            fontSize: Get.width * 0.03),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
