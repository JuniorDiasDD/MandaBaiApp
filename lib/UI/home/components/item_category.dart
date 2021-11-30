import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:manda_bai/Core/app_colors.dart';
import 'package:manda_bai/Core/app_fonts.dart';
import 'package:manda_bai/Model/category.dart';
import 'package:manda_bai/UI/category_filter/pages/category_page.dart';
import 'package:manda_bai/UI/home/pages/start_page.dart';

class ListViewItemComponent extends StatefulWidget {
  Category category;

  ListViewItemComponent({required this.category});

  @override
  State<ListViewItemComponent> createState() => _ListViewItemComponentState();
}

class _ListViewItemComponentState extends State<ListViewItemComponent> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: Get.width * 0.03,
        right: Get.width * 0.03,
        bottom: Get.height * 0.06,
      ),
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
            image: NetworkImage(
                'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSstt-VUp5wyfJwhGxRcerVunK9mHR0QIf5RQ&usqp=CAU'),
          ),
        ),
        width: Get.width,
        height: Get.height * 0.2,
        child: TextButton(
          onPressed: () {
            // StartPage.categoryId=widget.category.id;
            //  StartPage.carregarProdutos;
            print("aqui2");
            /* Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const CategoryPage(),
              ),
            );*/
          },
          child: Padding(
            padding:
                EdgeInsets.only(left: Get.width * 0.01, top: Get.height * 0.14),
            child: Text(
              widget.category.name,
              textAlign: TextAlign.start,
              style: TextStyle(
                fontFamily: AppFonts.poppinsBoldFont,
                fontSize: Get.height * 0.026,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
