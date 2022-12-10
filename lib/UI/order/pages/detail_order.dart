import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:manda_bai/Core/app_colors.dart';
import 'package:manda_bai/Core/app_images.dart';
import 'package:manda_bai/Model/order.dart';
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
                          child: Icon(Icons.info_outline),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const Divider(),
              Container(
                width: Get.width,
                height: Get.height * 0.15,

                decoration: BoxDecoration(
                  color: AppColors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Theme.of(context).cardColor,
                      blurRadius: 2.0,
                      spreadRadius: 0.0,
                      offset: const Offset(2.0, 2.0), // changes position of shadow
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
                            ? AppImages.order_pendent
                            : AppImages.order_finish,
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
                            "Total Pago: " + widget.order.total,
                            style: Theme.of(context).textTheme.headline3,
                          ),
                          Text(
                            "Local de Entrega: " +
                                widget.order.shipping.city +
                                " " +
                                widget.order.shipping.address_1,
                            style: Theme.of(context).textTheme.labelSmall,
                          ),
                          Text(
                            widget.order.status != "complete"
                                ? widget.order.status == "cancelled"
                                    ? AppLocalizations.of(context)!
                                        .text_canceled_order
                                    : AppLocalizations.of(context)!
                                        .text_in_process_order
                                : AppLocalizations.of(context)!
                                    .text_delivery_order,
                            style: Theme.of(context)
                                .textTheme
                                .labelSmall!
                                .copyWith(
                                  color: widget.order.status != "complete"
                                      ? widget.order.status == "cancelled"
                                          ? Colors.black26
                                          : Colors.orange
                                      : AppColors.greenColor,
                                ),
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
                            onTap: () async {},
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: AppColors.greenColor.withOpacity(0.2),
                              ),
                              child: Padding(
                                padding: EdgeInsets.all(6.0),
                                child: Text(
                                  "ver produtos",
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
              const TrakingItem(title: 'Processando o Pedido',description:'O seu pedido poderá estar processado entre 15 a 30 minutos',image: AppImages.iconMenuCartOutline,),
              const TrakingItem(title: 'Encomenda efetuada',description:'Sua encomenda foi efetuado com sucesso será sempre notificado das atualização no estado do processo',image: AppImages.iconTrankingEcommerce,),
              const TrakingItem(title: 'Recolha dos Produtos',description:'Seus produtos encomendados estão a ser processados',image: AppImages.iconTrankingShop,),
              const TrakingItem(title: 'A caminho do destino',description:'Encomenda a caminho do endereço associado a encomenda',image: AppImages.iconTrankingCar,),
              const TrakingItem(title: 'Encomenda Entregue',description:'Encomenda já se encontra entregue com sucesso',lineFinal: true,image: AppImages.iconTrankingBox,),
            ],
          ),
        ),
        bottomNavigationBar: Container(
          color: AppColors.white,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [

                SizedBox(
                  width: Get.width*0.6,
                  child: Text(
                    "Qualquer encomenda derá ser entregue no maximo de 24 horas.",
                    style: Theme.of(context).textTheme.headline3!.copyWith(fontSize:Get.width * 0.025 ),
                  ),
                ),
                GestureDetector(
                  onTap: () async {},
                  child: Container(
                    width: Get.width*0.3,
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
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
