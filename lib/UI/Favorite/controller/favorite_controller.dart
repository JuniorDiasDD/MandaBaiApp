import 'package:get/get.dart';
import 'package:manda_bai/Model/product.dart';

class FavoriteController extends GetxController {
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
    if (!_list_product_full.isEmpty) {
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
}
