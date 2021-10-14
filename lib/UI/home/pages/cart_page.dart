import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:manda_bai/Controller/cart_controller.dart';
import 'package:manda_bai/Core/app_colors.dart';
import 'package:manda_bai/Core/app_fonts.dart';
import 'package:manda_bai/Core/app_images.dart';

import 'package:manda_bai/Model/cart_model.dart';
import 'package:manda_bai/UI/home/components/listview_item_cart.dart';
import 'package:websafe_svg/websafe_svg.dart';

import 'checkout_page_step_1.dart';

class CartPage extends StatefulWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  _StartPageState createState() => _StartPageState();
}

class _StartPageState extends State<CartPage> {
  List<CartModel> list_cart = [
    CartModel(id: 1, amount: 1, image: AppImages.tv, name: "Tv", price: 100.0),
    CartModel(
        id: 2,
        amount: 2,
        image: AppImages.tv,
        name: "Tv 55 Polegadas",
        price: 200.0),
    // CartModel(amount: 1, image: AppImages.tv, name: "Tv", price: 1200.0),
    // CartModel(amount: 2, image: AppImages.tv, name: "Tv", price: 1200.0),
  ];
  final CartPageController cartPageController = Get.put(CartPageController());

  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    cartPageController.list = list_cart;
    cartPageController.calcule();
    return Scaffold(
      body: Padding(
        padding:
            EdgeInsets.only(left: Get.width * 0.04, right: Get.width * 0.04),
        child: list_cart.isEmpty
            ? Center(
                child: Container(
                  width: Get.width,
                  height: Get.height,
                  child: Column(
                    children: [
                      SizedBox(height: Get.height * 0.08),
                      Text(
                        "Carrinho",
                        style: TextStyle(
                            fontFamily: AppFonts.poppinsBoldFont,
                            fontSize: Get.width * 0.05),
                      ),
                      SizedBox(height: Get.height * 0.2),
                      WebsafeSvg.asset(AppImages.cart_empyt),
                      SizedBox(height: Get.height * 0.08),
                      Text(
                        "O seu carrinho está vazio...",
                        style: TextStyle(
                            fontFamily: AppFonts.poppinsRegularFont,
                            fontSize: Get.width * 0.035),
                      ),
                    ],
                  ),
                ),
              )
            : SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(height: Get.height * 0.08),
                    Padding(
                      padding:
                          EdgeInsets.only(left: Get.width * 0.1, right: 10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('   '),
                          Text(
                            'Meu Carrinho',
                            style: TextStyle(
                              fontFamily: AppFonts.poppinsBoldFont,
                              fontSize: Get.width * 0.05,
                            ),
                          ),
                          IconButton(
                            padding: const EdgeInsets.all(0.0),
                            onPressed: () {},
                            icon: const Icon(
                              Icons.delete,
                              color: AppColors.greenColor,
                            ),
                            iconSize: Get.width * 0.05,
                            alignment: Alignment.centerRight,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: Get.height * 0.01),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          "Selecionar Todos",
                          style: TextStyle(
                              fontFamily: AppFonts.poppinsRegularFont),
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
                    Container(
                        height: Get.height * 0.45,
                        child: ListView.builder(
                          padding: EdgeInsets.all(0.0),
                          shrinkWrap: true,
                          itemCount: list_cart.length,
                          itemBuilder: (context, index) {
                            var list = list_cart[index];
                            //  cartPageController.name = list.name;
                            //  cartPageController.amount = list.amount;
                            cartPageController.price = list.price * list.amount;

                            return ItemCart(
                              id: list.id,
                              name: list.name,
                              image: list.image,
                              amount: list.amount,
                              price: list.price,
                            );
                          },
                        )),
                    SizedBox(height: Get.height * 0.01),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Sub Total: ",
                          style:
                              TextStyle(fontFamily: AppFonts.poppinsBoldFont),
                        ),
                        Obx(
                          () => Text(
                            cartPageController.subTotal.toString(),
                            style: TextStyle(
                              fontFamily: AppFonts.poppinsRegularFont,
                              color: AppColors.greenColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: Get.height * 0.01),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Taxa: ",
                          style:
                              TextStyle(fontFamily: AppFonts.poppinsBoldFont),
                        ),
                        Obx(
                          () => Text(
                            cartPageController.taxa.toString(),
                            style: TextStyle(
                              fontFamily: AppFonts.poppinsRegularFont,
                              color: AppColors.greenColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: Get.height * 0.01),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Entrega: ",
                          style:
                              TextStyle(fontFamily: AppFonts.poppinsBoldFont),
                        ),
                        Text(
                          "Gratis ",
                          style: TextStyle(
                            fontFamily: AppFonts.poppinsBoldFont,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: Get.height * 0.01),
                    Text(
                      "Envio totalmente Grátis. Cobramos apenas uma pequena taxa por utilização do site no valor de: € 5.00 ",
                      style: TextStyle(
                        fontFamily: AppFonts.poppinsRegularFont,
                        fontSize: 12,
                      ),
                    ),
                    SizedBox(height: Get.height * 0.01),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Total: ",
                          style: TextStyle(
                              fontFamily: AppFonts.poppinsBoldFont,
                              fontSize: 18),
                        ),
                        Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Obx(
                                () => Text(
                                  cartPageController.total.toString(),
                                  style: TextStyle(
                                    fontFamily: AppFonts.poppinsBoldFont,
                                    color: AppColors.greenColor,
                                    fontSize: 18,
                                  ),
                                ),
                              ),
                              Text(
                                "EUR",
                                style: TextStyle(
                                  fontFamily: AppFonts.poppinsRegularFont,
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: Get.height * 0.02),
                    Container(
                      height: Get.height * 0.05,
                      width: Get.width,
                      child: FlatButton(
                        padding: EdgeInsets.only(
                          left: Get.width * 0.05,
                          right: Get.height * 0.05,
                        ),
                        color: AppColors.greenColor,
                        textColor: Colors.white,
                        child: Text('Checkout'),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => CheckoutPage(),
                            ),
                          );
                        },
                        shape: RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(30.0),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
