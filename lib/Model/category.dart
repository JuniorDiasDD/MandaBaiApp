class Category {
  int id, count;
  String name,image;

  Category({required this.id, required this.count, required this.name,required this.image});
  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      name: json['name'],
      id: json['id'],
      count: json['count'],
      image: json['image']!=null ? json['image']['src']: json['image'].toString(),
    );
  }
}
