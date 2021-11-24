import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:manda_bai/Core/app_colors.dart';
import 'package:manda_bai/Core/app_fonts.dart';
import 'package:manda_bai/Core/app_images.dart';
import 'package:manda_bai/Model/cart_model.dart';
import 'package:manda_bai/UI/Favorite/components/listview_item_favorite.dart';
import 'package:manda_bai/UI/home/components/header.dart';
import 'package:manda_bai/UI/home/components/menu.dart';
import 'package:websafe_svg/websafe_svg.dart';

class FavoritePage extends StatefulWidget {
  const FavoritePage({Key? key}) : super(key: key);

  @override
  _FavoritePageState createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  bool isChecked = false;
  List<CartModel> list_favorite = [
    CartModel(id: 1, amount: 1, image: AppImages.tv, name: "Tv", price: 100.0),
    CartModel(
        id: 2,
        amount: 2,
        image: AppImages.tv,
        name: "Tv 55 Polegadas",
        price: 200.0),
    // CartModel(amount: 1, image: AppImages.tv, name: "Tv", price: 1200.0),
    // CartModel(amount: 2, image: AppImages.tv, name: "Tv", price: 1200.0),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // backgroundColor: Colors.white,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Meus Favoritos',
              style: TextStyle(
                fontFamily: AppFonts.poppinsRegularFont,
              ),
            ),
            Row(
              children: [
                IconButton(
                  padding: const EdgeInsets.all(0.0),
                  onPressed: () {},
                  icon: const Icon(
                    Icons.delete,
                    color: Colors.white,
                  ),
                  iconSize: Get.width * 0.05,
                ),
                IconButton(
                  padding: const EdgeInsets.all(0.0),
                  onPressed: () {},
                  icon: const Icon(
                    Icons.shopping_cart,
                    color: Colors.white,
                  ),
                  iconSize: Get.width * 0.05,
                ),
              ],
            ),
          ],
        ),
      ),
      drawer: Menu(),
      body: Padding(
        padding:
            EdgeInsets.only(left: Get.width * 0.04, right: Get.width * 0.04),
        child: Column(
          children: [
            Container(
              child: list_favorite.isEmpty
                  ? Column(
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
                                style: TextStyle(
                                    fontFamily: AppFonts.poppinsRegularFont,
                                    fontSize: Get.width * 0.035),
                              ),
                            ],
                          ),
                        ),
                      ],
                    )
                  : SingleChildScrollView(
                      child: Column(
                        children: [
                          SizedBox(height: Get.height * 0.01),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                "Selecionar Todos",
                                style: TextStyle(
                                    fontFamily: AppFonts.poppinsRegularFont),
                              ),
                              Checkbox(
                                checkColor: Colors.white,
                                activeColor: AppColors.greenColor,
                                value: isChecked,
                                onChanged: (bool? value) {
                                  setState(() {
                                    isChecked = value!;
                                  });
                                },
                              ),
                            ],
                          ),
                          Container(
                            height: Get.height * 0.45,
                            child: ListView.builder(
                              padding: EdgeInsets.all(0.0),
                              shrinkWrap: true,
                              itemCount: list_favorite.length,
                              itemBuilder: (context, index) {
                                var list = list_favorite[index];
                                //  cartPageController.name = list.name;
                                //  cartPageController.amount = list.amount;

                                return ItemFavoriteComponent(
                                  id: list.id,
                                  name: list.name,
                                  image: list.image,
                                  amount: list.amount,
                                  price: list.price,
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
