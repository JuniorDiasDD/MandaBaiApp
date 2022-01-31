import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:manda_bai/Controller/request.dart';
import 'package:manda_bai/Model/product.dart';
import 'package:manda_bai/UI/Favorite/controller/favorite_controller.dart';
import 'package:manda_bai/UI/home/pop_up/pop_login.dart';
import 'package:manda_bai/UI/home/pop_up/pop_up_message.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ItemFavoriteComponent extends StatefulWidget {
  Product product;
  ItemFavoriteComponent({Key? key, required this.product}) : super(key: key);

  @override
  _ItemFavoriteComponentState createState() => _ItemFavoriteComponentState();
}

class _ItemFavoriteComponentState extends State<ItemFavoriteComponent> {
  final FavoriteController controller = Get.find();
  bool isChecked = false;
  Future _addCart(id) async {
    bool check = await ServiceRequest.addCart(id, 1);
    return check;
  }

  String money = "";
  Future _carregarMoney() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    money = prefs.getString('money')!;
    return money;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: Get.width * 0.02,
        left: Get.width * 0.02,
        right: Get.width * 0.02,
        bottom: Get.width * 0.02,
      ),
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).dialogBackgroundColor,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Theme.of(context).cardColor,
              blurRadius: 2.0,
              offset: Offset(2.0, 2.0),
            )
          ],
        ),
        width: Get.width,
        height: Get.height * 0.15,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.network(
              widget.product.image,
              width: Get.width * 0.2,
              height: Get.height * 0.2,
              alignment: Alignment.center,
            ),
            Container(
              margin: EdgeInsets.only(
                left: Get.width * 0.01,
                top: Get.width * 0.04,
              ),
              width: Get.width * 0.62,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: Get.width * 0.35,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.product.name,
                              style: Theme.of(context).textTheme.headline4,
                            ),
                            FutureBuilder(
                                future: _carregarMoney(),
                                builder: (BuildContext context,
                                    AsyncSnapshot snapshot) {
                                  if (snapshot.data == null) {
                                    return const Text(" ");
                                  } else {
                                    if (widget.product.price == 0.0) {
                                      return Text(
                                        AppLocalizations.of(context)!.no_stock,
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline6!
                                            .copyWith(
                                              color: Colors.red,
                                            ),
                                      );
                                    } else {
                                      return Row(
                                        children: [
                                          Text(
                                            money == "ECV"
                                                ? widget.product.price
                                                    .toStringAsFixed(0)
                                                : widget.product.price
                                                    .toStringAsFixed(2),
                                            textAlign: TextAlign.center,
                                            style: Theme.of(context)
                                                .textTheme
                                                .headline5,
                                          ),
                                          Text(
                                            " " + money,
                                            style: Theme.of(context)
                                                .textTheme
                                                .headline5,
                                          ),
                                        ],
                                      );
                                    }
                                  }
                                }),
                          ],
                        ),
                      ),
                      Row(
                        children: [
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
                                      return Pop_Login();
                                    });
                              } else {
                                if (widget.product.price != 0.0) {
                                  setState(() {
                                    controller.loading = true;
                                  });
                                  var check = await _addCart(widget.product.id);
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
                                } else {
                                  showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return Pop_up_Message(
                                            mensagem:
                                                AppLocalizations.of(context)!
                                                    .no_stock_description,
                                            icon: Icons.home_filled,
                                            caminho: "erro");
                                      });
                                }
                              }
                            },
                            icon:  Icon(
                              Icons.shopping_cart,
                              color:controller.loading? Colors.green:Colors.black,
                            ),
                            iconSize: Get.width * 0.05,
                          ),
                          IconButton(
                            padding: const EdgeInsets.all(0.0),
                            onPressed: () {
                              setState(() {
                                ServiceRequest.removeFavrite(widget.product.id);
                                setState(() {
                                  bool check =
                                      controller.remover(widget.product.id);
                                  controller.vazio = check;
                                });
                              });
                            },
                            icon: const Icon(
                              Icons.delete,
                            ),
                            iconSize: Get.width * 0.05,
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
