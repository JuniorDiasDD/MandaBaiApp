import 'dart:convert';

class Location {
  String? _name;
  String? _island, _city, _endereco, _phone, _email, _username;
  int? _id;


  Location({String? name,String? island, String? city, String? endereco,String? phone, String? email,String? username,
  int? id}){
    _id=id;
    _name=name;
    _island=island;
    _city=city;
    _endereco=endereco;
    _phone=phone;
    _email=email;
    _username=username;
  }


  String? get name => _name;
  String? get island => _island;
  String? get city => _city;
  String? get endereco => _endereco;
  String? get phone => _phone;
  String? get email => _email;
  String? get username => _username;
  int? get id => _id;


  set idUpdate(int value) {
    _id = value;
  }

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
