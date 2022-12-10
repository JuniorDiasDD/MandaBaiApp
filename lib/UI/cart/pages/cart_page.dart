import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:manda_bai/Core/app_colors.dart';
import 'package:manda_bai/Core/app_images.dart';
import 'package:manda_bai/UI/cart/components/listview_item_cart.dart';
import 'package:manda_bai/UI/home/pop_up/popup_message_internet.dart';
import 'package:manda_bai/UI/widget/button_ui.dart';
import 'package:manda_bai/UI/widget/dialogs.dart';
import 'package:manda_bai/constants/controllers.dart';
import 'package:websafe_svg/websafe_svg.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CartPage extends StatefulWidget {
  const CartPage({Key? key}) : super(key: key);
  @override
  _StartPageState createState() => _StartPageState();
}

class _StartPageState extends State<CartPage> {
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
    cartPageController.total = 0;
    cartPageController.subTotal = 0;
    cartPageController.loading = false;
    cartPageController.deleteFull = false;
    cartPageController.calcule();
    super.initState();
  }

  @override
  void dispose() {
    _connectivitySubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        return Future(() => false);
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
                        width: double.infinity,
                        padding:
                            const EdgeInsets.only(left: 16, right: 16, top: 16),
                        child: Row(
                          children: [
                            TextButton(
                              child: Text(
                                  "< " +
                                      AppLocalizations.of(context)!
                                          .title_my_cart,
                                  style:
                                      Theme.of(context).textTheme.headline3!),
                              onPressed: () => Navigator.pop(context),
                            ),
                            const Spacer(),
                            GestureDetector(
                              onTap: () async {
                                if (!cartPageController.isChecked.value) {
                                  bool check = false;
                                  for (int i = 0;
                                      i < cartPageController.list.length;
                                      i++) {
                                    if (cartPageController.list[i].checkout) {
                                      check = true;
                                      break;
                                    }
                                  }
                                  if (check) {
                                    openLoadingStateDialog(context);
                                   await cartPageController.remover();
                                    Navigator.pop(context);
                                  }
                                } else {
                                  openLoadingStateDialog(context);
                                  await cartPageController.remover();
                                  Navigator.pop(context);
                                }
                              },
                              child: Container(
                                width: Get.width * 0.1,
                                height: Get.width * 0.1,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  color: AppColors.grey50.withOpacity(0.8),
                                ),
                                child: const Padding(
                                  padding: EdgeInsets.all(6.0),
                                  child: Icon(
                                    Icons.delete_outline,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: Get.height * 0.01),
                      SizedBox(
                        child: cartPageController.listCart.isEmpty
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
                      if (cartPageController.listCart.isEmpty)
                        SizedBox(
                          width: Get.width,
                          height: Get.height * 0.7,
                          child: Column(
                            children: [
                              SizedBox(height: Get.height * 0.2),
                              WebsafeSvg.asset(AppImages.cart_empyt),
                              SizedBox(height: Get.height * 0.08),
                              Text(
                                AppLocalizations.of(context)!.text_empty_cart,
                                style: Theme.of(context).textTheme.headline4,
                              ),
                            ],
                          ),
                        ),
                      if (cartPageController.listCart.isNotEmpty)
                        SizedBox(
                          height: Get.height * 0.45,
                          child: Obx(
                              ()=> ListView.builder(
                              padding: const EdgeInsets.all(0.0),
                              shrinkWrap: true,
                              scrollDirection: Axis.vertical,
                              itemCount: cartPageController.listCart.length,
                              itemBuilder: (BuildContext context, index) {
                                var list = cartPageController.listCart[index];
                                cartPageController.price =
                                    list.price * list.amount;
                                return ItemCart(
                                  cartModel: list,
                                  index: index,
                                );
                              },
                            ),
                          ),
                        ),
                      Padding(
                        padding: EdgeInsets.only(
                            left: Get.height * 0.02, right: Get.height * 0.02),
                        child: Obx(
                          () => SizedBox(
                            child: cartPageController.listCart.isEmpty
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
                                                  fullControllerController
                                                              .initialMoney
                                                              .value ==
                                                          "ECV"
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
                                              Text(
                                                " " +
                                                    fullControllerController
                                                        .initialMoney.value,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .headline3,
                                              ),
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
                                                  fullControllerController
                                                              .initialMoney
                                                              .value ==
                                                          "ECV"
                                                      ? cartPageController.taxa
                                                          .toStringAsFixed(0)
                                                      : cartPageController.taxa
                                                          .toStringAsFixed(2),
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .headline6,
                                                ),
                                              ),
                                              Text(
                                                " " +
                                                    fullControllerController
                                                        .initialMoney.value,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .headline6,
                                              )
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
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline4,
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
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Obx(
                                                () => Text(
                                                  fullControllerController
                                                              .initialMoney
                                                              .value ==
                                                          "ECV"
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
                                              Text(
                                                " " +
                                                    fullControllerController
                                                        .initialMoney.value,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .headline5!
                                                    .copyWith(fontSize: 20),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: Get.height * 0.02),
                                      ButtonUI(
                                          action: () async {
                                            locationController.carregarLocation();
                                            Navigator.pushNamed(
                                                context, "/checkoutFinal");
                                          },
                                          label: AppLocalizations.of(context)!
                                              .text_checkout),
                                      SizedBox(height: Get.height * 0.02),
                                    ],
                                  ),
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
                            child: SizedBox(
                                width: 32,
                                height: 32,
                                child: CircularProgressIndicator(
                                  color: Theme.of(context).primaryColor,
                                  strokeWidth: 2,
                                )),
                          ))
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
