import 'dart:ffi';

class CartModel {
  final String name, image;
  double price;
  int amount;

  CartModel(
      {required this.name,
      required this.image,
      required this.amount,
      required this.price});
}
