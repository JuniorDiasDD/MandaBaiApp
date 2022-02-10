import 'package:get/get.dart';

class PedidoController extends GetxController {
  final _loading = false.obs;
  final _island = ''.obs;

  set island(String island) {
    this._island.value = island;
  }

  String get island {
    return _island.value;
  }
  set loading(bool loading) {
    this._loading.value = loading;
  }

  bool get loading {
    return _loading.value;
  }
}
