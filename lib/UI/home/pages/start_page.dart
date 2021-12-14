import 'dart:ui';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:manda_bai/Controller/request.dart';
import 'package:manda_bai/Controller/static_config.dart';
import 'package:manda_bai/Core/app_fonts.dart';
import 'package:manda_bai/Core/app_images.dart';
import 'package:manda_bai/UI/home/components/item_category.dart';
import 'package:manda_bai/UI/home/components/item_new.dart';
import 'package:manda_bai/data/madaBaiData.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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

  Future _carregarCategory() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var island_atualizar = prefs.getString('island_atualizar');
    // print(island_atualizar);
    if (island_atualizar != null && island_atualizar != false) {
      list_category = await ServiceRequest.loadCategory();

      if (list_category.isEmpty) {
        return null;
      }

      await prefs.setString('island_atualizar', "false");
    } else {
      if (list_category.isEmpty) {
        // print("entrou");
        list_category = await ServiceRequest.loadCategory();

        if (list_category.isEmpty) {
          return null;
        }
      }
    }

    return list_category;
  }

  validateMoney() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var money = prefs.getString('money');
    if (money == "null" || money == null) {
      await prefs.setString('money', "EUR");
    }
  }

  validateLanguage() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var language = prefs.getString('language');

    if (language == "null" || language == null) {
      await prefs.setString('language', "pt");
    }
  }

  validateDados() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    var username = prefs.getString('username');
    var password = prefs.getString('password');

    if (password != null && username != null) {
      user.username = username.toString();
      user.senha = password.toString();
    }
  }

  @override
  void initState() {
    super.initState();
    validateMoney();
    validateLanguage();
    validateDados();
  }

  int _current = 0;
  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () => Navigator.pushReplacementNamed(context, '/home'),
      child: WillPopScope(
        onWillPop: () {
          return new Future(() => false);
        },
        child: Scaffold(
          /* appBar: AppBar(

            title: Header(title: 'MandaBai'),
          ),*/
          //  drawer: Menu(),
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
                          onPageChanged: (index, reason) {
                            setState(() {
                              _current = index;
                            });
                          }),
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
                    SizedBox(
                       height: Get.height * 0.25,
                      child: Row(
                        mainAxisAlignment:MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: imagesList.map(
                          (image) {
                            int index = imagesList.indexOf(image);
                            return Container(
                              width: 10.0,
                              height: 10.0,
                              margin: EdgeInsets.symmetric(
                                  vertical: 10.0, horizontal: 2.0),
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: _current == index
                                      ? Colors.green
                                      : Colors.green[50],),
                            );
                          },
                        ).toList(), // this was the part the I had to add
                      ),
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
                      child: Text(AppLocalizations.of(context)!
                          .title_categoria), /*  Text(
                        'Categorias',
                        style: Theme.of(context).textTheme.headline1,
                      ),*/
                    ),
                  ],
                ),
                FutureBuilder(
                  future: _carregarCategory(),
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
                              var list = list_category[index];
                              return ListViewItemComponent(category: list);
                            },
                          ),
                        );
                      }
                    }
                  },
                ),

                /*Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: EdgeInsets.only(
                        top: Get.height * 0.01, left: Get.width * 0.02),
                    child: const Text(
                      'Produtos',
                      style: TextStyle(
                        fontFamily: AppFonts.poppinsBoldFont,
                        fontSize: 15,
                      ),
                    ),
                  ),
                ),
                // ignore: sized_box_for_whitespace
                FutureBuilder(
                  future: carregarProdutos(),
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
                            var list = list_products[index];
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
                ),*/
              ],
            ),
          ),
        ),
      ),
    );
  }
}
