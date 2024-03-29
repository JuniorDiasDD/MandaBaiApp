import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:manda_bai/Controller/request.dart';
import 'package:manda_bai/Core/app_images.dart';
import 'package:manda_bai/Model/order.dart';
import 'package:manda_bai/UI/Pedido/Componentes/item_pedido.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:manda_bai/UI/Pedido/controller/pedidoController.dart';
import 'package:manda_bai/UI/home/pop_up/popup_message_internet.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PedidoPage extends StatefulWidget {
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
    controller.island = dropdownValue;
  }

  @override
  void dispose() {
    _connectivitySubscription.cancel();
    super.dispose();
  }

  final PedidoController controller = Get.put(PedidoController());
  List<Order> list_order = [];
  Future _carregar() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var island = prefs.getString('island');
    if (dropdownValue == island.toString()) {
      if (list_order.isEmpty) {
        list_order = await ServiceRequest.loadOrder(island.toString());
        if (list_order.isEmpty) {
          return null;
        }
      }
    }
    return list_order;
  }

  Future _atualizar() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var island = prefs.getString('island');
    if (dropdownValue == island.toString()) {
      setState(() {
        vazio = false;
        controller.loading = false;
      });
    } else {
      setState(() {
        vazio = false;
        controller.loading = true;
        controller.island = dropdownValue;
      });
    }
    list_order = await ServiceRequest.loadOrder(dropdownValue);
    if (list_order.isEmpty) {
      if (dropdownValue == island.toString()) {
        setState(() {
          vazio = false;
          controller.loading = false;
        });
      } else {
        setState(() {
          vazio = true;
          controller.loading = false;
        });
      }
      return null;
    }

    setState(() {
      controller.loading = false;
    });

    return list_order;
  }

  String dropdownValue = 'Santiago';
  List<String> list_island = [
    'Santo Antão',
    'São Vicente',
    'São Nicolau',
    'Sal',
    'Boa Vista',
    'Maio',
    'Santiago',
    'Fogo',
    'Brava',
  ];
  bool check = false, vazio = false;
  carregarIsland() async {
    if (!check) {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      var island = prefs.getString('island');
      dropdownValue = island.toString();
      controller.island = dropdownValue;
      check = true;
    }
    return dropdownValue;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Stack(
            children: [
              Column(
                children: [
                  Container(
                    color: Theme.of(context).primaryColor,
                    width: double.infinity,
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          AppLocalizations.of(context)!.text_my_orders,
                          style: Theme.of(context).textTheme.headline3!.copyWith(color:Colors.white,),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Row(
                      //mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        const Icon(
                          Icons.circle,
                          color: Colors.orange,
                          size: 10,
                        ),
                        Text(
                          AppLocalizations.of(context)!.text_in_process_order,
                          style: Theme.of(context)
                              .textTheme
                              .headline4!
                              .copyWith(fontSize: Get.width * 0.03),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(left: 8.0),
                          child: Icon(
                            Icons.circle,
                            color: Colors.green,
                            size: 10,
                          ),
                        ),
                        Text(
                          AppLocalizations.of(context)!.text_delivery_order,
                          style: Theme.of(context)
                              .textTheme
                              .headline4!
                              .copyWith(fontSize: Get.width * 0.03),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      FutureBuilder(
                        future: carregarIsland(),
                        builder: (BuildContext context, AsyncSnapshot snapshot) {
                          switch (snapshot.connectionState) {
                            case ConnectionState.waiting:
                              return Container();
                            default:
                              return Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Align(
                                  alignment: Alignment.topLeft,
                                  child: Container(
                                    padding: EdgeInsets.only(
                                      left: Get.width * 0.04,
                                      right: Get.width * 0.04,
                                    ),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15.0),
                                      border: Border.all(
                                          color: Theme.of(context).indicatorColor,
                                          style: BorderStyle.solid,
                                          width: 0.80),
                                    ),
                                    child: DropdownButton<String>(
                                      value: dropdownValue,
                                      icon: const Icon(
                                        Icons.arrow_drop_down,
                                      ),
                                      iconSize: Get.width * 0.05,
                                      elevation: 16,
                                      style:
                                          Theme.of(context).textTheme.headline4,
                                      borderRadius: BorderRadius.circular(15.0),
                                      underline: Container(
                                        height: 0,
                                        color: Colors.transparent,
                                      ),
                                      onChanged: (String? newValue) {
                                        setState(() {
                                          dropdownValue = newValue!;
                                          _atualizar();
                                        });
                                      },
                                      items: list_island
                                          .map<DropdownMenuItem<String>>(
                                              (String value) {
                                        return DropdownMenuItem<String>(
                                          value: value,
                                          child: Text(
                                            value,
                                            style: Theme.of(context)
                                                .textTheme
                                                .headline4,
                                          ),
                                        );
                                      }).toList(),
                                    ),
                                  ),
                                ),
                              );
                          }
                        },
                      ),
                      SizedBox(
                        child: vazio == true
                            ? Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  AppLocalizations.of(context)!.text_empty_order,
                                  style: Theme.of(context).textTheme.headline3,
                                ),
                              )
                            : null,
                      ),
                    ],
                  ),
                  FutureBuilder(
                    future: _carregar(),
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      switch (snapshot.connectionState) {
                        case ConnectionState.waiting:
                          return SizedBox(
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
                            return SizedBox(
                              height: Get.height * 0.5,
                              width: Get.width,
                              child: Center(
                                child: Text(
                                  AppLocalizations.of(context)!.text_empty_order,
                                  style: Theme.of(context).textTheme.headline3,
                                ),
                              ),
                            );
                          } else {
                            return SizedBox(
                              height: Get.height * 0.85,
                              child: ListView.builder(
                                padding: EdgeInsets.only(
                                  top: 0.0,
                                  bottom: Get.height * 0.03,
                                ),
                                scrollDirection: Axis.vertical,
                                itemCount: list_order.length,
                                itemBuilder: (BuildContext context, index) {
                                  var list = list_order[index];
                                  return Item_Pedido(order: list);
                                },
                              ),
                            );
                          }
                      }
                    },
                  ),
                ],
              ),
              Obx(
                () => SizedBox(
                  child: controller.loading
                      ? Container(
                          color: Colors.black54,
                          height: Get.height,
                          child: Center(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.network(
                                  AppImages.loading,
                                  width: Get.width * 0.2,
                                  height: Get.height * 0.2,
                                  alignment: Alignment.center,
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  AppLocalizations.of(context)!.loading_time,
                                  textAlign: TextAlign.center,
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline3!
                                      .copyWith(color: Colors.white),
                                ),
                              ],
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
