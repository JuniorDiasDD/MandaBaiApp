import 'package:get/get.dart';

class CategoryController extends GetxController {
  final _loading = false.obs;
  set loading(bool loading) {
    this._loading.value = loading;
  }

  bool get loading {
    return _loading.value;
  }
}
