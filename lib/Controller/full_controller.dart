import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class FullController extends GetxController {
  final _connection = false.obs;
  final Connectivity connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> connectivitySubscription;
  bool get connection {
    return _connection.value;
  }

  set connection(bool connection) {
    _connection.value = connection;
  }

  updateStatus(ConnectivityResult connectivityResult) async {
    if (connectivityResult == ConnectivityResult.mobile) {
      connection= true;
      // updateText("3G/4G");
    } else if (connectivityResult == ConnectivityResult.wifi) {
      connection= true;
      //  updateText("Wi-Fi\n$wifiName\n$wifiSsid\n$wifiIp");
    } else {
      // updateText("Não Conectado!");
      connection= false;
    }
  }
}
