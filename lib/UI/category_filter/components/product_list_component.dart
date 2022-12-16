import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:manda_bai/Controller/request.dart';
import 'package:manda_bai/Core/app_colors.dart';
import 'package:manda_bai/Model/product.dart';
import 'package:manda_bai/UI/description_product/pages/product_detail_page.dart';
import 'package:manda_bai/UI/widget/dialog_custom.dart';
import 'package:manda_bai/UI/widget/dialogs.dart';
import 'package:manda_bai/constants/controllers.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ProductListComponent extends StatefulWidget {
 final Product product;
 final bool checkOption;

 const ProductListComponent({Key? key, required this.product,required this.checkOption}) : super(key: key);

  @override
  State<ProductListComponent> createState() => _ProductListComponentState();
}

class _ProductListComponentState extends State<ProductListComponent> {
  bool checkFavorite = false;

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
                            if (!await authenticationController.checkLogin()) {
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return DialogCustom(textButton: AppLocalizations.of(context)!.button_login,action: (){
                                      Navigator.pushNamed(context, '/login');
                                    },);
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
                                padding: const EdgeInsets.all(4.0),
                                child:  Icon(Icons.favorite,
                                  color: widget.product.favorite
                                      ? Colors.red
                                      : Colors.black54,)
                            ),
                          ),
                        ),
                       const SizedBox(
                          width: 4,
                        ),
                        GestureDetector(
                          onTap: () async {
                            if (!await authenticationController.checkLogin()) {
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return DialogCustom(textButton: AppLocalizations.of(context)!.button_login,action: (){
                                      Navigator.pushNamed(context, '/login');
                                    },);
                                  });
                            } else {
                              if (widget.product.price != 0.0) {
                                openLoadingStateDialog(context);
                                var result = await cartPageController.addCart(widget.product.id,1);
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
                                    style: Theme.of(context)
                                        .textTheme
                                        .labelSmall,
                                  ),
                                  backgroundColor:
                                  Theme.of(context).errorColor,
                                ));
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
                                child:  Icon(Icons.shopping_cart_outlined,color: Colors.black,),
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
                        height: Get.height * 0.07,
                        width: Get.width,
                       padding: const EdgeInsets.only(left: 4,right: 4),
                       color: AppColors.grey50.withOpacity(0.8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.product.name,
                              maxLines: 1,
                              style: Theme.of(context).textTheme.headline4!.copyWith(color: Colors.black),
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
