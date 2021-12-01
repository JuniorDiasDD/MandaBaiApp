import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:manda_bai/Controller/cart_controller.dart';
import 'package:manda_bai/Controller/request.dart';
import 'package:manda_bai/Core/app_colors.dart';
import 'package:manda_bai/Core/app_fonts.dart';
import 'package:manda_bai/Core/app_images.dart';
import 'package:manda_bai/Model/cart_model.dart';
import 'package:manda_bai/UI/cart/components/listview_item_cart.dart';
import 'package:manda_bai/UI/home/components/header.dart';
import 'package:manda_bai/UI/home/components/menu.dart';
import 'package:websafe_svg/websafe_svg.dart';

import 'checkout_page_step_1.dart';
import 'checkout_page_step_2.dart';

class CartPage extends StatefulWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  _StartPageState createState() => _StartPageState();
}

class _StartPageState extends State<CartPage> {
 
  final CartPageController cartPageController = Get.put(CartPageController());

  bool isChecked = false;
List<CartModel> list_cart= [];
  Future carregarCart() async {
    list_cart = await ServiceRequest.loadCart();
    if (list_cart.isEmpty) {
      return null;
    }

    return list_cart;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    carregarCart();
  }
  @override
  Widget build(BuildContext context) {
    cartPageController.list = list_cart;
    cartPageController.calcule();
    return WillPopScope(
      onWillPop: () {
        return new Future(() => false);
      },
      child: Scaffold(
      /*  appBar: AppBar(
          // backgroundColor: Colors.white,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Meu Carinho',
                style: TextStyle(
                  fontFamily: AppFonts.poppinsRegularFont,
                ),
              ),
              IconButton(
                padding: EdgeInsets.only(
                  right: Get.width * 0.02,
                ),
                onPressed: () {},
                icon: const Icon(
                  Icons.delete,
                  color: Colors.white,
                ),
                iconSize: Get.width * 0.05,
                alignment: Alignment.centerRight,
              ),
            ],
          ),
        ),*/
        //drawer: Menu(),
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                           width: Get.width*0.1,
                          ),
                          Text(
                            'Meu Carinho',
                            style: TextStyle(
                                fontFamily: AppFonts.poppinsBoldFont,
                                fontSize: Get.width * 0.05),
                          ),
                           Container(
                            child: IconButton(
                              // padding: EdgeInsets.all(0.0),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              icon: const Icon(
                                Icons.delete,
                              ),
                              alignment: Alignment.centerRight,
                            ),
                          ),
                        ],
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
                      FutureBuilder(
                  future: carregarCart(),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (!snapshot.hasData) {
                      return Container(
                        height: Get.height * 0.2,
                        width: Get.width,
                        child: Center(
                          child: Image.asset(
                            AppImages.loading,
                            width: Get.width * 0.2,
                            height: Get.height * 0.2,
                            alignment: Alignment.center,
                          ),
                        ),
                      );
                    } else {
                      if (snapshot.data == null) {
                        return Container(
                          height: Get.height * 0.2,
                          width: Get.width,
                          child: Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.public_off_outlined,
                                  color: Colors.grey,
                                  size: Get.height * 0.06,
                                ),
                                Text(
                                  "Serviço Indispónivel.\n Tente mais tarde...",
                                  style: TextStyle(
                                    fontFamily: AppFonts.poppinsBoldFont,
                                    fontSize: Get.width * 0.035,
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      } else {
                        return Container(
                           height: Get.height * 0.45,
                          child: ListView.builder(
                           padding: EdgeInsets.all(0.0),
                          shrinkWrap: true,
                            scrollDirection: Axis.vertical,
                            itemCount: snapshot.data.length,
                            itemBuilder: (BuildContext context, index) {
                             var list = list_cart[index];
                            //  cartPageController.name = list.name;
                            //  cartPageController.amount = list.amount;
                            cartPageController.price = double.parse(list.price) * list.amount;
                            return ItemCart(
                              cartModel:list,
                            );
                            },
                          ),
                        );
                      }
                    }
                  },
                ),
                     /* Container(
                        height: Get.height * 0.45,
                        child: ListView.builder(
                          padding: EdgeInsets.all(0.0),
                          shrinkWrap: true,
                          itemCount: list_cart.length,
                          itemBuilder: (context, index) {
                            var list = list_cart[index];
                            //  cartPageController.name = list.name;
                            //  cartPageController.amount = list.amount;
                            cartPageController.price = double.parse(list.price) * list.amount;
                            return ItemCart(
                              cartModel:list,
                            );
                          },
                        ),
                      ),*/

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
                                    cartPageController.total.toStringAsFixed(2),
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
                                builder: (context) => CheckoutPageStep2(),
                              ),
                            );
                          },
                          shape: RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(30.0),
                          ),
                        ),
                      ),
                      SizedBox(height: Get.height * 0.02),
                    ],
                  ),
                ),
        ),
      ),
    );
  }
}
