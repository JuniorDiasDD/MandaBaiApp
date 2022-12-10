import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:manda_bai/Controller/request.dart';
import 'package:manda_bai/Model/product.dart';
import 'package:manda_bai/constants/controllers.dart';
import 'package:manda_bai/helpers/result.dart';

class FavoriteController extends GetxController {
  static FavoriteController instance = Get.find();
  final _loading = false.obs;
final _vazio=false.obs;
  final _list_product = <Product>[].obs;
  final _list_product_full = <Product>[].obs;
  List<Product> get list_product {
    return _list_product.value;
  }

  set list_product(List<Product> list) {
    this._list_product.value = list;
  }

  List<Product> get list_product_full {
    return _list_product_full.value;
  }

  set list_product_full(List<Product> list) {
    this._list_product_full.value = list;
  }

  set loading(bool loading) {
    this._loading.value = loading;
  }

  bool get vazio {
    return _vazio.value;
  }
  set vazio(bool loading) {
    this._vazio.value = loading;
  }

  bool get loading {
    return _loading.value;
  }
  remover(int id) {
    if (_list_product_full.isNotEmpty) {
      for (int i = 0; i < _list_product_full.length; i++) {
        if (_list_product_full[i].id == id) {
          _list_product_full.removeAt(i);
        }
      }
      list_product=_list_product_full;
      if(list_product.isEmpty){
        return true;
      }
    }
    return false;
  }


  var isChecked = false.obs;
  TextEditingController pesquisa = TextEditingController();
  Future carregar() async {
    if (list_product.isEmpty && pesquisa.text == "") {
      list_product = await ServiceRequest.loadFavorite();
      if (list_product.isEmpty) {
        vazio = true;
        return null;
      } else {
        var value;
        String money = fullControllerController.initialMoney.value;
        if (money == "USD") {
          value = await ServiceRequest.loadDolar();
        }
        for (int m = 0; m < list_product.length; m++) {
          switch (money) {
            case 'USD':
              {
                if (value != false) {
                  double dolar = double.parse(value);
                  list_product[m].price =
                     list_product[m].price / dolar;
                }
                break;
              }
            case 'ECV':
              {
               list_product[m].price =
               list_product[m].price * 110.87;

                break;
              }
          }
        }
        list_product_full = list_product;
      }
    }

    return list_product;
  }

  search() {
    list_product = [];
      for (int i = 0; i < list_product_full.length; i++) {
        if (list_product_full[i].name
            .toLowerCase()
            .contains(pesquisa.text.toLowerCase())) {
         list_product.add(list_product_full[i]);
        }
      }
  }

  Future<SetResult> addCart(id) async {
    bool check = await ServiceRequest.addCart(id, 1);

    if(!check){
      return SetResult(false,errorMessage: 'Error in add to Cart');
    }

    return SetResult(true);
  }
}
