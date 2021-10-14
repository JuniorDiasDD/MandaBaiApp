import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:manda_bai/Core/app_colors.dart';
import 'package:manda_bai/Core/app_fonts.dart';
import 'package:manda_bai/Core/app_images.dart';
import 'package:manda_bai/UI/home/components/listview_item_component.dart';
import 'package:manda_bai/UI/home/components/product_list_component.dart';
import 'package:manda_bai/UI/home/pages/product_detail_page.dart';

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
                Padding(
                  // ignore: unnecessary_const
                  padding: EdgeInsets.only(
                    left: Get.width * 0.07,
                    top: Get.height * 0.25,
                  ),
                  child: const SizedBox(
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
                  padding:  EdgeInsets.only(top: Get.height * 0.015, left: Get.width * 0.023),
                  child: const Text(
                    'Categorias',
                    style: TextStyle(
                      fontFamily: AppFonts.poppinsBoldFont,
                      fontSize: 15,
                    ),
                  ),
                ),
                Container(
                  padding:  EdgeInsets.only(top: Get.height * 0.015, right:  Get.width * 0.001),
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
              height: Get.height * 0.05,
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
            // ignore: sized_box_for_whitespace
            Container(
              height: Get.height * 0.19,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: <Widget>[
                  ProductListComponent(
                    imageName: AppImages.tv,
                    productName: 'Samsung Smart Tv',
                    priceProduct: '500.00 €',
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProdutoDetailPage(
                          imageName: AppImages.tv,
                          productName: 'Samsung Smart Tv',
                          priceProduct: '500.00 €',
                        ),
                      ),
                    ),
                  ),
                  ProductListComponent(
                    imageName: AppImages.tostadeira,
                    productName: 'Tostadeira',
                    priceProduct: '20.00 €',
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProdutoDetailPage(
                          imageName: AppImages.tostadeira,
                          productName: 'Tostadeira',
                          priceProduct: '20.00 €',
                        ),
                      ),
                    ),
                  ),
                  ProductListComponent(
                    imageName: AppImages.tostadeira,
                    productName: 'Tostadeira',
                    priceProduct: '20.00 €',
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProdutoDetailPage(
                          imageName: AppImages.tostadeira,
                          productName: 'Tostadeira',
                          priceProduct: '20.00 €',
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                  padding:  EdgeInsets.only(top: Get.height * 0.01, left: Get.width * 0.02),
                child: const Text(
                  'Produtos em Destaque',
                  style: TextStyle(
                    fontFamily: AppFonts.poppinsBoldFont,
                    fontSize: 15,
                  ),
                ),
              ),
            ),
            // ignore: sized_box_for_whitespace
            Container(
              height: Get.height * 0.19,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: <Widget>[
                  ProductListComponent(
                    imageName: AppImages.tv,
                    productName: 'Samsung Smart Tv',
                    priceProduct: '500.00 €',
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProdutoDetailPage(
                          imageName: AppImages.tv,
                          productName: 'Samsung Smart Tv',
                          priceProduct: '500.00 €',
                        ),
                      ),
                    ),
                  ),
                  ProductListComponent(
                    imageName: AppImages.tostadeira,
                    productName: 'Tostadeira',
                    priceProduct: '20.00 €',
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProdutoDetailPage(
                          imageName: AppImages.tostadeira,
                          productName: 'Tostadeira',
                          priceProduct: '20.00 €',
                        ),
                      ),
                    ),
                  ),
                  ProductListComponent(
                    imageName: AppImages.tostadeira,
                    productName: 'Tostadeira',
                    priceProduct: '20.00 €',
                    onTap: () {},
                  ),
                ],
              ),
            ),
             Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding:  EdgeInsets.only(top: Get.height * 0.01, left: Get.width * 0.02),
                child: const Text(
                  'Produtos mais Vendidos',
                  style: TextStyle(
                    fontFamily: AppFonts.poppinsBoldFont,
                    fontSize: 15,
                  ),
                ),
              ),
            ),
            Container(
              height: Get.height * 0.19,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: <Widget>[
                  ProductListComponent(
                    imageName: AppImages.tv,
                    productName: 'Samsung Smart Tv',
                    priceProduct: '500.00 €',
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProdutoDetailPage(
                          imageName: AppImages.tv,
                          productName: 'Samsung Smart Tv',
                          priceProduct: '500.00 €',
                        ),
                      ),
                    ),
                  ),
                  ProductListComponent(
                    imageName: AppImages.tostadeira,
                    productName: 'Tostadeira',
                    priceProduct: '20.00 €',
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProdutoDetailPage(
                          imageName: AppImages.tostadeira,
                          productName: 'Tostadeira',
                          priceProduct: '20.00 €',
                        ),
                      ),
                    ),
                  ),
                  ProductListComponent(
                    imageName: AppImages.tostadeira,
                    productName: 'Tostadeira',
                    priceProduct: '20.00 €',
                    onTap: () {},
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
