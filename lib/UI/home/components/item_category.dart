import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:manda_bai/Core/app_colors.dart';
import 'package:manda_bai/Core/app_fonts.dart';
import 'package:manda_bai/Model/category.dart';
import 'package:manda_bai/UI/category_filter/pages/category_page.dart';
import 'package:manda_bai/UI/home/pages/start_page.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
class ListViewItemComponent extends StatefulWidget {
  Category category;
  ListViewItemComponent({required this.category});
  @override
  State<ListViewItemComponent> createState() => _ListViewItemComponentState();
}

class _ListViewItemComponentState extends State<ListViewItemComponent> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => CategoryPage(category: widget.category,filter_most: AppLocalizations.of(context)!.filter_more_price,filter_less: AppLocalizations.of(context)!.filter_less_price),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: Container(
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
          child: Padding(
            padding: EdgeInsets.only(
                left: Get.width * 0.01, top: Get.height * 0.15),
            child: Text(
              widget.category.name,
              textAlign: TextAlign.start,
              style: TextStyle(
                fontFamily: AppFonts.poppinsBoldFont,
                fontSize: Get.height * 0.026,
                color: Colors.white,
                backgroundColor: Colors.black26,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
