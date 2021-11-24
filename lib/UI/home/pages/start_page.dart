import 'dart:ui';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:manda_bai/Controller/static_config.dart';
import 'package:manda_bai/Core/app_colors.dart';
import 'package:manda_bai/Core/app_fonts.dart';
import 'package:manda_bai/Model/product.dart';
import 'package:manda_bai/Model/user.dart';
import 'package:manda_bai/UI/about/pages/info_page.dart';
import 'package:manda_bai/UI/category_filter/pages/category_page.dart';
import 'package:manda_bai/UI/home/components/header.dart';
import 'package:manda_bai/UI/home/components/item_category.dart';
import 'package:manda_bai/UI/home/components/menu.dart';
import 'package:manda_bai/UI/home/components/product_list_component.dart';

class StartPage extends StatefulWidget {
  const StartPage({Key? key}) : super(key: key);

  @override
  _StartPageState createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
  final List<String> imagesList = [
    'https://jornaleconomico.sapo.pt/wp-content/uploads/2018/01/encomenda_correio.jpg',
    'https://www.rastrearobjetos.com.br/blog/wp-content/uploads/2021/01/Como-rastrear-suas-encomendas-internacionais.png',
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
  void initState() {
    // TODO: implement initState
    super.initState();
    
    user= new User(name:"Júnior",telefone:"9123456",email:"junior@gmail.com",senha: "12344",username:"junior39");
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(
            // backgroundColor: Colors.white,
            title: Header(title: 'MandaBai'),
          ),
          drawer: Menu(),
      body: SingleChildScrollView(
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
                
                Padding(
                  // ignore: unnecessary_const
                  padding: EdgeInsets.only(
                    left: Get.width * 0.07,
                    top: Get.height * 0.235,
                  ),
                  child:  SizedBox(
                    width: 350,
                    height: Get.height*0.05,
                    child: const TextField(
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
                    onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const CategoryPage(),
                      ),
                    ),
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
    );
  }
}
