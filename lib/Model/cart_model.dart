import 'dart:ffi';

class CartModel {
  String name, image, item_key;
  double price;
  int amount;
  int id;
  bool checkout;

  CartModel({
    required this.name,
    required this.image,
    required this.item_key,
    required this.price,
    required this.id,
    required this.amount,
    required this.checkout,
  });
  factory CartModel.fromJson(Map<String, dynamic> json) {
    return CartModel(
      name: json['name'],
      id: json['id'],
      item_key: json['item_key'],
      amount: json['quantity']['value'],
      price: double.parse(json['price']),
      image: json['featured_image'].toString(),
      checkout: false,
    );
  }
  /* String? get name => _name;
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
  }*/

}
