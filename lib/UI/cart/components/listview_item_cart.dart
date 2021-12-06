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
      padding:
          const EdgeInsets.only(top: 4.0, left: 2.0, right: 2.0, bottom: 4.0),
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
        height: Get.height * 0.15,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: Get.width * 0.23,
              height: Get.height,
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
            Container(
              margin: EdgeInsets.only(
                left: 10,
              ),
              width: Get.width * 0.62,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
               
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                         width: Get.width*0.5,
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
                      Checkbox(
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
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: Get.width * 0.3,
                        height: Get.height * 0.06,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                          price =
                                              widget.cartModel.price * quant;
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
                            Text(
                              quant.toString(),
                              style: TextStyle(fontSize: 18.0),
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
                      Padding(
                        padding: EdgeInsets.only(right: Get.width * 0.02),
                        child: Row(
                          children: [
                            Text(
                              price.toStringAsFixed(0),
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontFamily: AppFonts.poppinsBoldFont,
                                fontSize: 15,
                                color: AppColors.greenColor,
                              ),
                            ),
                            FutureBuilder(
                                future: _carregarMoney(),
                                builder: (BuildContext context,
                                    AsyncSnapshot snapshot) {
                                  if (snapshot.data == null) {
                                    return const Text(" ");
                                  } else {
                                    return Text(
                                      " " + money,
                                      style:
                                          Theme.of(context).textTheme.headline3,
                                    );
                                  }
                                }),
                          ],
                        ),
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
