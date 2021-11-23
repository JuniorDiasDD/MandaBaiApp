class Product{
  final String name, image;
  double price;
  int amount;
  int id;

  Product(
      {required this.id,
      required this.name,
      required this.image,
      required this.amount,
      required this.price});
}