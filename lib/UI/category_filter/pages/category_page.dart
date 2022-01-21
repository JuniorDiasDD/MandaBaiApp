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
import 'package:manda_bai/UI/category_filter/controller/categoryController.dart';
import 'package:manda_bai/UI/home/components/product_list_component.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CategoryPage extends StatefulWidget {
  Category category;
  String filter_most, filter_less;
  CategoryPage(
      {required this.category,
      required this.filter_most,
      required this.filter_less});

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  final CategoryController controller = Get.put(CategoryController());
  TextEditingController pesquisa = TextEditingController();
  List<Product> list_product = [];
  List<Product> list_product_full = [];
  String dropdownValue = '';
  List<String> list_filter = [];
  int size_list=0;
  _search() {
    list_product = [];
    setState(() {
      for (int i = 0; i < list_product_full.length; i++) {
        if (list_product_full[i].name.contains(pesquisa.text)) {
          list_product.add(list_product_full[i]);
          size_list=list_product.length;
        }
      }
    });
  }

  _ordenar() {
    list_product = [];
    setState(() {
      list_product = list_product_full;
      if (dropdownValue == widget.filter_less) {
        Comparator<Product> pesagemComparator =
            (a, b) => a.price.compareTo(b.price);
        list_product.sort(pesagemComparator);
        size_list=list_product.length;
      } else if (dropdownValue == widget.filter_most) {
        Comparator<Product> pesagemComparator =
            (a, b) => b.price.compareTo(a.price);
        list_product.sort(pesagemComparator);
        size_list=list_product.length;
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
        final String? itemFavortiesString = prefs.getString('itens_favorites');
        var money = prefs.getString('money');
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
        var value;
        if (money == "USD") {
          value = await ServiceRequest.loadDolar();
        }
        for (int m = 0; m < list_product.length; m++) {
          switch (money) {
            case 'USD':
              {
                if (value != false) {
                  double dolar = double.parse(value);
                  list_product[m].price = list_product[m].price / dolar;
                }
                break;
              }
            case 'ECV':
              {
                list_product[m].price = list_product[m].price * 110.87;
                break;
              }
          }
        }
        if (list_product_full.isEmpty) {
          list_product_full = list_product;
        }
      }
    }
   setState(() {
     size_list=list_product.length;
   });

    return list_product;
  }

  @override
  void initState() {
    super.initState();
    controller.loading = false;
    setState(() {
      dropdownValue = widget.filter_less;
      list_filter = [widget.filter_less, widget.filter_most];
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    /*24 is for notification bar on Android*/
    final double itemHeight = (size.height) / 3;
    final double itemWidth = size.width / 2;
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Column(
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
                            focusedBorder: const OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(30.0)),
                                borderSide:
                                    BorderSide(color: AppColors.greenColor)),
                            hintText: AppLocalizations.of(context)!.search,
                            hintStyle: Theme.of(context).textTheme.headline4,
                            contentPadding:
                                const EdgeInsets.only(top: 10, left: 15),
                            suffixIcon: const Icon(
                              Icons.search,
                              color: AppColors.greenColor,
                            ),
                            filled: true,
                            fillColor: Theme.of(context).backgroundColor,
                            border: const OutlineInputBorder(
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
                      widget.category.name+" ("+size_list.toString()+")",
                      style: Theme.of(context).textTheme.headline1,
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
                      if (snapshot.data == null) {
                        return Container(
                          height: Get.height * 0.4,
                          width: Get.width,
                          child: Center(
                            child: Text(
                              AppLocalizations.of(context)!.text_no_product,
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
                                              ? 3
                                              : 2,
                                    childAspectRatio: (itemWidth / itemHeight),),
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
          ],
        ),
      ),
    );
  }
}
