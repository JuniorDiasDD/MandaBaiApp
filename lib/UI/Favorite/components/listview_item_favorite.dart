import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:manda_bai/Controller/request.dart';
import 'package:manda_bai/Model/product.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:manda_bai/UI/widget/dialogs.dart';
import 'package:manda_bai/constants/controllers.dart';

class ItemFavoriteComponent extends StatefulWidget {
  final Product product;
  const ItemFavoriteComponent({Key? key, required this.product})
      : super(key: key);

  @override
  _ItemFavoriteComponentState createState() => _ItemFavoriteComponentState();
}

class _ItemFavoriteComponentState extends State<ItemFavoriteComponent> {
  bool isChecked = false;

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
              offset: const Offset(2.0, 2.0),
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
                            SizedBox(
                              child: widget.product.price == 0.0
                                  ? Text(
                                      AppLocalizations.of(context)!.no_stock,
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline6!
                                          .copyWith(
                                            color: Colors.red,
                                          ),
                                    )
                                  : Row(
                                      children: [
                                        Text(
                                          fullControllerController
                                                      .initialMoney.value ==
                                                  "ECV"
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
                                          " " +
                                              fullControllerController
                                                  .initialMoney.value,
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline5,
                                        ),
                                      ],
                                    ),
                            ),
                          ],
                        ),
                      ),
                      Row(
                        children: [
                          IconButton(
                            padding: const EdgeInsets.all(0.0),
                            onPressed: () async {
                              if (widget.product.price != 0.0) {
                                openLoadingStateDialog(context);
                                var result = await favoriteController
                                    .addCart(widget.product.id);
                                Navigator.pop(context);
                                if (result.success) {
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(SnackBar(
                                    content: Text(
                                      AppLocalizations.of(context)!
                                          .message_success_cart,
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelSmall,
                                    ),
                                    backgroundColor:
                                        Theme.of(context).primaryColor,
                                  ));
                                } else {
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(SnackBar(
                                    content: Text(
                                      result.errorMessage!,
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelSmall,
                                    ),
                                    backgroundColor:
                                        Theme.of(context).errorColor,
                                  ));
                                }
                              } else {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(SnackBar(
                                  content: Text(
                                    AppLocalizations.of(context)!
                                        .no_stock_description,
                                    style:
                                        Theme.of(context).textTheme.labelSmall,
                                  ),
                                  backgroundColor: Theme.of(context).errorColor,
                                ));
                              }
                            },
                            icon: Icon(
                              Icons.shopping_cart,
                              color: Theme.of(context).brightness ==
                                      Brightness.dark
                                  ? Colors.white
                                  : Colors.black,
                            ),
                            iconSize: Get.width * 0.05,
                          ),
                          IconButton(
                            padding: const EdgeInsets.all(0.0),
                            onPressed: () {
                              setState(() {
                                ServiceRequest.removeFavrite(widget.product.id);
                                setState(() {
                                  bool check = favoriteController
                                      .remover(widget.product.id);
                                  favoriteController.vazio = check;
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
