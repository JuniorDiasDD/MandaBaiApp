class Product {
  final String name, description, sale_price, stock_quantity;
  int id;
  String in_stock, on_sale;
  String image;
  bool favorite;
  double price;
  Product(
      {required this.id,
        required this.name,
        required this.image,
        required this.in_stock,
        required this.stock_quantity,
        required this.on_sale,
        required this.price,
        required this.description,
        required this.sale_price,
        required this.favorite});
  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      name: json['name'].toString(),
      description: json['description'].toString(),
      price: json['price'] == "" ? 0.0 : double.parse(json['price']),
      sale_price: json['sale_price'].toString(),
      in_stock: json['stock_status'].toString(),
      on_sale: json['on_sale'].toString(),
      stock_quantity: json['stock_quantity'].toString(),
      image: json['images'][0]["src"],
      favorite: false,
    );
  }
}

//<Product>((cat) => Product.fromJson(cat))
class Imagem {
  String image;
  Imagem({required this.image});
  factory Imagem.fromJson(Map<String, dynamic> json) => Imagem(
        image: json["src"],
      );
}
