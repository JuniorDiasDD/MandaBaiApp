import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:manda_bai/Core/app_colors.dart';
import 'package:websafe_svg/websafe_svg.dart';

class TrakingItem extends StatelessWidget {
  final String title;
  final String description;
  final String image;
  final bool colorStatus;
  final bool lineFinal;
  const TrakingItem({Key? key,required this.image,required this.title,required this.description,this.colorStatus=false,this.lineFinal=false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: Get.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            children: [
              Container(
                width: Get.width * 0.15,
                height: Get.width * 0.15,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: colorStatus?AppColors.greenColor: Colors.grey[350],
                  boxShadow: [
                    BoxShadow(
                      color: Theme.of(context).cardColor,
                      blurRadius: 2.0,
                      spreadRadius: 0.0,
                      offset:
                          const Offset(2.0, 2.0), // changes position of shadow
                    ),
                  ],
                ),
                child:  Padding(
                  padding:const  EdgeInsets.all(16.0),
                  child:  WebsafeSvg.asset(
                      image,color:colorStatus?AppColors.white: AppColors.black_claro, ),
                ),
              ),
              if(!lineFinal)
              Container(
                height: Get.height * 0.05,
                width: 4,
                color: colorStatus?AppColors.greenColor: Colors.grey[350],
              ),
            ],
          ),
         const SizedBox(
            width: 16,
          ),
          Container(
            width: Get.width*0.6,
           padding: lineFinal? const EdgeInsets.only(bottom: 0): const EdgeInsets.only(bottom: 32),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                 title,
                  style: Theme.of(context).textTheme.headline3,
                ),
                Text(
                 description,
                  style: Theme.of(context).textTheme.headline3!.copyWith(fontSize:Get.width * 0.025 ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
