import 'dart:convert';

class Location {
  String name, island, city, endereco, phone;
  int id;

  Location(
      {required this.name,
      required this.island,
      required this.city,
      required this.endereco,
      required this.phone,
      required this.id});
  /* String? get name => _name;
  String? get island => _island;
  String? get city => _city;
  String? get endereco => _endereco;
  String? get phone => _phone;
  int? get id => _id;


  set Name(String val) => _name = val;
  set Island(String val) => _island = val;
  set City(String val) => _city = val;
  set Endereco(String val) => _endereco = val;
  set Phone(String val) => _phone = val;
  set Id(int val) => _id = val;
*/

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
      id: json['id'],
      name: json['name'],
      island: json['island'],
      city: json['city'],
      endereco: json['endereco'],
      phone: json['phone'],
    );
  }
  static Map<String, dynamic> toMap(Location item) => {
        'id': item.id,
        'name': item.name,
        'island': item.island,
        'city': item.city,
        'endereco': item.endereco,
        'phone': item.phone,
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
