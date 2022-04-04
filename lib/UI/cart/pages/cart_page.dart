import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:manda_bai/Controller/cart_controller.dart';
import 'package:manda_bai/Controller/mandaBaiController.dart';
import 'package:manda_bai/Core/app_colors.dart';
import 'package:manda_bai/Core/app_images.dart';
import 'package:manda_bai/Model/cart_model.dart';
import 'package:manda_bai/UI/cart/components/listview_item_cart.dart';
import 'package:manda_bai/UI/home/pop_up/popup_message_internet.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:websafe_svg/websafe_svg.dart';
import 'checkout_page_step_2.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CartPage extends StatefulWidget {
  const CartPage({Key? key}) : super(key: key);
  @override
  _StartPageState createState() => _StartPageState();
}

class _StartPageState extends State<CartPage> {
  final CartPageController cartPageController = Get.put(CartPageController());
  ConnectivityResult _connectionStatus = ConnectivityResult.none;
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;

  int net = 0;

  Future<void> initConnectivity() async {
    late ConnectivityResult result;
    try {
      result = await _connectivity.checkConnectivity();
    } on PlatformException catch (e) {
      print('Couldn\'t check connectivity status' + e.toString());
      return;
    }

    if (!mounted) {
      return Future.value(null);
    }
    return _updateConnectionStatus(result);
  }

  Future<void> _updateConnectionStatus(ConnectivityResult result) async {
    setState(() {
      _connectionStatus = result;
      print(_connectionStatus.toString());
      if (_connectionStatus == ConnectivityResult.none) {
        net = 1;
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return PopupMessageInternet(
                  mensagem: AppLocalizations.of(context)!.message_erro_internet,
                  icon: Icons.signal_wifi_off);
            });
      } else {
        if (net != 0) {
          Navigator.pop(context);
        }
      }
    });
  }

  @override
  void initState() {
    initConnectivity();
    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
    list_cart = [];
    cartPageController.total = 0;
    cartPageController.subTotal = 0;
    cartPageController.loading = false;
    cartPageController.deleteFull = false;
    super.initState();
  }

  @override
  void dispose() {
    _connectivitySubscription.cancel();
    super.dispose();
  }

  bool isChecked = false;
  String money = "";
  List<CartModel> list_cart = [];
  Future carregarCart() async {
    if (list_cart.isEmpty) {
      list_cart = await ServiceRequest.loadCart();
      if (list_cart.isEmpty) {
        return null;
      } else {
        final SharedPreferences prefs = await SharedPreferences.getInstance();
        money = prefs.getString('money')!;
        cartPageController.taxa = 5;
        var value;
        if (money == "USD") {
          value = await ServiceRequest.loadDolar();
        }
        for (int m = 0; m < list_cart.length; m++) {
          switch (money) {
            case 'USD':
              {
                if (value != false) {
                  double dolar = double.parse(value);
                  list_cart[m].price = list_cart[m].price / dolar;
                  cartPageController.taxa = 5 / dolar;
                }
                break;
              }
            case 'ECV':
              {
                list_cart[m].price = list_cart[m].price * 110.87;
                cartPageController.taxa = 5 * 110.87;
                break;
              }
          }
        }

        setState(() {
          cartPageController.list = list_cart;
          cartPageController.calcule();
        });
      }
    }

    return list_cart;
  }

  Future _carregarMoney() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    money = prefs.getString('money')!;
    return money;
  }

  _remover() async {
    setState(() {
      cartPageController.loading = true;
    });
    List<String> list_item = [];
    if (isChecked == true) {
      if (!cartPageController.list.isEmpty) {
        for (int i = 0; i < cartPageController.list.length; i++) {
          list_item.add(cartPageController.list[i].item_key);
        }

        list_cart = await ServiceRequest.removeCart(list_item);
        setState(() {
          list_cart;
          cartPageController.list = list_cart;
          cartPageController.calcule();
          cartPageController.loading = false;
        });
      }
    } else {
      bool check = false;
      for (int i = 0; i < cartPageController.list.length; i++) {
        if (cartPageController.list[i].checkout == true) {
          list_item.add(cartPageController.list[i].item_key);
          check = true;
        }
      }
      if (check == true) {
        list_cart = await ServiceRequest.removeCart(list_item);
        setState(() {
          list_cart;
          cartPageController.list = list_cart;
          cartPageController.calcule();
          cartPageController.loading = false;
        });
      } else {}
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        return new Future(() => false);
      },
      child: SafeArea(
        child: Scaffold(
          body: Stack(
            children: [
              SizedBox(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        color: Theme.of(context).primaryColor,
                        width: double.infinity,
                        child: Row(
                          children: [
                            const Spacer(),
                            Text(
                              AppLocalizations.of(context)!.title_my_cart,
                              style: Theme.of(context)
                                  .textTheme
                                  .headline3!
                                  .copyWith(
                                    color: Colors.white,
                                  ),
                            ),
                            const Spacer(),
                            Container(
                              child: Padding(
                                padding: const EdgeInsets.only(right: 8.0),
                                child: IconButton(
                                  onPressed: () {
                                    if (isChecked == false) {
                                      bool check = false;
                                      for (int i = 0;
                                          i < cartPageController.list.length;
                                          i++) {
                                        if (cartPageController
                                                .list[i].checkout ==
                                            true) {
                                          check = true;
                                          break;
                                        }
                                      }
                                      if (check) {
                                        _remover();
                                      }
                                    } else {
                                      _remover();
                                    }
                                  },
                                  icon: const Icon(
                                    Icons.delete,
                                    color: Colors.white,
                                  ),
                                  alignment: Alignment.centerRight,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: Get.height * 0.01),
                      SizedBox(
                        child: list_cart.isEmpty
                            ? null
                            : Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(
                                    AppLocalizations.of(context)!
                                        .text_select_all,
                                    style:
                                        Theme.of(context).textTheme.headline4,
                                  ),
                                  Obx(
                                    () => Checkbox(
                                      checkColor: Theme.of(context).cardColor,
                                      activeColor: AppColors.greenColor,
                                      value: cartPageController.deleteFull,
                                      onChanged: (bool? value) {
                                        setState(() {
                                          cartPageController.deleteFull =
                                              value!;
                                          cartPageController
                                              .checkBoxFull(value);
                                        });
                                      },
                                    ),
                                  ),
                                ],
                              ),
                      ),
                      FutureBuilder(
                        future: carregarCart(),
                        builder:
                            (BuildContext context, AsyncSnapshot snapshot) {
                          switch (snapshot.connectionState) {
                            case ConnectionState.waiting:
                              return Container(
                                height: Get.height * 0.2,
                                width: Get.width,
                                child: Center(
                                  child: Image.network(
                                    AppImages.loading,
                                    width: Get.width * 0.2,
                                    height: Get.height * 0.2,
                                    alignment: Alignment.center,
                                  ),
                                ),
                              );
                            default:
                              if (snapshot.data == null) {
                                return Container(
                                  width: Get.width,
                                  height: Get.height * 0.7,
                                  child: Column(
                                    children: [
                                      SizedBox(height: Get.height * 0.2),
                                      WebsafeSvg.asset(AppImages.cart_empyt),
                                      SizedBox(height: Get.height * 0.08),
                                      Text(
                                        AppLocalizations.of(context)!
                                            .text_empty_cart,
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline4,
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
                                          list.price * list.amount;
                                      return ItemCart(
                                        cartModel: list,
                                        index: index,
                                      );
                                    },
                                  ),
                                );
                              }
                          }
                        },
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            left: Get.height * 0.02, right: Get.height * 0.02),
                        child: SizedBox(
                          child: list_cart.isEmpty
                              ? null
                              : Column(
                                  children: [
                                    SizedBox(height: Get.height * 0.01),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          AppLocalizations.of(context)!
                                              .text_subtotal,
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline2,
                                        ),
                                        Row(
                                          children: [
                                            Obx(
                                              () => Text(
                                                money == "ECV"
                                                    ? cartPageController
                                                        .subTotal
                                                        .toStringAsFixed(0)
                                                    : cartPageController
                                                        .subTotal
                                                        .toStringAsFixed(2),
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .headline2,
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
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .headline3,
                                                    );
                                                  }
                                                }),
                                          ],
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: Get.height * 0.01),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          AppLocalizations.of(context)!
                                              .text_tax,
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline2,
                                        ),
                                        Row(
                                          children: [
                                            Obx(
                                              () => Text(
                                                money == "ECV"
                                                    ? cartPageController.taxa
                                                        .toStringAsFixed(0)
                                                    : cartPageController.taxa
                                                        .toStringAsFixed(2),
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .headline6,
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
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .headline6,
                                                    );
                                                  }
                                                }),
                                          ],
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: Get.height * 0.01),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          AppLocalizations.of(context)!
                                              .text_delivery,
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline2,
                                        ),
                                        Text(
                                          AppLocalizations.of(context)!
                                              .text_free,
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline1,
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: Get.height * 0.01),
                                    Text(
                                      AppLocalizations.of(context)!
                                          .text_description_delivery,
                                      style:
                                          Theme.of(context).textTheme.headline4,
                                    ),
                                    SizedBox(height: Get.height * 0.01),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          AppLocalizations.of(context)!
                                              .text_total,
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline1,
                                        ),
                                        Container(
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Obx(
                                                () => Text(
                                                  money == "ECV"
                                                      ? cartPageController.total
                                                          .toStringAsFixed(0)
                                                      : cartPageController.total
                                                          .toStringAsFixed(2),
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .headline5!
                                                      .copyWith(fontSize: 20),
                                                ),
                                              ),
                                              FutureBuilder(
                                                  future: _carregarMoney(),
                                                  builder: (BuildContext
                                                          context,
                                                      AsyncSnapshot snapshot) {
                                                    if (snapshot.data == null) {
                                                      return const Text(" ");
                                                    } else {
                                                      return Text(
                                                        " " + money,
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .headline5!
                                                            .copyWith(
                                                                fontSize: 20),
                                                      );
                                                    }
                                                  }),
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
                                        child: Text(
                                            AppLocalizations.of(context)!
                                                .text_checkout),
                                        onPressed: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  CheckoutPageStep2(
                                                      location: null),
                                            ),
                                          );
                                        },
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              new BorderRadius.circular(30.0),
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: Get.height * 0.02),
                                  ],
                                ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Obx(
                () => SizedBox(
                  child: cartPageController.loading
                      ? Container(
                          color: Colors.black54,
                          height: Get.height,
                          child: Center(
                            child: Image.network(
                              AppImages.loading,
                              width: Get.width * 0.2,
                              height: Get.height * 0.2,
                              alignment: Alignment.center,
                            ),
                          ),
                        )
                      : null,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
