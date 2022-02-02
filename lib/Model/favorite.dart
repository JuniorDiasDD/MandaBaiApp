import 'dart:convert';

class Favorite {
  int id;
  String island;
  String username;
  Favorite({required this.id, required this.island, required this.username});

  factory Favorite.fromJson(Map<String, dynamic> jsonData) {
    return Favorite(
        id: jsonData['id'],
        island: jsonData['island'],
        username: jsonData['username']);
  }
  static Map<String, dynamic> toMap(Favorite item) => {
        'id': item.id,
        'island': item.island,
        'username': item.username,
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
