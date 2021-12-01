import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:manda_bai/Controller/cart_controller.dart';
import 'package:manda_bai/Core/app_colors.dart';
import 'package:manda_bai/Core/app_fonts.dart';

import 'package:manda_bai/Model/cart_model.dart';

class ItemCart extends StatefulWidget {
  final CartPageController cartPageController = Get.find();
 CartModel cartModel;
  ItemCart(
      {required this.cartModel});

  @override
  _ItemCartState createState() => _ItemCartState();
}

class _ItemCartState extends State<ItemCart> {
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          const EdgeInsets.only(top: 4.0, left: 2.0, right: 2.0, bottom: 4.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: const [
            BoxShadow(
              color: Colors.grey,
              blurRadius: 2.0,
              //spreadRadius: 0.0,
              offset: Offset(2.0, 2.0), // shadow direction: bottom right
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
              widget.cartModel.image,
              width: Get.width * 0.2,
              height: Get.height * 0.2,
              alignment: Alignment.center,
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
                      Text(
                        widget.cartModel.name,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontFamily: AppFonts.poppinsBoldFont,
                          fontSize: 15,
                          color: Colors.black,
                        ),
                      ),
                      Checkbox(
                        checkColor: Colors.white,
                        activeColor: AppColors.greenColor,
                        value: isChecked,
                        onChanged: (bool? value) {
                          setState(() {
                            isChecked = value!;
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
                                      if (widget.cartModel.amount != 1) {
                                        widget.cartModel.amount = widget.cartModel.amount - 1;
                                        // widget.cartPageController.amount =
                                        //      widget.amount;
                                        widget.cartPageController.price =
                                            widget.cartModel.amount * double.parse(widget.cartModel.price);
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
                              widget.cartModel.amount.toString(),
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
                                    widget.cartModel.amount = widget.cartModel.amount + 1;
                                    widget.cartPageController.price =
                                        widget.cartModel.amount * double.parse(widget.cartModel.price);
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
                        child: Text(
                          widget.cartPageController.price.toString(),
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontFamily: AppFonts.poppinsBoldFont,
                            fontSize: 15,
                            color: AppColors.greenColor,
                          ),
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
