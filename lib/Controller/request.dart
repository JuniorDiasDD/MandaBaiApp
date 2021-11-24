import 'dart:convert';
import 'package:manda_bai/Controller/static_config.dart';
import 'package:manda_bai/Model/category.dart';
import 'package:http/http.dart' as http;
import 'package:manda_bai/Model/product.dart';

class ServiceRequest {
  // ! Load Category
  static Future<List<Category>> loadCategory() async {
    List<Category> list = [];
    var response = await http.get(Uri.parse(categorias));
    final jsonResponse = json.decode(response.body);
    // print(response.body);
    if (response.statusCode == 200) {
      final _cats = jsonResponse.cast<Map<String, dynamic>>();
      list = _cats.map<Category>((cat) => Category.fromJson(cat)).toList();
    }else{
      print("Erro de autenticação");
    }
    return list;
  }

  //! Load Products
  static Future<List<Product>> loadProduct(id) async {
    print(id);
    List<Product> list = [];
    var response = await http.get(Uri.parse(productCategorias+id.toString()));
    final jsonResponse = json.decode(response.body);
     print(response.body);
    if (response.statusCode == 200) {
      final _cats = jsonResponse.cast<Map<String, dynamic>>();
      list = _cats.map<Product>((cat) => Product.fromJson(cat)).toList();
    }else{
      print("Erro de autenticação");
    }
    return list;
  }
}
