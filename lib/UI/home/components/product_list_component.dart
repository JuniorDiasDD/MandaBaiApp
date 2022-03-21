import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:manda_bai/Controller/request.dart';
import 'package:manda_bai/Model/product.dart';
import 'package:manda_bai/UI/category_filter/controller/categoryController.dart';
import 'package:manda_bai/UI/description_product/pages/product_detail_page.dart';
import 'package:manda_bai/UI/home/pop_up/pop_login.dart';
import 'package:manda_bai/UI/home/pop_up/pop_up_message.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ProductListComponent extends StatefulWidget {
  Product product;

  ProductListComponent({Key? key, required this.product}) : super(key: key);

  @override
  State<ProductListComponent> createState() => _ProductListComponentState();
}

class _ProductListComponentState extends State<ProductListComponent> {
  final CategoryController controller = Get.find();
  bool checkFavorite = false;
  Future _addCart(id) async {
    bool check = await ServiceRequest.addCart(id, 1);
    return check;
  }

  var money_txt;
  Future _carregarMoney() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    money_txt = prefs.getString('money');

    return money_txt;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: OpenContainer(
        closedBuilder: (context, action) {
          return Container(
             color:Theme.of(context).cardColor,
            child: Column(
              children: [
                Container(
                  width: Get.width,
                  height: Get.width * 0.3,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(10.0),
                        topRight: Radius.circular(10.0)),
                    color: Colors.white,
                    image: DecorationImage(
                      fit: BoxFit.fill,
                      image: NetworkImage(widget.product.image),
                    ),
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Align(
                      alignment:Alignment.topLeft,
                      child: Padding(
                        padding: const EdgeInsets.only(
                          left: 8.0,
                        ),
                        child: Text(
                          widget.product.name,
                          maxLines: 1,
                          style: Theme
                              .of(context)
                              .textTheme
                              .headline4,
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                    
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                            left: 2.0,
                          ),
                          child: FutureBuilder(
                              future: _carregarMoney(),
                              builder: (BuildContext context,
                                  AsyncSnapshot snapshot) {
                                if (snapshot.data == null) {
                                  return const Text(" ");
                                } else {
                                  if (widget.product.price == 0.0) {
                                    return Text(
                                      AppLocalizations.of(context)!
                                          .no_stock,
                                      style: Theme
                                          .of(context)
                                          .textTheme
                                          .headline6!
                                          .copyWith(
                                        color: Colors.red,
                                      ),
                                    );
                                  } else {
                                    switch (money_txt) {
                                      case 'EUR':
                                        {
                                          return Text(
                                            widget.product.price
                                                .toStringAsFixed(2) +
                                                " €",
                                            style: Theme
                                                .of(context)
                                                .textTheme
                                                .headline5,
                                          );
                                        }
                                      case 'ECV':
                                        {
                                          return Text(
                                            widget.product.price
                                                .toStringAsFixed(0) +
                                                " \$",
                                            style: Theme
                                                .of(context)
                                                .textTheme
                                                .headline5,
                                          );
                                        }
                                      case 'USD':
                                        {
                                          return Text(
                                            "\$ " +
                                                widget.product.price
                                                    .toStringAsFixed(2),
                                            style: Theme
                                                .of(context)
                                                .textTheme
                                                .headline5,
                                          );
                                        }
                                    }
                                  }

                                  return Container();
                                }
                              }),
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              
                              height:  Get.width * 0.05,
                              child: IconButton(
                                padding: const EdgeInsets.all(0.0),
                                onPressed: () async {
                                  final SharedPreferences prefs =
                                      await SharedPreferences.getInstance();
                                  var check = prefs.getString('id');
                                  if (check == 'null' || check == null) {
                                    showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return const Pop_Login();
                                        });
                                  }else if (widget.product.favorite == false) {
                                    ServiceRequest.addFavrite(
                                        widget.product.id);
                                    setState(() {
                                      widget.product.favorite =
                                      !widget.product.favorite;
                                    });
                                  } else {
                                    ServiceRequest.removeFavrite(
                                        widget.product.id);
                                    setState(() {
                                      widget.product.favorite =
                                      !widget.product.favorite;
                                    });
                                  }
                                },
                                icon: const Icon(Icons.favorite),
                                iconSize: Get.width * 0.05,
                                alignment: Alignment.centerRight,
                                color: widget.product.favorite
                                    ? Colors.red
                                    : Theme
                                    .of(context)
                                    .indicatorColor,
                              ),
                            ),
                            SizedBox(
                              height:  Get.width * 0.05,
                              child: IconButton(
                                padding: const EdgeInsets.all(0.0),
                                onPressed: () async {
                                  final SharedPreferences prefs =
                                  await SharedPreferences.getInstance();
                                  var check = prefs.getString('id');
                                  if (check == 'null' || check == null) {
                                    showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return const Pop_Login();
                                        });
                                  } else {
                                    if (widget.product.price != 0.0) {
                                      setState(() {
                                        controller.loading = true;
                                      });
                                      var check =
                                      await _addCart(widget.product.id);
                                      if (check == true) {
                                        setState(() {
                                          controller.loading = false;
                                        });
                                        showDialog(
                                            context: context,
                                            builder: (
                                                BuildContext context) {
                                              return Pop_up_Message(
                                                  mensagem: AppLocalizations
                                                      .of(
                                                      context)!
                                                      .message_success_cart,
                                                  icon: Icons.check,
                                                  caminho: "addCarrinho");
                                            });
                                      } else {
                                        setState(() {
                                          controller.loading = false;
                                        });
                                        showDialog(
                                            context: context,
                                            builder: (
                                                BuildContext context) {
                                              return Pop_up_Message(
                                                  mensagem: AppLocalizations
                                                      .of(
                                                      context)!
                                                      .message_error_cart,
                                                  icon: Icons.error,
                                                  caminho: "erro");
                                            });
                                      }
                                    } else {
                                      showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return Pop_up_Message(
                                                mensagem:
                                                AppLocalizations.of(
                                                    context)!
                                                    .no_stock_description,
                                                icon: Icons.home_filled,
                                                caminho: "erro");
                                          });
                                    }
                                  }
                                },
                                icon: const Icon(
                                    Icons.shopping_cart_outlined),
                                iconSize: Get.width * 0.05,
                                alignment: Alignment.center,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          );
        },
          closedElevation: 5.0,
          closedShape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10)
          ),

        openBuilder: (context, action){
          return ProdutoDetailPage(
          product: widget.product,
          );
      }
      ),
    );
  }
}
