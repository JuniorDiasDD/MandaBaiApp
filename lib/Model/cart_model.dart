import 'dart:convert';
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
  static Map<String, dynamic> toMap(CartModel item) => {
        'product_id': item.id,
        'quantity': item.amount,
      };

  static String encode(List<CartModel> items) => json.encode(
        items
            .map<Map<String, dynamic>>((item) => CartModel.toMap(item))
            .toList(),
      );
}
