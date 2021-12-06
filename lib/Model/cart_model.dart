import 'dart:ffi';

class CartModel {
  final String name, image, item_key;
  double  price;
  int amount;
  int id;
  bool checkout;

  CartModel(
      {required this.id,
      required this.name,
      required this.image,
      required this.amount,
      required this.item_key,
       required this.checkout,
      required this.price});

  factory CartModel.fromJson(Map<String, dynamic> json) {
    return CartModel(
      item_key: json['item_key'],
      name: json['name'],
      id: json['id'],
      amount: json['quantity']['value'],
      price: double.parse(json['price']),
      image: json['featured_image'].toString(),
      checkout:false,
    );
  }
}
