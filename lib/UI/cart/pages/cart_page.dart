import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:manda_bai/Controller/cart_controller.dart';
import 'package:manda_bai/Controller/request.dart';
import 'package:manda_bai/Core/app_colors.dart';
import 'package:manda_bai/Core/app_fonts.dart';
import 'package:manda_bai/Core/app_images.dart';
import 'package:manda_bai/Model/cart_model.dart';
import 'package:manda_bai/UI/cart/components/listview_item_cart.dart';
import 'package:websafe_svg/websafe_svg.dart';
import 'checkout_page_step_2.dart';

class CartPage extends StatefulWidget {
  const CartPage({Key? key}) : super(key: key);
  @override
  _StartPageState createState() => _StartPageState();
}

class _StartPageState extends State<CartPage> {
  final CartPageController cartPageController = Get.put(CartPageController());

  bool isChecked = false;
  List<CartModel> list_cart = [];
  Future carregarCart() async {
    if (list_cart.isEmpty) {
      list_cart = await ServiceRequest.loadCart();
      if (list_cart.isEmpty) {
        return null;
      } else {
        setState(() {
          cartPageController.list = list_cart;
          cartPageController.calcule();
        });
      }
    }

    return list_cart;
  }

  @override
  void initState() {
    super.initState();
    carregarCart();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        return new Future(() => false);
      },
      child: Scaffold(
        body: Padding(
          padding:
              EdgeInsets.only(left: Get.width * 0.04, right: Get.width * 0.04),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: Get.height * 0.08),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: Get.width * 0.1,
                    ),
                    Text(
                      'Meu Carinho',
                      style: Theme.of(context).textTheme.headline1,
                    ),
                    Container(
                      child: IconButton(
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
                      style:Theme.of(context).textTheme.headline4,
                    ),
                    Checkbox(
                      checkColor: Theme.of(context).cardColor,
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
                          width: Get.width,
                          height: Get.height,
                          child: Column(
                            children: [
                              SizedBox(height: Get.height * 0.2),
                              WebsafeSvg.asset(AppImages.cart_empyt),
                              SizedBox(height: Get.height * 0.08),
                              Text(
                                "O seu carrinho está vazio...",
                                style: Theme.of(context).textTheme.headline4,
                              ),
                            ],
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

                              cartPageController.price =
                                  double.parse(list.price) * list.amount;
                              return ItemCart(
                                cartModel: list,
                              );
                            },
                          ),
                        );
                      }
                    }
                  },
                ),
                SizedBox(height: Get.height * 0.01),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Sub Total: ",
                      style: Theme.of(context).textTheme.headline2,
                    ),
                    Obx(
                      () => Text(
                        cartPageController.subTotal.toString(),
                        style: Theme.of(context).textTheme.headline2,
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
                      style: Theme.of(context).textTheme.headline2,
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
                      style: Theme.of(context).textTheme.headline2,
                    ),
                    Text(
                      "Gratis ",
                      style: Theme.of(context).textTheme.headline1,
                    ),
                  ],
                ),
                SizedBox(height: Get.height * 0.01),
                Text(
                  "Envio totalmente Grátis. Cobramos apenas uma pequena taxa por utilização do site no valor de: € 5.00 ",
                  style: Theme.of(context).textTheme.headline4,
                ),
                SizedBox(height: Get.height * 0.01),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Total: ",
                      style: Theme.of(context).textTheme.headline1,
                    ),
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Obx(
                            () => Text(
                              cartPageController.total.toStringAsFixed(2),
                              style: const TextStyle(
                                fontFamily: AppFonts.poppinsBoldFont,
                                color: AppColors.greenColor,
                                fontSize: 18,
                              ),
                            ),
                          ),
                          Text(
                            "EUR",
                            style: Theme.of(context).textTheme.headline4,
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
