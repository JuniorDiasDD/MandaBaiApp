import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:manda_bai/Controller/request.dart';
import 'package:manda_bai/Core/app_images.dart';
import 'package:manda_bai/UI/home/pop_up/popup_message_internet.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class PedidoDescriptionProduct extends StatefulWidget {
  int idProduct;
  PedidoDescriptionProduct({Key? key, required this.idProduct})
      : super(key: key);

  @override
  _PedidoDescriptionProductState createState() =>
      _PedidoDescriptionProductState();
}

class _PedidoDescriptionProductState extends State<PedidoDescriptionProduct> {
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
  var product;
  Future carregar() async {
    product = await ServiceRequest.loadProductbyId(widget.idProduct);
    if (product == false) {
      return null;
    }
    return product;
  }
  var money_txt;
  Future _carregarMoney() async {
     final SharedPreferences prefs = await SharedPreferences.getInstance();
    money_txt = prefs.getString('money');

    return money_txt;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SizedBox(
          height: Get.height,
          child: SingleChildScrollView(
            child: Column(
              children: [
                FutureBuilder(
                    future: carregar(),
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
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
                            return const Text(" ");
                          } else {
                            return Column(
                              children: [
                                Stack(
                                  children: [
                                    Container(
                                      height: Get.height * 0.5,
                                      child: Image.network(
                                        product.image,
                                        width: Get.width,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    Padding(
                                padding: const EdgeInsets.only(left: 10.0, top: 10.0),
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
                                      offset: Offset(0.5, 0.5),
                                    ),
                                  ],
                                  color: Theme.of(context).dialogBackgroundColor,
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
                                SizedBox(height: Get.height * 0.01),
                                Align(
                                  alignment: Alignment.topLeft,
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                      left: Get.width * 0.04,
                                      right: Get.width * 0.04,
                                    ),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          width: Get.width * 0.7,
                                          child: Text(
                                            product.name,
                                            style:
                                                Theme.of(context).textTheme.headline1,
                                          ),
                                        ),
                                        FutureBuilder(
                                            future: _carregarMoney(),
                                            builder: (BuildContext context,
                                                AsyncSnapshot snapshot) {
                                              if (snapshot.data == null) {
                                                return const Text(" ");
                                              } else {
                                                switch (money_txt) {
                                                  case 'EUR':
                                                    {
                                                      return Text(
                                                        product.price
                                                                .toStringAsFixed(2) +
                                                            " €",
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .headline5!
                                                            .copyWith(
                                                              fontSize:
                                                                  Get.width * 0.04,
                                                            ),
                                                      );
                                                    }
                                                  case 'ECV':
                                                    {
                                                      return Text(
                                                        product.price
                                                                .toStringAsFixed(0) +
                                                            " \$",
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .headline5!
                                                            .copyWith(
                                                              fontSize:
                                                                  Get.width * 0.04,
                                                            ),
                                                      );
                                                    }
                                                  case 'USD':
                                                    {
                                                      return Text(
                                                        "\$ " +
                                                            product.price
                                                                .toStringAsFixed(2),
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .headline5!
                                                            .copyWith(
                                                              fontSize:
                                                                  Get.width * 0.04,
                                                            ),
                                                      );
                                                    }
                                                }
                                                return Container();
                                              }
                                            }),
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
                                          child: Text(
                                            product.description,
                                            style:
                                            Theme.of(context).textTheme.headline4,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),


                              ],
                            );
                          }
                      }
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
