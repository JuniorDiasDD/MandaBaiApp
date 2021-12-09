import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:manda_bai/Controller/request.dart';
import 'package:manda_bai/Core/app_colors.dart';
import 'package:manda_bai/Core/app_fonts.dart';
import 'package:manda_bai/Core/app_images.dart';
import 'package:manda_bai/Model/product.dart';
import 'package:manda_bai/UI/Favorite/components/listview_item_favorite.dart';
import 'package:websafe_svg/websafe_svg.dart';

class FavoritePage extends StatefulWidget {
  const FavoritePage({Key? key}) : super(key: key);

  @override
  _FavoritePageState createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  bool isChecked = false;
  TextEditingController pesquisa = TextEditingController();
  List<Product> list_product = [];
  List<Product> list_product_full = [];

  Future _carregar() async {
    if (list_product.isEmpty && pesquisa.text == "") {
      list_product = await ServiceRequest.loadFavorite();
      if (list_product.isEmpty) {
        return null;
      } else {
        list_product_full = list_product;
      }
    }

    return list_product;
  }

  _search() {
    list_product = [];
    setState(() {
      for (int i = 0; i < list_product_full.length; i++) {
        if (list_product_full[i].name.contains(pesquisa.text)) {
          list_product.add(list_product_full[i]);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        return new Future(() => false);
      },
      child: Scaffold(
        body: Padding(
          padding:
              EdgeInsets.only(left: Get.width * 0.02, right: Get.width * 0.02),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: Get.height * 0.08),
                Text(
                  'Meus Favoritos',
                  style: Theme.of(context).textTheme.headline1,
                ),
                SizedBox(height: Get.height * 0.03),
                Align(
                  alignment: Alignment.bottomRight,
                  child: Container(
                    width: Get.width * 0.4,
                    height: Get.width * 0.1,
                    margin: EdgeInsets.only(
                      right: Get.width * 0.02,
                    ),
                    child: TextField(
                      cursorColor: AppColors.greenColor,
                      controller: pesquisa,
                      style: Theme.of(context).textTheme.headline4,
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(30.0)),
                            borderSide:
                                BorderSide(color: AppColors.greenColor)),
                        hintText: 'Pesquisar Produto...',
                        hintStyle: Theme.of(context).textTheme.headline4,
                        contentPadding: EdgeInsets.only(top: 10, left: 15),
                        suffixIcon: Icon(
                          Icons.search,
                          color: AppColors.greenColor,
                        ),
                        filled: true,
                        fillColor: Theme.of(context).backgroundColor,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(30.0),
                          ),
                        ),
                      ),
                      onChanged: (text) {
                        _search();
                      },
                    ),
                  ),
                ),
                FutureBuilder(
                  future: _carregar(),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    switch (snapshot.connectionState) {
                      case ConnectionState.waiting:
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
                      default:
                      
                   /* if (!snapshot.hasData) {
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
                    } else {*/
                      if (snapshot.data == null) {
                        return Container(
                          height: Get.height * 0.5,
                          width: Get.width,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              WebsafeSvg.asset(AppImages.favorite_empyt),
                              SizedBox(height: Get.height * 0.08),
                              Text(
                                "Sem produto marcado como favorito...",
                                style:
                                    Theme.of(context).textTheme.headline3,
                              ),
                            ],
                          ),
                        );
                      } else {
                        return Container(
                          height: Get.height * 0.85,
                          /* margin: EdgeInsets.only(
                                          left: Get.width * 0.05,
                                          right: Get.width * 0.05,
                                        ),*/
                          child: ListView.builder(
                            padding: EdgeInsets.only(
                              top: 0.0,
                              bottom: Get.height * 0.03,
                            ),
                            scrollDirection: Axis.vertical,
                            itemCount: list_product.length,
                            itemBuilder: (BuildContext context, index) {
                              var list = list_product[index];
                              return ItemFavoriteComponent(product: list);
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
