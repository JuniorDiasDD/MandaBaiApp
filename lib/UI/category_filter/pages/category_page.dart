import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:manda_bai/Controller/request.dart';
import 'package:manda_bai/Core/app_colors.dart';
import 'package:manda_bai/Core/app_fonts.dart';
import 'package:manda_bai/Core/app_images.dart';
import 'package:manda_bai/Model/category.dart';
import 'package:manda_bai/Model/favorite.dart';
import 'package:manda_bai/Model/product.dart';
import 'package:manda_bai/UI/home/components/product_list_component.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:websafe_svg/websafe_svg.dart';

class CategoryPage extends StatefulWidget {
  Category category;
  CategoryPage({required this.category});

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  TextEditingController pesquisa = TextEditingController();
  List<Product> list_product = [];
  List<Product> list_product_full = [];
  String dropdownValue = 'Menos Preço';
  List<String> list_filter = [
    'Menos Preço',
    'Mais Preço',
  ];
  _search() {
    // print("click");
    list_product = [];
    setState(() {
      for (int i = 0; i < list_product_full.length; i++) {
        if (list_product_full[i].name.contains(pesquisa.text)) {
          list_product.add(list_product_full[i]);
        }
      }
    });
  }

  _ordenar() {
    list_product = [];
    setState(() {
      list_product = list_product_full;
      if (dropdownValue == "Menos Preço") {
        Comparator<Product> pesagemComparator =
            (a, b) => a.price.compareTo(b.price);
        list_product.sort(pesagemComparator);
      } else if (dropdownValue == "Mais Preço") {
        Comparator<Product> pesagemComparator =
            (a, b) => b.price.compareTo(a.price);
        list_product.sort(pesagemComparator);
      }
    });
  }

  Future _carregar() async {
    if (list_product.isEmpty) {
      list_product = await ServiceRequest.loadProduct(widget.category.id);
      if (list_product.isEmpty) {
        return null;
      } else {
        final SharedPreferences prefs = await SharedPreferences.getInstance();
        final String itemFavortiesString = prefs.getString('itens_favorites');
        if (itemFavortiesString != null) {
          List<Favorite> list = Favorite.decode(itemFavortiesString);
          for (int i = 0; i < list_product.length; i++) {
            for (int f = 0; f < list.length; f++) {
              if (list_product[i].id == list[f].id) {
                list_product[i].favorite = true;
              }
            }
          }
        }
        if (list_product_full.isEmpty) {
          list_product_full = list_product;
        }
      }
    }

    return list_product;
  }

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
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
                      icon: const Icon(Icons.arrow_back),
                    ),
                  ),
                  SizedBox(
                    width: Get.width * 0.7,
                    height: 40,
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
                  Container(
                    width: Get.width * 0.1,
                    height: Get.height * 0.06,
                    margin: EdgeInsets.only(
                      right: Get.width * 0.04,
                    ),
                    child: DropdownButton(
                      icon: Icon(
                        Icons.filter_alt_sharp,
                        color: AppColors.greenColor,
                        size: 20.09,
                      ),

                      isExpanded: true,
                      underline:
                          DropdownButtonHideUnderline(child: Container()),
                      items: list_filter.map((val) {
                        return DropdownMenuItem(
                          value: val,
                          child: Text(val),
                        );
                      }).toList(),
                      //  value: dropdownValue,
                      onChanged: (String? value) {
                        setState(() {
                          dropdownValue = value!;
                          _ordenar();
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.only(
                  top: Get.height * 0.01, left: Get.width * 0.04),
              child: Align(
                alignment: Alignment.topLeft,
                child: Text(
                  widget.category.name,
                  style: Theme.of(context).textTheme.headline1,
                ),
              ),
            ),
            FutureBuilder(
              future: _carregar(),
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
                      height: Get.height * 0.85,
                      width: Get.width,
                      child: Center(
                        child: Text(
                          "Sem Produtos...",
                          style: TextStyle(
                            fontFamily: AppFonts.poppinsBoldFont,
                            fontSize: Get.width * 0.035,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    );
                  } else {
                    return Container(
                      height: Get.height * 0.85,
                      margin: EdgeInsets.only(
                        left: Get.width * 0.05,
                        right: Get.width * 0.05,
                      ),
                      child: GridView.builder(
                          padding: EdgeInsets.only(
                            top: 0.0,
                          ),
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount:
                                      (Get.width == Orientation.portrait)
                                          ? 2
                                          : 2),
                          itemCount: list_product.length,
                          itemBuilder: (BuildContext ctx, index) {
                            var list = list_product[index];
                            return ProductListComponent(product: list);
                          }),
                    );
                  }
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
