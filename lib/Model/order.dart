class Order {
  final String status, date_created, total, order_key;

  int id;
  Shipping shipping;
  List<Items> items;
  Order(
      {required this.id,
      required this.date_created,
      required this.status,
      required this.shipping,
      required this.total,
      required this.order_key,
      required this.items});

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      status: json['status'],
      date_created: json['date_created'],
      id: json['id'],
      shipping: Shipping(
        first_name: json['shipping']['first_name'],
        last_name: json['shipping']['last_name'],
        address_1: json['shipping']['address_1'],
        address_2: json['shipping']['address_2'],
        city: json['shipping']['city'],
        state: json['shipping']['state'],
        postcode: json['shipping']['postcode'],
        country: json['shipping']['country'],
        phone: json['shipping']['phone'],
      ),
      total: json['total'].toString(),
      order_key: json['order_key'],
      items: json['line_items']
          .cast<Map<String, dynamic>>()
          .map<Items>((item) => Items.fromJson(item))
          .toList(),
    );
  }
}

class Shipping {
  String first_name,
      last_name,
      address_1,
      address_2,
      city,
      state,
      postcode,
      country,
      phone;

  Shipping(
      {required this.first_name,
      required this.last_name,
      required this.address_1,
      required this.address_2,
      required this.city,
      required this.state,
      required this.country,
      required this.phone,
      required this.postcode});

  factory Shipping.fromJson(Map<String, dynamic> json) {
    return Shipping(
      first_name: json['first_name'],
      last_name: json['last_name'],
      address_1: json['address_1'],
      address_2: json['address_2'],
      city: json['city'],
      state: json['state'],
      postcode: json['postcode'],
      country: json['country'],
      phone: json['phone'],
    );
  }
}

class Items {
  int id, product_id, quantity;
  String total, name;
  Items(
      {required this.id,
      required this.product_id,
      required this.quantity,
      required this.total,
      required this.name});
  factory Items.fromJson(Map<String, dynamic> json) {
    return Items(
      id: json['id'],
      product_id: json['product_id'],
      quantity: json['quantity'],
      total: json['total'],
      name: json['name'],
    );
  }
}
