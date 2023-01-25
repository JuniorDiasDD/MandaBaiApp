import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:manda_bai/Core/app_colors.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:manda_bai/Core/app_images.dart';
import 'package:manda_bai/UI/home/pop_up/popup_message_internet.dart';
import 'package:manda_bai/UI/order/Componentes/item_order.dart';
import 'package:manda_bai/constants/controllers.dart';
import 'package:websafe_svg/websafe_svg.dart';

class PedidoPage extends StatefulWidget {
  const PedidoPage({Key? key}) : super(key: key);

  @override
  _PedidoPageState createState() => _PedidoPageState();
}

class _PedidoPageState extends State<PedidoPage> {
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

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        return Future(() => false);
      },
      child: SafeArea(
        child: Scaffold(
          body: SingleChildScrollView(
            child: Stack(
              children: [
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            AppLocalizations.of(context)!.label_order,
                            style: Theme.of(context).textTheme.headline3,
                          ),
                          GestureDetector(
                            onTap: () async {},
                            child: Container(
                              width: Get.width * 0.1,
                              height: Get.width * 0.1,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                color: AppColors.grey50.withOpacity(0.8),
                              ),
                              child: const Padding(
                                padding: EdgeInsets.all(6.0),
                                child: Icon(Icons.info_outline,color: Colors.black,),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    FutureBuilder(
                      future: orderController.carregar(),
                      builder: (BuildContext context, AsyncSnapshot snapshot) {
                        switch (snapshot.connectionState) {
                          case ConnectionState.waiting:
                            return SizedBox(
                              height: Get.height * 0.2,
                              width: Get.width,
                              child: Center(
                                child: SizedBox(
                                    width: 32,
                                    height: 32,
                                    child: CircularProgressIndicator(
                                      color: Theme.of(context).primaryColor,
                                      strokeWidth: 2,
                                    )),
                              ),
                            );
                          default:
                            if (snapshot.data == null) {
                              return   SizedBox(
                                width: Get.width,
                                height: Get.height * 0.7,
                                child: Column(
                                  children: [
                                    SizedBox(height: Get.height * 0.2),
                                    WebsafeSvg.asset(AppImages.cartEmpyt),
                                    SizedBox(height: Get.height * 0.08),
                                    Text(
                                      AppLocalizations.of(context)!.text_empty_cart,
                                      style: Theme.of(context).textTheme.headline4,
                                    ),
                                  ],
                                ),
                              );
                            } else {
                              return SizedBox(
                                height: Get.height * 0.85,
                                child: Obx(
                                  () => ListView.builder(
                                    padding: EdgeInsets.only(
                                      top: 0.0,
                                      bottom: Get.height * 0.03,
                                    ),
                                    scrollDirection: Axis.vertical,
                                    itemCount: orderController.listOrder.length,
                                    itemBuilder: (BuildContext context, index) {
                                      var list =
                                          orderController.listOrder[index];
                                      return ItemOrder(order: list);
                                    },
                                  ),
                                ),
                              );
                            }
                        }
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
