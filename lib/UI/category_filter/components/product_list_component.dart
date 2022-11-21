import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:manda_bai/Controller/request.dart';
import 'package:manda_bai/Core/app_colors.dart';
import 'package:manda_bai/Model/product.dart';
import 'package:manda_bai/UI/description_product/pages/product_detail_page.dart';
import 'package:manda_bai/UI/home/pop_up/pop_login.dart';
import 'package:manda_bai/UI/home/pop_up/pop_up_message.dart';
import 'package:manda_bai/constants/controllers.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ProductListComponent extends StatefulWidget {
  Product product;
  bool checkOption;

  ProductListComponent({Key? key, required this.product,required this.checkOption}) : super(key: key);

  @override
  State<ProductListComponent> createState() => _ProductListComponentState();
}

class _ProductListComponentState extends State<ProductListComponent> {
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
      padding: const EdgeInsets.only(left: 10),
      child: OpenContainer(
          closedBuilder: (context, action) {
            return Container(
              width: Get.width * 0.35,
              height: Get.width * 0.25,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                color: Theme.of(context).backgroundColor,
                image: DecorationImage(
                  fit: BoxFit.fill,
                  image: NetworkImage(widget.product.image),
                ),
              ),
              child: Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: widget.checkOption ? Row(
                     mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        GestureDetector(
                          onTap: () async {
                            final SharedPreferences prefs =
                                await SharedPreferences.getInstance();
                            var check = prefs.getString('id');
                            if (check == 'null' || check == null) {
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return const Pop_Login();
                                  });
                            } else if (widget.product.favorite == false) {
                              ServiceRequest.addFavrite(widget.product.id);
                              setState(() {
                                widget.product.favorite =
                                    !widget.product.favorite;
                              });
                            } else {
                              mandaBaiProductController
                                  .removeFavrite(widget.product.id);
                              setState(() {
                                widget.product.favorite =
                                    !widget.product.favorite;
                              });
                            }
                          },
                          child: Container(
                            width: Get.width * 0.08,
                            height: Get.width * 0.08,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              color: AppColors.grey50.withOpacity(0.8),
                            ),
                            child:  Padding(
                                padding: EdgeInsets.all(4.0),
                                child:  Icon(Icons.favorite,
                                  color: widget.product.favorite
                                      ? Colors.red
                                      : Theme.of(context).indicatorColor,)
                            ),
                          ),
                        ),
                       const SizedBox(
                          width: 4,
                        ),
                        GestureDetector(
                          onTap: () async {
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
                                  productController.loading = true;
                                });
                                var check = await _addCart(widget.product.id);
                                if (check == true) {
                                  setState(() {
                                    productController.loading = false;
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
                                    productController.loading = false;
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
                          child: Container(
                            width: Get.width * 0.08,
                            height: Get.width * 0.08,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              color: AppColors.grey50.withOpacity(0.8),
                            ),
                            child:  const Padding(
                                padding: EdgeInsets.all(4.0),
                                child:  Icon(Icons.shopping_cart_outlined),
                            ),
                          ),
                        ),
                      ],
                    ): null,
                  ),
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: Get.height * 0.05,
                        width: Get.width,
                       padding: const EdgeInsets.only(left: 4,right: 4),
                       color: AppColors.grey50.withOpacity(0.8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.product.name,
                              maxLines: 1,
                              style: Theme.of(context).textTheme.headline4,
                            ),
                            Container(
                              child: productController.convertPriceProduct(
                                          widget.product.price) ==
                                      null
                                  ? Text(
                                      AppLocalizations.of(context)!.no_stock,
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline6!
                                          .copyWith(
                                            color: Colors.red,
                                          ),
                                    )
                                  : Text(
                                      productController.convertPriceProduct(
                                          widget.product.price),
                                      style:
                                          Theme.of(context).textTheme.headline5,
                                    ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
          closedElevation: 5.0,
          closedShape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          openBuilder: (context, action) {
            return ProdutoDetailPage(
              product: widget.product,
            );
          }),
    );
  }
}
