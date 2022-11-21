class CategoryRequestResponse {
  CategoryRequestResponse({
    List<Category>? result,
  }) {
    _result = result;
  }

  CategoryRequestResponse.fromJson(dynamic json) {
    if (json != null) {
      _result = [];
      json.forEach((v) {
        _result?.add(Category.fromJson(v));
      });
    }
  }
  List<Category>? _result;

  List<Category>? get result => _result;

  /* Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_result != null) {
      map = _result?.map((v) => v.toJson()).toList();
    }
    return map;
  }*/
}

class Category {
  int? id, count;
  String? name, image;

  Category({ this.id,  this.count,  this.name,  this.image});



  /* int? get id => _id;
  int? get count => _count;
  String? get name => _name;
  String? get image => _image;
  set Name(String val) => _name = val;
  set Imagem(String val) => _image = val;
  set Id(int val) => _id = val;
  set Count(int val) => _count = val;

  Category.fromJson(dynamic json) {
    _name:
    json['name'];
    _id:
    json['id'];
    _count:
    json['count'];
    _image:
    json['image'] != null ? json['image']['src'] : json['image'].toString();
  }*/
 factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      name: json['name'],
      id: json['id'],
      count: json['count'],
      image:  json['image'] != null ? json['image']['src'] : json['image'].toString(),
    );
  }
}
