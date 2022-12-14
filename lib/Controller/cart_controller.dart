import 'package:get/get.dart';
import 'package:manda_bai/Model/cart_model.dart';

class CartPageController extends GetxController {
  final _name = ''.obs;
  final _image = ''.obs;
  final _price = 0.0.obs;
  final _amount = 0.obs;
  final _id = 0.obs;
  final _subTotal = 0.0.obs;
  final _total = 0.0.obs;
  final _taxa = 0.0.obs;
  final _note = ''.obs;
  final _route = ''.obs;
  final _order = ''.obs;
  final _loading = false.obs;
  final _checkMessage = false.obs;
  final _deleteFull = false.obs;
  final _list = <CartModel>[].obs;

  List<CartModel> get list {
    return _list.value;
  }

  set list(List<CartModel> list) {
    this._list.value = list;
  }

  set deleteFull(bool deleteFull) {
    this._deleteFull.value = deleteFull;
  }

  bool get deleteFull {
    return _deleteFull.value;
  }
  set checkMessage(bool checkMessage) {
    this._checkMessage.value = checkMessage;
  }

  bool get checkMessage {
    return _checkMessage.value;
  }

  set loading(bool loading) {
    this._loading.value = loading;
  }

  bool get loading {
    return _loading.value;
  }

  String get order {
    return _order.value;
  }

  set order(String order) {
    this._order.value = order;
  }

  String get route {
    return _route.value;
  }

  set route(String route) {
    this._route.value = route;
  }

  String get note {
    return _note.value;
  }

  set note(String note) {
    this._note.value = note;
  }

  String get name {
    return _name.value;
  }

  set name(String name) {
    this._name.value = name;
  }

  String get image {
    return _image.value;
  }

  set image(String image) {
    this._image.value = image;
  }

  double get price {
    return _price.value;
  }

  set price(double price) {
    this._price.value = price;
  }

  int get amount {
    return _amount.value;
  }

  set amount(int amount) {
    this._amount.value = amount;
  }

  int get id {
    return _id.value;
  }

  set id(int id) {
    this._id.value = id;
  }

  double get taxa {
    return _taxa.value;
  }

  set taxa(double taxa) {
    this._taxa.value = taxa;
  }

  double get total {
    return _total.value;
  }

  set total(double total) {
    this._total.value = total;
  }

  double get subTotal {
    return _subTotal.value;
  }

  set subTotal(double subTotal) {
    this._subTotal.value = subTotal;
  }

  decrementar(int id) {
    if (!_list.isEmpty) {
      for (int i = 0; i < _list.length; i++) {
        if (_list[i].id == id) {
          if (_list[i].amount != 1) {
            _list[i].amount = _list[i].amount - 1;
          }
        }
      }
    }
  }

  incrementar(int id) {
    if (!_list.isEmpty) {
      for (int i = 0; i < _list.length; i++) {
        if (_list[i].id == id) {
          _list[i].amount = _list[i].amount + 1;
        }
      }
    }
  }

  checkBox(int id, value) {
    if (!_list.isEmpty) {
      for (int i = 0; i < _list.length; i++) {
        if (_list[i].id == id) {
          _list[i].checkout = value;
        }
      }
    }
  }

  checkBoxFull(value) {
    if (!_list.isEmpty) {
      for (int i = 0; i < _list.length; i++) {
        _list[i].checkout = value;
      }
    }
  }

  calcule() {
    subTotal = 0;
    total = 0;
    // ignore: unused_local_variable
    if (!_list.isEmpty) {
      for (int i = 0; i < _list.length; i++) {
        subTotal += _list[i].price * _list[i].amount/100;
      }

      total = subTotal + taxa;
    }
  }

  @override
  void onInit() {
    taxa = 5;

    calcule();
    super.onInit();
  }
}
