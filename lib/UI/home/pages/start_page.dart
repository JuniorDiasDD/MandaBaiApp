import 'dart:ui';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_session/flutter_session.dart';
import 'package:get/get.dart';
import 'package:manda_bai/Controller/mandaBaiController.dart';
import 'package:manda_bai/Controller/static_config.dart';
import 'package:manda_bai/Core/app_colors.dart';
import 'package:manda_bai/Core/app_fonts.dart';
import 'package:manda_bai/Core/app_images.dart';
import 'package:manda_bai/Model/category.dart';
import 'package:manda_bai/Model/product.dart';
import 'package:manda_bai/Model/user.dart';
import 'package:manda_bai/UI/category_filter/pages/category_page.dart';
import 'package:manda_bai/UI/home/components/header.dart';
import 'package:manda_bai/UI/home/components/item_category.dart';
import 'package:manda_bai/UI/home/components/item_new.dart';
import 'package:manda_bai/UI/home/components/menu.dart';
import 'package:manda_bai/UI/category_filter/components/product_list_component.dart';
import 'package:manda_bai/UI/home/controller/mandaBaiCategoryController.dart';
import 'package:manda_bai/data/madaBaiData.dart';

class StartPage extends StatefulWidget {
  @override
  _StartPageState createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
  final List<String> imagesList = [
    'https://jornaleconomico.sapo.pt/wp-content/uploads/2018/01/encomenda_correio.jpg',
    'https://www.rastrearobjetos.com.br/blog/wp-content/uploads/2021/01/Como-rastrear-suas-encomendas-internacionais.png',
    'https://www.sindcontsp.org.br/wp-content/uploads/2019/12/encomenda.jpg'
  ];

 final MandaBaiCategoryController mandaBaiCategoryController =
      Get.find();
  final MandaBaiController mandaBaiController = Get.find();

  @override
  void initState() {
    super.initState();
    mandaBaiController.loadSessao();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () => Navigator.pushReplacementNamed(context, '/home'),
      child: WillPopScope(
        onWillPop: () {
          return new Future(() => false);
        },
        child: Scaffold(
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
                                height: Get.height * 0.25,
                              ),
                            ),
                          )
                          .toList(),
                    ),
                  ],
                ),
                SizedBox(
                  height: Get.height * 0.01,
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: EdgeInsets.only(
                        top: Get.height * 0.01, left: Get.width * 0.02),
                    child: Text(
                      'Novos Serviços',
                      style: Theme.of(context).textTheme.headline1,
                    ),
                  ),
                ),
                Container(
                  height: Get.height * 0.15,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      ItemNew(image: AppImages.cvmovel, title: "Saldo CvMovel"),
                      ItemNew(
                          image: AppImages.camara, title: "Serviços da Câmara"),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: EdgeInsets.only(
                          top: Get.height * 0.01, left: Get.width * 0.023),
                      child: Text(
                        'Categorias',
                        style: Theme.of(context).textTheme.headline1,
                      ),
                    ),
                  ],
                ),
                FutureBuilder(
                  future: mandaBaiCategoryController.loadCategory(),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (!snapshot.hasData) {
                      return Container(
                        height: Get.height * 0.2,
                        width: Get.width,
                        child: Center(
                          child: Image.asset(
                            AppImages.loading,
                            width: Get.width * 0.2,
                            height: Get.height * 0.2,
                            alignment: Alignment.center,
                          ),
                        ),
                      );
                    } else {
                      if (snapshot.data == null) {
                        return Container(
                          height: Get.height * 0.2,
                          width: Get.width,
                          child: Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.public_off_outlined,
                                  color: Colors.grey,
                                  size: Get.height * 0.06,
                                ),
                                Text(
                                  "Serviço Indispónivel.\n Tente mais tarde...",
                                  style: TextStyle(
                                    fontFamily: AppFonts.poppinsBoldFont,
                                    fontSize: Get.width * 0.035,
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      } else {
                        return Container(
                          margin: EdgeInsets.only(top: Get.height * 0.012),
                          height: Get.height * 0.5,
                          child: ListView.builder(
                            padding: EdgeInsets.only(
                              top: 0.0,
                              bottom: Get.height * 0.03,
                            ),
                            scrollDirection: Axis.vertical,
                            itemCount: snapshot.data.length,
                            itemBuilder: (BuildContext context, index) {
                              var list = mandaBaiCategoryController
                                  .ListCategoria[index];
                              return ListViewItemComponent(category: list);
                            },
                          ),
                        );
                      }
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
