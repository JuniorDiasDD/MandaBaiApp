import 'dart:convert';

class Favorite {
  int id;
  String island;
  Favorite({required this.id,required this.island});

  factory Favorite.fromJson(Map<String, dynamic> jsonData) {
    return Favorite(
      id: jsonData['id'],
      island: jsonData['island'],
    );
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
