import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:manda_bai/Controller/cart_controller.dart';
import 'package:manda_bai/Core/app_colors.dart';
import 'package:manda_bai/Core/app_fonts.dart';

import 'package:manda_bai/Model/cart_model.dart';
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
  String money = "";
  Future _carregarMoney() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    money = prefs.getString('money')!;
    return money;
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      quant = widget.cartModel.amount;
      price = widget.cartModel.price;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
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
                margin: EdgeInsets.all(8.0),
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
                                      print(value.toString());
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
                    Flexible(
                      flex: 1,
                      child: FutureBuilder(
                          future: _carregarMoney(),
                          builder:
                              (BuildContext context, AsyncSnapshot snapshot) {
                            if (snapshot.data == null) {
                              return const Text(" ");
                            } else {
                              return Row(
                                children: [
                                  Text(
                                    money == "ECV"
                                        ? price.toStringAsFixed(0)
                                        : price.toStringAsFixed(2),
                                    textAlign: TextAlign.center,
                                    style:
                                        Theme.of(context).textTheme.headline5,
                                  ),
                                  Text(
                                    " " + money,
                                    style:
                                        Theme.of(context).textTheme.headline5,
                                  ),
                                ],
                              );
                            }
                          }),
                    ),
                    Flexible(
                      flex: 2,
                      child: Row(
                        children: <Widget>[
                          Container(
                            width: Get.width * 0.08,
                            child: FloatingActionButton(
                              onPressed: () {
                                setState(
                                  () {
                                    if (quant != 1) {
                                      quant = quant - 1;
                                      setState(() {
                                        price = widget.cartModel.price * quant;
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
                              style: TextStyle(fontSize: 18.0),
                            ),
                          ),
                          Container(
                            width: Get.width * 0.08,
                            child: FloatingActionButton(
                              child: Icon(Icons.add, color: Colors.white),
                              backgroundColor: AppColors.greenColor,
                              elevation: 0,
                              onPressed: () {
                                setState(() {
                                  quant += 1;
                                  price = widget.cartModel.price * quant;
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
