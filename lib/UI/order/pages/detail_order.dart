import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:manda_bai/Core/app_colors.dart';
import 'package:manda_bai/Core/app_images.dart';
import 'package:manda_bai/Model/order.dart';
import 'package:manda_bai/UI/order/Componentes/produtc.dart';
import 'package:manda_bai/UI/order/Componentes/trakingItem.dart';
import 'package:manda_bai/constants/controllers.dart';
import '../../home/pop_up/popup_message_internet.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class DetailOrder extends StatefulWidget {
  final Order order;
  const DetailOrder({Key? key, required this.order}) : super(key: key);

  @override
  State<DetailOrder> createState() => _DetailOrderState();
}

class _DetailOrderState extends State<DetailOrder> {
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
      //  print(_connectionStatus.toString());
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
    super.initState();
  }

  @override
  void dispose() {
    _connectivitySubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    orderController.getStatusOrder(widget.order);

    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding:
                    const EdgeInsets.only(left: 16.0, right: 16.0, top: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      child: Text(
                        '< #' + widget.order.id.toString(),
                        style: Theme.of(context).textTheme.headline3,
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ],
                ),
              ),
              const Divider(),
              Container(
                width: Get.width,
                height: Get.height * 0.15,
                decoration: BoxDecoration(
                  color: Theme.of(context).dialogBackgroundColor,
                  boxShadow: [
                    BoxShadow(
                      color: Theme.of(context).cardColor,
                      blurRadius: 2.0,
                      spreadRadius: 0.0,
                      offset:
                          const Offset(2.0, 2.0), // changes position of shadow
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    const SizedBox(
                      width: 16,
                    ),
                    Image.network(
                        widget.order.status != 'processing'
                            ? AppImages.orderPendent
                            : AppImages.orderFinish,
                        width: Get.width * 0.15,
                        height: Get.width * 0.15,
                        alignment: Alignment.center),
                    const SizedBox(
                      width: 8,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            AppLocalizations.of(context)!.text_total+": " + widget.order.total,
                            style: Theme.of(context).textTheme.headline3,
                          ),
                          SizedBox(
                            width: Get.width*0.4,
                            child: Text(
                              AppLocalizations.of(context)!.text_delivery_location+" " +
                                  widget.order.shipping.city +
                                  " " +
                                  widget.order.shipping.address_1,
                              style: Theme.of(context).textTheme.labelSmall,
                            ),
                          ),
                          Text(
                            orderController.getStringStatusOrder(
                                widget.order.status, context),
                            style: Theme.of(context)
                                .textTheme
                                .labelSmall!
                                .copyWith(
                                    color: widget.order.status == "completed"
                                        ? AppColors.greenColor
                                        : widget.order.status == "processing"
                                            ? Colors.orange
                                            : widget.order.status == "failed"
                                                ? Colors.red
                                                : Theme.of(context)
                                                    .dividerColor),
                          ),
                        ],
                      ),
                    ),
                    const Spacer(),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Text(
                            orderController.getData(widget.order.date_created),
                            style: Theme.of(context)
                                .textTheme
                                .labelSmall!
                                .copyWith(fontSize: 8),
                          ),
                          const Spacer(),
                          GestureDetector(
                            onTap: () async {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return ProductList(
                                    items: widget.order.items,
                                  );
                                },
                              );
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: AppColors.greenColor.withOpacity(0.2),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(6.0),
                                child: Text(
                                  AppLocalizations.of(context)!.look_products,
                                  style: Theme.of(context).textTheme.labelSmall,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              SizedBox(
                child: orderController.statusOrder.value == 0
                    ? Container(
                        padding: EdgeInsets.all(Get.width * 0.2),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              AppImages.orderCancelled,
                              width: Get.width * 0.4,
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            Text(
                              AppLocalizations.of(context)!.order_failed,
                              style: Theme.of(context)
                                  .textTheme
                                  .headline3!
                                  .copyWith(fontSize: Get.width * 0.025),
                            ),
                          ],
                        ),
                      )
                    : Column(
                        children: [
                          TrakingItem(
                            title: AppLocalizations.of(context)!.traking_step_1_title,
                            description:
                            AppLocalizations.of(context)!.traking_step_1_info,
                            image: AppImages.iconMenuCartOutline,
                            colorStatus: orderController.statusOrder.value > 0
                                ? true
                                : false,
                          ),
                          TrakingItem(
                            title: AppLocalizations.of(context)!.traking_step_2_title,
                            description:
                            AppLocalizations.of(context)!.traking_step_2_info,
                            image: AppImages.iconTrankingEcommerce,
                            colorStatus: orderController.statusOrder.value > 1
                                ? true
                                : false,
                          ),
                          TrakingItem(
                            title: AppLocalizations.of(context)!.traking_step_3_title,
                            description:
                            AppLocalizations.of(context)!.traking_step_3_info,
                            image: AppImages.iconTrankingShop,
                            colorStatus: orderController.statusOrder.value > 4
                                ? true
                                : false,
                          ),
                          TrakingItem(
                            title: AppLocalizations.of(context)!.traking_step_4_title,
                            description:
                            AppLocalizations.of(context)!.traking_step_4_info,
                            image: AppImages.iconTrankingCar,
                            colorStatus: orderController.statusOrder.value > 4
                                ? true
                                : false,
                          ),
                          TrakingItem(
                            title: AppLocalizations.of(context)!.traking_step_5_title,
                            description:
                            AppLocalizations.of(context)!.traking_step_5_info,
                            lineFinal: true,
                            image: AppImages.iconTrankingBox,
                            colorStatus: orderController.statusOrder.value > 4
                                ? true
                                : false,
                          ),
                        ],
                      ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: Container(
          color: Theme.of(context).dialogBackgroundColor,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(

              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    AppLocalizations.of(context)!.delivery_info,
                    style: Theme.of(context)
                        .textTheme
                        .headline3!
                        .copyWith(fontSize: Get.width * 0.025),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
/* GestureDetector(
                  onTap: () async {
                    openLoadingLongStateDialog(context);
                    var result;
                    for (var element in widget.order.items) {
                      result = await orderController.addCart(
                          element.id, element.quantity);
                      if (!result.success) {
                        Navigator.pop(context);
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text(
                            result.errorMessage!,
                            style: Theme.of(context).textTheme.labelSmall,
                          ),
                          backgroundColor: Theme.of(context).errorColor,
                        ));
                        break;
                      }
                    }

                    if (result.success) {
                      Navigator.pop(context);

                      Navigator.pushNamed(context, '/cart');
                    }
                  },
                  child: Container(
                    width: Get.width * 0.3,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: AppColors.greenColor,
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(6.0),
                      child: Text(
                        "Encomendar Novamente",
                        style: Theme.of(context).textTheme.labelSmall,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),*/