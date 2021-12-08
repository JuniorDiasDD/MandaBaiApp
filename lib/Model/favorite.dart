import 'dart:convert';

class Favorite {
  int id;
  String island;
  Favorite({
    required this.island,
    required this.id,
  });
  /* int? get id => _id;
  String? get island => _island;
  set Id(int val) => _id = val;
  set Island(String val) => _island = val;*/

  factory Favorite.fromJson(Map<String, dynamic> json) {
    return Favorite(
      id: json['id'],
      island: json['island'],
    );
  }
  static Map<String, dynamic> toMap(Favorite item) => {
        'id': item.id,
        'island': item.island,
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
