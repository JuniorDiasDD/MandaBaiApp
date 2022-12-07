import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:manda_bai/Controller/cart_controller.dart';
import 'package:manda_bai/Core/app_colors.dart';
import 'package:manda_bai/Core/app_fonts.dart';

import 'package:manda_bai/Model/cart_model.dart';
import 'package:manda_bai/constants/controllers.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ItemCart extends StatefulWidget {
  final CartPageController cartPageController = Get.find();
  CartModel cartModel;
  int index;
  ItemCart({required this.cartModel, required this.index});

  @override
  _ItemCartState createState() => _ItemCartState();
}

class _ItemCartState extends State<ItemCart> {
  int quant = 0;
  double price = 0.0;

  @override
  void initState() {
    super.initState();
    setState(() {
      quant = widget.cartModel.amount;
      price = widget.cartModel.price/100;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
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
        height: Get.height * 0.16,
        child: Row(
          children: [
            Flexible(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  height: Get.width * 0.2,
                  width: Get.width * 0.2,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(
                        Radius.circular(10.0),
                      ),
                      color: Colors.white,
                      image: DecorationImage(
                        fit: BoxFit.fill,
                        image: NetworkImage(widget.cartModel.image),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Flexible(
              flex: 3,
              child: Container(
                margin: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Flexible(
                      flex: 2,
                      child: Row(
                        children: [
                          SizedBox(
                            width: Get.width * 0.4,
                            child: Text(
                              widget.cartModel.name,
                              maxLines: 2,
                              textAlign: TextAlign.start,
                              style: Theme.of(context).textTheme.headline2,
                            ),
                          ),
                          const Spacer(),
                          Obx(
                            () => Checkbox(
                              checkColor: Colors.white,
                              activeColor: AppColors.greenColor,
                              value: widget.cartPageController
                                  .list[widget.index].checkout,
                              onChanged: (bool? value) {
                                setState(() {
                                  // isChecked = value!;
                                  widget.cartPageController
                                      .checkBox(widget.cartModel.id, value);

                                  if (widget.cartPageController.deleteFull ==
                                      true) {
                                    if (value == false) {
                                      widget.cartPageController.deleteFull =
                                          false;
                                    }
                                  }
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    Text(
                      price.toString() +
                          fullControllerController.initialMoney.value,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.headline5,
                    ),
                    Flexible(
                      flex: 2,
                      child: Row(
                        children: <Widget>[
                          SizedBox(
                            width: Get.width * 0.08,
                            child: FloatingActionButton(
                              onPressed: () {
                                setState(
                                  () {
                                    if (quant != 1) {
                                      quant = quant - 1;
                                      setState(() {
                                        price = widget.cartModel.price * quant/100;
                                      });

                                      widget.cartPageController
                                          .decrementar(widget.cartModel.id);
                                      widget.cartPageController.calcule();
                                    }
                                  },
                                );
                              },
                              child: const Icon(
                                Icons.remove,
                                color: Colors.white,
                              ),
                              backgroundColor: quant > 1
                                  ? AppColors.greenColor
                                  : Colors.grey,
                              elevation: 0,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                              left: Get.width * 0.05,
                              right: Get.width * 0.05,
                            ),
                            child: Text(
                              quant.toString(),
                              style: const TextStyle(fontSize: 18.0),
                            ),
                          ),
                          SizedBox(
                            width: Get.width * 0.08,
                            child: FloatingActionButton(
                              child: const Icon(Icons.add, color: Colors.white),
                              backgroundColor: AppColors.greenColor,
                              elevation: 0,
                              onPressed: () {
                                setState(() {
                                  quant += 1;
                                  price = widget.cartModel.price * quant/100;
                                  widget.cartPageController
                                      .incrementar(widget.cartModel.id);
                                  widget.cartPageController.calcule();
                                });
                              },
                            ),
                          ),
                        ],
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
