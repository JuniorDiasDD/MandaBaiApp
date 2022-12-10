import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:manda_bai/Controller/request.dart';
import 'package:manda_bai/Model/cart_model.dart';
import 'package:manda_bai/constants/controllers.dart';
import 'package:manda_bai/helpers/result.dart';

class CartPageController extends GetxController {
  static CartPageController instance = Get.find();
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
    _list.value = list;
  }

  set deleteFull(bool deleteFull) {
    _deleteFull.value = deleteFull;
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
        subTotal += _list[i].price * _list[i].amount / 100;
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

  //cart
  TextEditingController pesquisa= TextEditingController();
  var isChecked = false.obs;
  final listCart = <CartModel>[].obs;
  Future carregarCart() async {
    if (listCart.isEmpty) {
      listCart.value = await ServiceRequest.loadCart();
      if (listCart.isEmpty) {
        return null;
      } else {
        String money = fullControllerController.initialMoney.value;
        cartPageController.taxa = 5;
        var value;
        if (money == "USD") {
          value = await ServiceRequest.loadDolar();
        }
        for (int m = 0; m < listCart.length; m++) {
          switch (money) {
            case 'USD':
              {
                if (value != false) {
                  double dolar = double.parse(value);
                  listCart[m].price = listCart[m].price / dolar;
                  cartPageController.taxa = 5 / dolar;
                }
                break;
              }
            case 'ECV':
              {
                listCart[m].price = listCart[m].price * 110.87;
                cartPageController.taxa = 5 * 110.87;
                break;
              }
          }
        }
        //
        list = listCart;
        calcule();
      }
    }

    return listCart;
  }

  Future remover() async {
    List<String> list_item = [];
    if (isChecked.value) {
      if (list.isNotEmpty) {
        for (int i = 0; i < list.length; i++) {
          list_item.add(list[i].item_key);
        }
        listCart.value = await ServiceRequest.removeCart(list_item);
        list = listCart;
        calcule();
      }
    } else {
      bool check = false;
      for (int i = 0; i < list.length; i++) {
        if (list[i].checkout == true) {
          list_item.add(list[i].item_key);
          check = true;
        }
      }
      if (check) {
        listCart.value = await ServiceRequest.removeCart(list_item);
          list = listCart;
          calcule();
      }
    }
  }
  Future<SetResult> addCart(id,int quant) async {
    bool check = await ServiceRequest.addCart(id, quant);

    if(check){
      cartPageController.list=cartPageController.listCart;
      return SetResult(true);
    }
    return SetResult(false,errorMessage: 'Error...');
  }

//checkout 2
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final input_info = TextEditingController();
  bool isCheckedPromocao = false;
  final input_codigo = TextEditingController();

  Future<SetResult> validateAndSave() async {
    final FormState? form = formKey.currentState;

    if (locationController.location.value.id != null) {
      cartPageController.note = input_info.text;
      cartPageController.loading = true;

      var check = await ServiceRequest.createOrder(
          "",
          locationController.location.value,
          cartPageController.list,
          cartPageController.total,
          cartPageController.note,
          isCheckedPromocao,
          input_codigo.text);

      if (check == "Erro de serviço") {
        return SetResult(false, errorMessage: "Erro no servico");
      } else if (check == "Erro de cupom") {
        return SetResult(false, errorMessage: "Erro no cupon");
      } else if (check == "false") {
        return SetResult(false, errorMessage: "Erro");
      } else {
        return SetResult(true);
      }
    } else {
      return SetResult(false, errorMessage: "Not Location, Select one");
    }
  }

  Future<void> canceledOrder() async {
    var check = await ServiceRequest.createOrder(
        "cancelled",
        locationController.location.value,
        cartPageController.list,
        cartPageController.total,
        cartPageController.note,
        false,
        "");
  }
}
