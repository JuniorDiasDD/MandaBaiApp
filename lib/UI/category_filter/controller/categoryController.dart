import 'package:get/get.dart';

class CategoryController extends GetxController {
  final _loading = false.obs;
  final _loadingMais = false.obs;
  set loadingMais(bool loadingMais) {
    this._loadingMais.value = loadingMais;
  }

  bool get loadingMais {
    return _loadingMais.value;
  }
  set loading(bool loading) {
    this._loading.value = loading;
  }

  bool get loading {
    return _loading.value;
  }
}
