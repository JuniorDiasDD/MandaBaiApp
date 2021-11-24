class Category {
  int id, count;
  String name;

  Category({required this.id, required this.count, required this.name});
  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'],
      name: json['name'],
      count: json['count'],
    );
  }
}
