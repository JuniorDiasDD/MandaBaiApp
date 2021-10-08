import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:manda_bai/Core/app_colors.dart';
import 'package:manda_bai/Core/app_fonts.dart';
import 'package:manda_bai/Core/app_images.dart';
import 'package:manda_bai/UI/home/components/listview_item_component.dart';
import 'package:manda_bai/UI/home/components/product_list_component.dart';
import 'package:websafe_svg/websafe_svg.dart';

class StartPage extends StatefulWidget {
  const StartPage({Key? key}) : super(key: key);

  @override
  _StartPageState createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
               child: Column(
          children: [
            Stack(
              children: [
                Image.asset(
                  AppImages.Banner,
                  width: Get.width,
                  fit: BoxFit.fitWidth,
                ),
                const Padding(
                  // ignore: unnecessary_const
                  padding: EdgeInsets.only(left: 20, right: 20, top: 195),
                  child: SizedBox(
                    width: 350,
                    height: 40,
                    child: TextField(
                      cursorColor: AppColors.greenColor,
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(30.0)),
                            borderSide:
                                BorderSide(color: AppColors.greenColor)),
                        hintText: 'Pesquisar Produto...',
                        contentPadding: EdgeInsets.only(top: 10, left: 15),
                        suffixIcon: Icon(
                          Icons.search,
                          color: AppColors.greenColor,
                        ),
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(30.0),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: const EdgeInsets.only(top: 10.0, left: 10.0),
                  child: const Text(
                    'Categorias',
                    style: TextStyle(
                      fontFamily: AppFonts.poppinsBoldFont,
                      fontSize: 15,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(top: 10.0, right: 10.0),
                  child: TextButton(
                    style: TextButton.styleFrom(
                      textStyle:
                          const TextStyle(decoration: TextDecoration.underline),
                      primary: AppColors.greenColor,
                    ),
                    onPressed: () {},
                    child: const Text(
                      'Ver Todas',
                      style: TextStyle(
                        fontFamily: AppFonts.poppinsBoldFont,
                        fontSize: 15,
                      ),
                    ),
                  ),
                )
              ],
            ),
            Container(
              height: Get.height * 0.06,
              child: ListView(
                // This next line does the trick.
                scrollDirection: Axis.horizontal,
                children: const <Widget>[
                  ListViewItemComponent(categoryName: 'Electronics'),
                  ListViewItemComponent(categoryName: 'Cosmetics'),
                  ListViewItemComponent(categoryName: 'Foods'),
                  ListViewItemComponent(categoryName: 'Vegetables'),
                  ListViewItemComponent(categoryName: 'Salad'),
                  ListViewItemComponent(categoryName: 'Drinks'),
                ],
              ),
            ),
            Container(
              height: Get.height * 0.21,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: const <Widget>[
                  ProductListComponent(
                      imageName: AppImages.tv,
                      productName: 'Samsung Smart Tv',
                      priceProduct: '500.00 €'),
                  ProductListComponent(
                      imageName: AppImages.tostadeira,
                      productName: 'Tostadeira',
                      priceProduct: '20.00 €'),
                  ProductListComponent(
                      imageName: AppImages.tostadeira,
                      productName: 'Tostadeira',
                      priceProduct: '20.00 €'),
                ],
              ),
            ),
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.only(top: 10.0, left: 10.0),
                  child: const Text(
                    'Produtos em Destaque',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontFamily: AppFonts.poppinsBoldFont,
                      fontSize: 15,
                    ),
                  ),
                ),
                //Container(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
