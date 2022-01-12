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
    return GestureDetector(
      onTap: () {
        if (controller.loading == false) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ProdutoDetailPage(
                product: widget.product,
              ),
            ),
          );
        }
      },
      child: Padding(
        padding: EdgeInsets.only(
            left: Get.width * 0.023,
            top: Get.height * 0.009,
            bottom: Get.height * 0.005),
        child: Container(
            height: Get.height * 0.05,
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Theme.of(context).cardColor,
                blurRadius: 1.0,
                spreadRadius: 0.0,
                offset: const Offset(1.0, 1.0),
              ),
            ],
          ),
          child: Column(
            children: [
              Flexible(
                flex: 2,
                child: Container(
                  width: Get.width,
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
              ),
              Flexible(
                flex: 1,
                child: Column(
                  children: [
                    Flexible(
                      flex: 1,
                      child: Text(
                        widget.product.name,
                        maxLines: 1,
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.headline4,
                      ),
                    ),
                    Flexible(
                      flex: 1,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          SizedBox(
                            child: Padding(
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
                                      switch (money_txt) {
                                        case 'EUR':
                                          {
                                            return Text(
                                              widget.product.price
                                                      .toStringAsFixed(2) +
                                                  " €",
                                              style: Theme.of(context)
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
                                              style: Theme.of(context)
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
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .headline5,
                                            );
                                          }
                                      }
                                      return Container();
                                    }
                                  }),
                            ),
                          ),
                          Row(
                            children: [
                              IconButton(
                                padding: const EdgeInsets.all(0.0),
                                onPressed: () {
                                  if (widget.product.favorite == false) {
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
                                    : Theme.of(context).indicatorColor,
                              ),
                              IconButton(
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
                                          builder: (BuildContext context) {
                                            return Pop_up_Message(
                                                mensagem:
                                                    AppLocalizations.of(context)!
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
                                          builder: (BuildContext context) {
                                            return Pop_up_Message(
                                                mensagem:
                                                    AppLocalizations.of(context)!
                                        .message_error_cart,
                                                icon: Icons.error,
                                                caminho: "erro");
                                          });
                                    }
                                  }
                                },
                                icon: const Icon(Icons.shopping_cart_outlined),
                                iconSize: Get.width * 0.05,
                                alignment: Alignment.center,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      // onTap: onTap,
    );
  }
}
