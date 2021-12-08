class Product {
  String name, description, sale_price, stock_quantity;
  int rating_count;
  int id;
  String in_stock, on_sale;
  String image;
  bool favorite;
  double price;

  Product(
      {required this.name,
      required this.description,
      required this.sale_price,
      required this.stock_quantity,
      required this.id,
      required this.rating_count,
      required this.in_stock,
      required this.on_sale,
      required this.image,
      required this.favorite,
      required this.price});
  /* String? get name => _name;
  String? get description => _description;
  String? get sale_price => _sale_price;
  String? get stock_quantity => _stock_quantity;
  int? get rating_count => _rating_count;
  int? get id => _id;
  String? get in_stock => _in_stock;
  String? get on_sale => _on_sale;
  String? get image => _image;
  bool? get favorite => _favorite;
  double? get price => _price;

  set Name(String val) => _name = val;
  set Description(String val) => _description = val;
  set Sale_price(String val) => _sale_price = val;
  set Stock_quantity(String val) => _stock_quantity = val;
  set Rating_count(int val) => _rating_count = val;
  set Id(int val) => _id = val;
  set In_stock(String val) => _in_stock = val;
  set On_sale(String val) => _on_sale = val;
  set Imagem(String val) => _image = val;
  set Favorite(bool val) => _favorite = val;
  set Price(double val) => _price = val;*/

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      name: json['name'].toString(),
      description: json['description'].toString(),
      price: double.parse(json['price']),
      rating_count: json['rating_count'] ?? 0,
      sale_price: json['sale_price'].toString(),
      in_stock: json['in_stock'].toString(),
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
