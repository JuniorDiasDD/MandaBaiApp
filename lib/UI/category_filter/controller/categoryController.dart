import 'package:get/get.dart';

class CategoryController extends GetxController {
  final _loading = false.obs;
  final _loadingMais = false.obs;
  final _focus=false.obs;
  final _size_list = 0.obs;
  final _size_load = 0.obs;
  final _statusLoadProdutoPage="".obs;
  set loadingMais(bool loadingMais) {
    this._loadingMais.value = loadingMais;
  }

  bool get loadingMais {
    return _loadingMais.value;
  }
  set focus(bool focus) {
    this._focus.value = focus;
  }

  bool get focus {
    return _focus.value;
  }
  set loading(bool loading) {
    this._loading.value = loading;
  }

  bool get loading {
    return _loading.value;
  }
  set size_list(int value) {
    this._size_list.value = value;
  }

  int get size_list {
    return _size_list.value;
  }
  set size_load(int value) {
    this._size_load.value = value;
  }

  int get size_load {
    return _size_load.value;
  }
  set statusLoadProdutoPage(String value) {

    this._statusLoadProdutoPage.value = value;
  }

  String get statusLoadProdutoPage {
    return _statusLoadProdutoPage.value;
  }
}
