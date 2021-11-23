import 'dart:ui';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:manda_bai/Core/app_colors.dart';
import 'package:manda_bai/Core/app_fonts.dart';
import 'package:manda_bai/Core/app_images.dart';
import 'package:manda_bai/Model/product.dart';
import 'package:manda_bai/UI/home/components/listview_item_component.dart';
import 'package:manda_bai/UI/home/components/product_list_component.dart';
import 'package:manda_bai/UI/home/pages/info_page.dart';
import 'package:manda_bai/UI/home/pages/product_detail_page.dart';

class StartPage extends StatefulWidget {
  const StartPage({Key? key}) : super(key: key);

  @override
  _StartPageState createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
  final List<String> imagesList = [
    'https://jornaleconomico.sapo.pt/wp-content/uploads/2018/01/encomenda_correio.jpg',
    'https://www.ctt.pt/contentAsset/raw-data/98b66acc-d6ee-45f9-a6dc-d884a2a86c68/imagemBanner/f1c317fc-c0cb-4be3-87e1-83391cfdbbc6',
    'https://www.sindcontsp.org.br/wp-content/uploads/2019/12/encomenda.jpg'
  ];
   List<Product>list_product = [];
    Future _carregar() async {
  //  list_product = await Request.loadEntidades();
    list_product.add(new Product(id:1,name:"Televisão",image:"https://i.zst.com.br/thumbs/12/32/f/-52450406.jpg",price:20000,amount:1));
    list_product.add(new Product(id:1,name:"Iphone 11",image:"https://store.storeimages.cdn-apple.com/4982/as-images.apple.com/is/iphone11-select-2019-family?wid=882&hei=1058&fmt=jpeg&qlt=80&.v=1567022175704",price:49000,amount:1));
     if (list_product.isEmpty) {
      return null;
    }

    return list_product;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(top: Get.height * 0.029),
          child: Column(
            children: [
              Stack(
                children: [
                  CarouselSlider(
                    options: CarouselOptions(
                      viewportFraction: 1,
                      autoPlayAnimationDuration:
                          const Duration(milliseconds: 100),
                      autoPlay: true,
                      enlargeCenterPage: true,
                    ),
                    items: imagesList
                        .map(
                          (item) => Center(
                            child: Image.network(
                              item,
                              fit: BoxFit.cover,
                              width: Get.width,
                            ),
                          ),
                        )
                        .toList(),
                  ),
                  Align(
                    alignment: Alignment.topRight,
                    child: IconButton(
                      padding: EdgeInsets.only(
                          top: Get.height * 0.02, right: Get.width * 0.035),
                      onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const InfoPage(),
                        ),
                      ),
                      icon: const Icon(
                        Icons.info,
                        color: AppColors.yellowColor,
                      ),
                      iconSize: Get.width * 0.05,
                      alignment: Alignment.centerRight,
                    ),
                  ),
                  Padding(
                    // ignore: unnecessary_const
                    padding: EdgeInsets.only(
                      left: Get.width * 0.07,
                      top: Get.height * 0.235,
                    ),
                    child:  SizedBox(
                      width: 350,
                      height: Get.height*0.05,
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
              SizedBox(
                height: Get.height * 0.0001,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: EdgeInsets.only(
                        top: Get.height * 0.03, left: Get.width * 0.023),
                    child: const Text(
                      'Categorias',
                      style: TextStyle(
                        fontFamily: AppFonts.poppinsBoldFont,
                        fontSize: 15,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: Get.height * 0.03),
                    child: TextButton(
                      style: TextButton.styleFrom(
                        textStyle: const TextStyle(
                            decoration: TextDecoration.underline),
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
              // ignore: sized_box_for_whitespace
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
              FutureBuilder(
                  future: _carregar(),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (snapshot.data == null) {
                      return Container();
                    } else {
                      return Container(
                        height: Get.height * 0.2,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: snapshot.data.length,
                          itemBuilder: (BuildContext context, index) {
                            var list = list_product[index];
                            return ProductListComponent(product: list);
                          },
                        ),
                      );
                    }
                  },
                ),
              
              Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: EdgeInsets.only(
                      top: Get.height * 0.01, left: Get.width * 0.02),
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
                FutureBuilder(
                  future: _carregar(),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (snapshot.data == null) {
                      return Container();
                    } else {
                      return Container(
                        height: Get.height * 0.2,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: snapshot.data.length,
                          itemBuilder: (BuildContext context, index) {
                            var list = list_product[index];
                            return ProductListComponent(product: list);
                          },
                        ),
                      );
                    }
                  },
                ),
              Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: EdgeInsets.only(
                      top: Get.height * 0.01, left: Get.width * 0.02),
                  child: const Text(
                    'Produtos mais Vendidos',
                    style: TextStyle(
                      fontFamily: AppFonts.poppinsBoldFont,
                      fontSize: 15,
                    ),
                  ),
                ),
              ),
                FutureBuilder(
                  future: _carregar(),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (snapshot.data == null) {
                      return Container();
                    } else {
                      return Container(
                        height: Get.height * 0.2,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: snapshot.data.length,
                          itemBuilder: (BuildContext context, index) {
                            var list = list_product[index];
                            return ProductListComponent(product: list);
                          },
                        ),
                      );
                    }
                  },
                ),
            ],
          ),
        ),
      ),
    );
  }
}
