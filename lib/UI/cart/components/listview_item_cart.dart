import 'package:flutter/material.dart';
import 'package:flutter_session/flutter_session.dart';
import 'package:get/get.dart';
import 'package:manda_bai/Controller/cart_controller.dart';
import 'package:manda_bai/Core/app_colors.dart';
import 'package:manda_bai/Core/app_fonts.dart';

import 'package:manda_bai/Model/cart_model.dart';

class ItemCart extends StatefulWidget {
  final CartPageController cartPageController = Get.find();
  CartModel cartModel;
  ItemCart({required this.cartModel});

  @override
  _ItemCartState createState() => _ItemCartState();
}

class _ItemCartState extends State<ItemCart> {
  bool isChecked = false;
  int quant = 0;
  double price = 0.0;
  String money = "";
  Future _carregarMoney() async {
    money = await FlutterSession().get('money');
    return money;
  }

  @override
  void initState() {
    // TODO: implement initState
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
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(10.0),
                      bottomLeft: Radius.circular(10.0)),
                  color: Colors.white,
                  image: DecorationImage(
                    fit: BoxFit.fill,
                    image: NetworkImage(widget.cartModel.image),
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
                    Row(
                      children: [
                        Flexible(
                          flex: 4,
                          child: Text(
                            widget.cartModel.name,
                            textAlign: TextAlign.start,
                            style: const TextStyle(
                              fontFamily: AppFonts.poppinsBoldFont,
                              fontSize: 15,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        Flexible(
                          flex: 1,
                          child: Checkbox(
                            checkColor: Colors.white,
                            activeColor: AppColors.greenColor,
                            value: isChecked,
                            onChanged: (bool? value) {
                              setState(() {
                                isChecked = value!;
                                widget.cartPageController
                                    .checkBox(widget.cartModel.id, isChecked);
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                    const Spacer(),
                    Row(
                      children: [
                        Text(
                          price.toStringAsFixed(0),
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.headline5,
                        ),
                        FutureBuilder(
                            future: _carregarMoney(),
                            builder:
                                (BuildContext context, AsyncSnapshot snapshot) {
                              if (snapshot.data == null) {
                                return const Text(" ");
                              } else {
                                return Text(
                                  " " + money,
                                  style: Theme.of(context).textTheme.headline5,
                                );
                              }
                            }),
                      ],
                    ),
                    const Spacer(),
                    Row(
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
                            child: Icon(
                              Icons.remove,
                              color: Colors.white,
                            ),
                            backgroundColor: AppColors.greenColor,
                            elevation: 0,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            left: 10.0,
                            right: 10.0,
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
