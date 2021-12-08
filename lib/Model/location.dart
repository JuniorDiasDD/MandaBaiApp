import 'dart:convert';

class Location{
  String? _name,_island,_city,_endereco,_phone;
    int? _id;

  Product(
      {String? name,
        String? island,
        String? city,
        String? endereco,
        String? phone,
        int? id,
        }) {
    _name = name;
    _island = island;
    _city = city;
    _endereco = endereco;
    _phone = phone;
    _id = id;

  }
  String? get name => _name;
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


  Location.fromJson( dynamic jsonData) {

      id: jsonData['id'];
      name: jsonData['name'];
      island: jsonData['island'];
      city: jsonData['city'];
      endereco: jsonData['endereco'];
       phone: jsonData['phone'];

  }
  static Map<String, dynamic> toMap(Location item) => {
        'id': item.id,
        'name':item.name,
        'island':item.island,
        'city':item.city,
        'endereco':item.endereco,
        'phone':item.phone,

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