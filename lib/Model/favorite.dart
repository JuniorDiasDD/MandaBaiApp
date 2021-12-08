import 'dart:convert';

class Favorite {
  int? _id;
  String? _island;
  Favorite(
      {String? island,
        int? id,
      }) {
    _island = island;
    _id = id;
  }
  int? get id => _id;
  String? get island => _island;
  set Id(int val) => _id = val;
  set Island(String val) => _island = val;

  Favorite.fromJson( dynamic jsonData) {

      id: jsonData['id'];
      island: jsonData['island'];

  }
  static Map<String, dynamic> toMap(Favorite item) => {
        'id': item.id,
        'island':item.island,
      };

  static String encode(List<Favorite> items) => json.encode(
        items
            .map<Map<String, dynamic>>((item) => Favorite.toMap(item))
            .toList(),
      );

  static List<Favorite> decode(String favorite) =>
      (json.decode(favorite) as List<dynamic>)
          .map<Favorite>((item) => Favorite.fromJson(item))
          .toList();
}
