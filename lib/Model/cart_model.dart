import 'dart:ffi';

class CartModel {
  final String name, image;
  double price;
  int amount;
  int id;

  CartModel(
      {required this.id,
      required this.name,
      required this.image,
      required this.amount,
      required this.price});
}
