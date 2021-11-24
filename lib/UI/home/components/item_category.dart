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
        left: Get.width * 0.023,
        bottom: Get.width * 0.01,
      ),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.greenColor, width: 1.0),
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey,
              blurRadius: 1.0,
              spreadRadius: 0.0,
              offset: Offset(0.5, 0.5), // changes position of shadow
            ),
          ],
        ),
        width: Get.width * 0.3,
        height: Get.height * 0.1,
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
          child: Text(
            widget.category.name,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: AppFonts.poppinsRegularFont,
              fontSize: Get.height * 0.013,
              color: AppColors.greenColor,
            ),
          ),
        ),
      ),
    );
  }
}
