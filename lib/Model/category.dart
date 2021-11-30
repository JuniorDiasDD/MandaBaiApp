class Category {
  int id, count;
  String name;

  Category({required this.id, required this.count, required this.name});
  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      name: json['name'],
      id: json['id'],
      count: json['count'],
    );
  }
}
