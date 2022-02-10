import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:manda_bai/Controller/full_controller.dart';
import 'package:manda_bai/Core/app_fonts.dart';
import 'package:manda_bai/Model/category.dart';
import 'package:manda_bai/UI/category_filter/pages/category_page.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ListViewItemComponent extends StatefulWidget {
  Category category;
  ListViewItemComponent({required this.category});
  @override
  State<ListViewItemComponent> createState() => _ListViewItemComponentState();
}

class _ListViewItemComponentState extends State<ListViewItemComponent> {
  final FullController controller = Get.find();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top:8.0,bottom: 8.0,left: 15.0,right: 15.0),
      child: OpenContainer(
          closedBuilder: (context, action) {
            return Container(
          alignment: Alignment.topLeft,
          decoration: BoxDecoration(
            color: Theme.of(context).dialogBackgroundColor,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.grey,
                blurRadius: 1.0,
                spreadRadius: 0.0,
                offset: Offset(0.5, 0.5), // changes position of shadow
              ),
            ],
            image: new DecorationImage(
              fit: BoxFit.fill,
              image: widget.category.image != 'null'
                  ? NetworkImage(widget.category.image)
                  : NetworkImage(
                      'https://static.expressodasilhas.cv/media/2020/10/09324151.normal.jpg'),
            ),
          ),
          width: Get.width,
          height: Get.height * 0.2,
          child: Container(
            width: Get.width,
            height: Get.height * 0.2,
            decoration: BoxDecoration(
              color: Colors.black26,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 1.0,
                  spreadRadius: 0.0,
                  offset: Offset(0.5, 0.5), // changes position of shadow
                ),
              ],

            ),
            child: Center(
              child: AnimatedTextKit(
                animatedTexts: [
                  RotateAnimatedText(
                    widget.category.name,
                    textStyle: TextStyle(
                      fontFamily: AppFonts.poppinsBoldFont,
                      fontSize: Get.height * 0.026,
                      color: Colors.white,
                    ),
                   // speed: const Duration(milliseconds: 2000),
                  ),
                  RotateAnimatedText(
                    controller.ilha,
                    textStyle: TextStyle(
                      fontFamily: AppFonts.poppinsBoldFont,
                      fontSize: Get.height * 0.026,
                      color: Colors.white,
                    ),
                    // speed: const Duration(milliseconds: 2000),
                  ),
                ],

                repeatForever: true,
                pause: const Duration(seconds: 1),
                displayFullTextOnTap: true,
                stopPauseOnTap: false,
              )

            ),
          ),
        );
          },
          closedElevation: 5.0,
          closedShape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10)
          ),

          openBuilder: (context, action){
            return CategoryPage(
                category: widget.category,
                filter_most: AppLocalizations.of(context)!.filter_more_price,
                filter_less: AppLocalizations.of(context)!.filter_less_price);
          }
      ),
    );
  }
}
