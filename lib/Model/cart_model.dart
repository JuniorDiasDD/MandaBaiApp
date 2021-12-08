import 'dart:ffi';

class CartModel {
  String? _name, _image, _item_key;
  double? _price;
  int? _amount;
  int? _id;
  bool? _checkout;

  CartModel({
    String? name,
    String? image,
    String? item_key,
    double? price,
    int? id,
    int? amount,
    bool? checkout,
  }) {
    _name = name;
    _item_key = item_key;
    _price = price;
    _id = id;
    _amount = amount;
    _checkout = checkout;
  }
  String? get name => _name;
  String? get image => _image;
  String? get item_key => _item_key;
  double? get price => _price;
  int? get id => _id;
  int? get amount => _amount;
  bool? get checkout => _checkout;

  set Name(String val) => _name = val;
  set Image(String val) => _image = val;
  set Item_key(String val) => _item_key = val;
  set Price(double val) => _price = val;
  set Id(int val) => _id = val;
  set Amount(int val) => _amount = val;
  set Checkout(bool val) => _checkout = val;

  CartModel.fromJson(dynamic json) {
    item_key:
    json['item_key'];
    name:
    json['name'];
    id:
    json['id'];
    amount:
    json['quantity']['value'];
    price:
    double.parse(json['price']);
    image:
    json['featured_image'].toString();
    checkout:
    false;
  }
}
