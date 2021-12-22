import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:manda_bai/Controller/request.dart';
import 'package:manda_bai/Core/app_colors.dart';
import 'package:manda_bai/Core/app_images.dart';
import 'package:manda_bai/Model/product.dart';
import 'package:manda_bai/UI/Favorite/components/listview_item_favorite.dart';
import 'package:manda_bai/UI/Favorite/controller/favorite_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:websafe_svg/websafe_svg.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class FavoritePage extends StatefulWidget {
  const FavoritePage({Key? key}) : super(key: key);

  @override
  _FavoritePageState createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  final FavoriteController controller = Get.put(FavoriteController());
  bool isChecked = false;
  TextEditingController pesquisa = TextEditingController();
 // List<Product> list_product = [];
 // List<Product> list_product_full = [];

  Future _carregar() async {

    if (controller.list_product.isEmpty && pesquisa.text == "") {
      controller.list_product = await ServiceRequest.loadFavorite();
      if (controller.list_product.isEmpty) {
        controller.vazio=true;
        return null;
      } else {
        var value;
        final SharedPreferences prefs = await SharedPreferences.getInstance();
        String money = prefs.getString('money')!;
        if (money == "USD") {
          value = await ServiceRequest.loadDolar();
        }
        for (int m = 0; m < controller.list_product.length; m++) {
          switch (money) {
            case 'USD':
              {
                if (value != false) {
                  double dolar = double.parse(value);
                  controller.list_product[m].price = controller.list_product[m].price / dolar;

                }
                break;
              }
            case 'ECV':
              {
                controller.list_product[m].price = controller.list_product[m].price * 110.87;

                break;
              }
          }
        }
        controller.list_product_full = controller.list_product;
      }
    }

    return controller.list_product;
  }

  _search() {
    controller.list_product = [];
    setState(() {
      for (int i = 0; i < controller.list_product_full.length; i++) {
        if (controller.list_product_full[i].name.contains(pesquisa.text)) {
          controller.list_product.add(controller.list_product_full[i]);
        }
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller.loading = false;
    controller.vazio=false;
    controller.list_product=[];
    controller.list_product_full=[];
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        return new Future(() => false);
      },
      child: Scaffold(
        body: Stack(
          children: [
            Padding(
              padding: EdgeInsets.only(
                  left: Get.width * 0.02, right: Get.width * 0.02),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(height: Get.height * 0.08),
                    Text(
                      AppLocalizations.of(context)!.title_my_favorites,
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
                            hintText: AppLocalizations.of(context)!.search,
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
                                  child: Image.network(
                                    AppImages.loading,
                                    width: Get.width * 0.2,
                                    height: Get.height * 0.2,
                                    alignment: Alignment.center,
                                  ),
                                ),
                              );
                            default:
                              if (snapshot.data == null && controller.vazio!=true) {
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
                                        AppLocalizations.of(context)!
                                          .text_no_favorite_product,
                                        style:
                                            Theme.of(context).textTheme.headline3,
                                      ),
                                    ],
                                  ),
                                );
                              } else {
                                return Container(
                                  height: Get.height * 0.85,
                                  child:  Obx(
                                        () => ListView.builder(
                                      padding: EdgeInsets.only(
                                        top: 0.0,
                                        bottom: Get.height * 0.03,
                                      ),
                                      scrollDirection: Axis.vertical,
                                      itemCount: controller.list_product.length,
                                      itemBuilder: (BuildContext context, index) {
                                        var list = controller.list_product[index];
                                        return ItemFavoriteComponent(product: list);
                                      },
                                    ),
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
            Obx(
              () => SizedBox(
                child: controller.loading
                    ? Container(
                        color: Colors.black54,
                        height: Get.height,
                        child: Center(
                          child: Image.network(
                            AppImages.loading,
                            width: Get.width * 0.2,
                            height: Get.height * 0.2,
                            alignment: Alignment.center,
                          ),
                        ),
                      )
                    : null,
              ),
            ),
            Obx(
                  () =>SizedBox(
                    child:controller.vazio? Center(
                      child: Container(
                height: Get.height * 0.5,
                width: Get.width,
                child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        WebsafeSvg.asset(AppImages.favorite_empyt),
                        SizedBox(height: Get.height * 0.08),
                        Text(
                          AppLocalizations.of(context)!
                              .text_no_favorite_product,
                          style:
                          Theme.of(context).textTheme.headline3,
                        ),
                      ],
                ),
              ),
                    ):null,
                  ),
            )
          ],
        ),
      ),
    );
  }
}
