import 'dart:convert';

class Location {
  String name, island, city, endereco, phone, email, username;
  int id;
  Location(
      {required this.username,
      required this.email,
      required this.id,
      required this.name,
      required this.island,
      required this.city,
      required this.endereco,
      required this.phone});
  factory Location.fromJson(Map<String, dynamic> jsonData) {
    return Location(
      id: jsonData['id'],
      name: jsonData['name'],
      island: jsonData['island'],
      city: jsonData['city'],
      endereco: jsonData['endereco'],
      phone: jsonData['phone'],
      email: jsonData['email'],
      username: jsonData['username'],
    );
  }
  static Map<String, dynamic> toMap(Location item) => {
        'id': item.id,
        'name': item.name,
        'island': item.island,
        'city': item.city,
        'endereco': item.endereco,
        'phone': item.phone,
        'email': item.email,
        'username': item.username,
      };

  static String encode(List<Location> items) => json.encode(
        items
            .map<Map<String, dynamic>>((item) => Location.toMap(item))
            .toList(),
      );

  static List<Location> decode(String location) =>
      (json.decode(location) as List<dynamic>)
          .map<Location>((item) => Location.fromJson(item))
          .toList();
}
