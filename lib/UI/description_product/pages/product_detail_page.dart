import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:manda_bai/Controller/request.dart';
import 'package:get/get.dart';
import 'package:manda_bai/Core/app_images.dart';
import 'package:manda_bai/Model/product.dart';
import 'package:manda_bai/UI/widget/button_ui.dart';
import 'package:manda_bai/UI/widget/dialog_custom.dart';
import 'package:manda_bai/UI/home/pop_up/popup_message_internet.dart';
import 'package:manda_bai/UI/widget/dialogs.dart';
import 'package:manda_bai/constants/controllers.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ProdutoDetailPage extends StatefulWidget {
  final Product product;
  const ProdutoDetailPage({Key? key, required this.product}) : super(key: key);
  @override
  State<ProdutoDetailPage> createState() => _ProdutoDetailPageState();
}

class _ProdutoDetailPageState extends State<ProdutoDetailPage> {
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
    super.initState();
    initConnectivity();

    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
  }

  @override
  void dispose() {
    _connectivitySubscription.cancel();
    super.dispose();
  }

  int quantidade = 1;
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: Get.height * 0.86,
                child: SingleChildScrollView(
                  child: Stack(
                    children: [
                      Column(
                        children: [
                          Stack(
                            children: [
                              Container(
                                width: Get.width,
                                height: Get.height * 0.4,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  image: DecorationImage(
                                    fit: BoxFit.fill,
                                    image: NetworkImage(widget.product.image),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 10.0, top: 10.0),
                                child: Align(
                                  alignment: Alignment.topLeft,
                                  child: Container(
                                    width: Get.width * 0.1,
                                    height: Get.width * 0.1,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(50),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Theme.of(context).cardColor,
                                          blurRadius: 1.0,
                                          spreadRadius: 0.0,
                                          offset: const Offset(0.5, 0.5),
                                        ),
                                      ],
                                      color: Theme.of(context)
                                          .dialogBackgroundColor,
                                    ),
                                    child: IconButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      icon: const Icon(
                                        Icons.arrow_back,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),

                          // SizedBox(height: Get.height * 0.01),
                          Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          width: Get.width * 0.7,
                                          child: Text(
                                            widget.product.name,
                                            style: Theme.of(context)
                                                .textTheme
                                                .headline1,
                                          ),
                                        ),
                                        if (widget.product.price == 0.0)
                                          Text(
                                            AppLocalizations.of(context)!
                                                .no_stock,
                                            style: Theme.of(context)
                                                .textTheme
                                                .headline6!
                                                .copyWith(
                                                  color: Colors.red,
                                                ),
                                          ),
                                        if (fullControllerController
                                                .initialMoney.value ==
                                            'EUR')
                                          Text(
                                            widget.product.price
                                                    .toStringAsFixed(2) +
                                                " €",
                                            style: Theme.of(context)
                                                .textTheme
                                                .headline5!
                                                .copyWith(
                                                  fontSize: Get.width * 0.04,
                                                ),
                                          ),
                                        if (fullControllerController
                                                .initialMoney.value ==
                                            'ECV')
                                          Text(
                                            widget.product.price
                                                    .toStringAsFixed(0) +
                                                " \$",
                                            style: Theme.of(context)
                                                .textTheme
                                                .headline5!
                                                .copyWith(
                                                  fontSize: Get.width * 0.04,
                                                ),
                                          ),
                                        if (fullControllerController
                                                .initialMoney.value ==
                                            'USD')
                                          Text(
                                            "\$ " +
                                                widget.product.price
                                                    .toStringAsFixed(2),
                                            style: Theme.of(context)
                                                .textTheme
                                                .headline5!
                                                .copyWith(
                                                  fontSize: Get.width * 0.04,
                                                ),
                                          ),
                                      ],
                                    ),
                                    const Spacer(),
                                    IconButton(
                                      padding: const EdgeInsets.all(0.0),
                                      onPressed: () async {
                                        if (!await authenticationController
                                            .checkLogin()) {
                                          showDialog(
                                              context: context,
                                              builder: (BuildContext context) {
                                                return DialogCustom(
                                                  textButton:
                                                      AppLocalizations.of(
                                                              context)!
                                                          .button_login,
                                                  action: () {
                                                    Navigator.pushNamed(
                                                        context, '/login');
                                                  },
                                                );
                                              });
                                        } else if (widget.product.price !=
                                            0.0) {
                                          if (widget.product.favorite ==
                                              false) {
                                            ServiceRequest.addFavrite(
                                                widget.product.id);
                                            setState(() {
                                              widget.product.favorite =
                                                  !widget.product.favorite;
                                            });
                                          } else {
                                            ServiceRequest.removeFavrite(
                                                widget.product.id);
                                            setState(() {
                                              widget.product.favorite =
                                                  !widget.product.favorite;
                                            });
                                          }
                                        }
                                      },
                                      icon: const Icon(Icons.favorite),
                                      iconSize: Get.width * 0.09,
                                      alignment: Alignment.centerRight,
                                      color: widget.product.favorite
                                          ? Colors.red
                                          : Theme.of(context).indicatorColor,
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Column(
                                  children: [
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        AppLocalizations.of(context)!
                                            .text_description,
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline2!
                                            .copyWith(
                                              fontSize: Get.width * 0.035,
                                            ),
                                      ),
                                    ),
                                    SizedBox(height: Get.height * 0.01),
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: Html(
                                        data: widget.product.description,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(
                        child: loading
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
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ButtonUI(
            label: AppLocalizations.of(context)!.button_add_cart,
            action: () async {
              if (!await authenticationController.checkLogin()) {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return DialogCustom(
                        textButton: AppLocalizations.of(context)!.button_login,
                        action: () {
                          Navigator.pushNamed(context, '/login');
                        },
                      );
                    });
              } else {
                if (widget.product.price != 0.0) {
                  openLoadingStateDialog(context);
                  var result = await cartPageController.addCart(
                      widget.product.id, quantidade);
                  Navigator.pop(context);
                  if (result.success) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text(
                        AppLocalizations.of(context)!.message_success_cart,
                        style: Theme.of(context).textTheme.labelSmall,
                      ),
                      backgroundColor: Theme.of(context).primaryColor,
                    ));
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text(
                        result.errorMessage!,
                        style: Theme.of(context).textTheme.labelSmall,
                      ),
                      backgroundColor: Theme.of(context).errorColor,
                    ));
                  }
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text(
                      AppLocalizations.of(context)!.no_stock_description,
                      style: Theme.of(context).textTheme.labelSmall,
                    ),
                    backgroundColor: Theme.of(context).errorColor,
                  ));
                }
              }
            },
          ),
        ),
      ),
    );
  }
}
