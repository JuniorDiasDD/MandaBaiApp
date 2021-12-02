import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:manda_bai/Controller/request.dart';
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
  
  List<Product> list_product = [];

  Future _carregar() async {
    list_product = await ServiceRequest.loadFavorite();
    if (list_product.isEmpty) {
      return null;
    }
    return list_product;
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
          child: FutureBuilder(
            future: _carregar(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
                switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return  Container(
                  height: Get.height * 0.8,
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
                if (snapshot.data == null) {
                  return Column(
                    children: [
                      SizedBox(height: Get.height * 0.08),
                      Container(
                        alignment: Alignment.center,
                        height: Get.height * 0.8,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            WebsafeSvg.asset(AppImages.favorite_empyt),
                            SizedBox(height: Get.height * 0.08),
                            Text(
                              "Sem produto marcado como favorito...",
                              style: Theme.of(context).textTheme.headline3,
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                } else {
                  return SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(height: Get.height * 0.08),
                        Text(
                          'Meus Favoritos',
                          style: Theme.of(context).textTheme.headline1,
                        ),
                        SizedBox(height: Get.height * 0.01),
                        Container(
                          height: Get.height * 0.85,
                          child: ListView.builder(
                            padding: EdgeInsets.only(
                              top: 0.0,
                              bottom: Get.height * 0.03,
                            ),
                            scrollDirection: Axis.vertical,
                            itemCount: snapshot.data.length,
                            itemBuilder: (BuildContext context, index) {
                              var list = list_product[index];
                              return ItemFavoriteComponent(product: list);
                            },
                          ),
                        ),
                      ],
                    ),
                  );
                }
              
                }
            },
          ),
        ),
      ),
    );
  }
}
