
import 'package:get/get.dart';

class FullController extends GetxController {

  final _ilha = ''.obs;
  String get ilha {
    return _ilha.value;
  }

  set ilha(String ilha) {
    this._ilha.value = ilha;
  }


}
