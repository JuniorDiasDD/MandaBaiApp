import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:manda_bai/Controller/request.dart';
import 'package:manda_bai/Model/order.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:manda_bai/Model/product.dart';
import 'package:manda_bai/helpers/result.dart';

class OrderController extends GetxController {
  static OrderController instance = Get.find();

  final _island = ''.obs;
  final dataOrder = ''.obs;
  final horaOrder = ''.obs;

  final statusOrder = 1.obs;

  set island(String island) {
    _island.value = island;
  }

  String get island {
    return _island.value;
  }

  var listOrder = <Order>[].obs;
  Future carregar() async {
    listOrder.value = await ServiceRequest.loadOrder();
    if (listOrder.isEmpty) {
      return null;
    }

    return listOrder;
  }

  data(String date) {
    var data = DateTime.parse(date);
    horaOrder.value = data.hour.toString() + ":" + data.minute.toString();
    dataOrder.value = data.day.toString() +
        "/" +
        data.month.toString() +
        "/" +
        data.year.toString();
  }

  getData(String date) {
    var data = DateTime.parse(date);

    return data.day.toString() +
        "/" +
        data.month.toString() +
        "/" +
        data.year.toString();
  }

  getStatusOrder(Order order) {
    switch (order.status) {
      case 'pending':
        {
          statusOrder.value = 1;
          break;
        }
      case 'cancelled':
        {
          statusOrder.value = 0;
          break;
        }
      case 'processing':
        {
          statusOrder.value = 2;
          break;
        }
      case 'completed':
        {
          statusOrder.value = 5;
          break;
        }
      case 'failed':
        {
          statusOrder.value = 0;
          break;
        }
    }
  }

  getStringStatusOrder(String status, BuildContext context) {
    switch (status) {
      case 'pending':
        {
          return AppLocalizations.of(context)!.text_in_pendent_order;
        }
      case 'cancelled':
        {
          return AppLocalizations.of(context)!.text_canceled_order;
        }
      case 'processing':
        {
          return AppLocalizations.of(context)!.text_in_process_order;
        }
      case 'completed':
        {
          return AppLocalizations.of(context)!.text_delivery_order;
        }
      case 'failed':
        {
          return AppLocalizations.of(context)!.text_in_faild_order;
        }
    }
  }

  late Product product;
  Future carregarProduct(idProduct) async {
    product = await ServiceRequest.loadProductbyId(idProduct);
    if (product.id == null) {
      return null;
    }
    return product;
  }

  Future<SetResult> addCart(id, int quant) async {
    bool check = await ServiceRequest.addCart(id, quant);

    if (check) {
      return SetResult(true);
    }
    return SetResult(false, errorMessage: 'Error...');
  }
}
