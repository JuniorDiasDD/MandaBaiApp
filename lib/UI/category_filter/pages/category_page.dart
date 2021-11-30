import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:manda_bai/Controller/request.dart';
import 'package:manda_bai/Core/app_colors.dart';
import 'package:manda_bai/Core/app_fonts.dart';
import 'package:manda_bai/Core/app_images.dart';
import 'package:manda_bai/Model/category.dart';
import 'package:manda_bai/Model/product.dart';
import 'package:manda_bai/UI/home/components/item_category.dart';
import 'package:manda_bai/UI/home/components/product_list_component.dart';
import 'package:websafe_svg/websafe_svg.dart';

class CategoryPage extends StatefulWidget {
  Category category;
  CategoryPage({required this.category});

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  List<Product> list_product = [];

  Future _carregar() async {
    list_product = await ServiceRequest.loadProduct(widget.category.id);
    if (list_product.isEmpty) {
      return null;
    }

    return list_product;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(
              top: Get.height * 0.045,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    // ignore: prefer_const_constructors
                    icon: Icon(Icons.arrow_back),
                  ),
                ),
                const SizedBox(
                  width: 270,
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
                IconButton(
                  padding: const EdgeInsets.all(0.0),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return Scaffold(
                          backgroundColor: Colors.transparent,
                          body: Center(
                            child: Container(
                              width: Get.width,
                              height: Get.height * 0.3,
                              margin: EdgeInsets.only(left: 20, right: 20),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  IconButton(
                                    icon: Icon(Icons.close),
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  },
                  icon: WebsafeSvg.asset(AppImages.filter),
                  color: AppColors.greenColor,
                  iconSize: Get.width * 0.05,
                ),

                //alignment: Alignment.centerRight,

                /*IconButton(
                  onPressed: () {},
                  icon: WebsafeSvg.asset(AppImages.filter),
                  iconSize: 20,
                ),*/
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.only(
                top: Get.height * 0.01, left: Get.width * 0.04),
            child:Align(
              alignment: Alignment.topLeft,
              child: Text(
                widget.category.name,
                style: TextStyle(
                  fontFamily: AppFonts.poppinsBoldFont,
                  fontSize: Get.width*0.04,
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
                  height: Get.height*0.85,
                  margin: EdgeInsets.only(
                    left: Get.width * 0.05,
                    right: Get.width * 0.05,
                  ),
                  child: GridView.builder(
                    padding: EdgeInsets.only(top:0.0,),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount:
                              (Get.width == Orientation.portrait) ? 2 : 2),
                      itemCount: list_product.length,
                      itemBuilder: (BuildContext ctx, index) {
                        var list = list_product[index];
                        return ProductListComponent(product: list);
                      }),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
