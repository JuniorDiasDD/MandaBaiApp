import 'dart:convert';
import 'package:flutter_session/flutter_session.dart';
import 'package:get/get.dart';
import 'package:manda_bai/Controller/static_config.dart';
import 'package:manda_bai/Model/category.dart';
import 'package:http/http.dart' as http;

class MandaBaiCategoryController extends GetxController {
  late List<Category> ListCategoria;
  // ! Load Category
  Future loadCategory() async {
    print("aqui");
    List<Category> list = [];
    ListCategoria = [];
    var response = await http.get(Uri.parse(categorias));
    if (response.statusCode == 200) {
      var jsonResponse = json.decode(response.body);
      var quantidade = response.headers['x-wp-total'];
      response = await http
          .get(Uri.parse(categorias + "&per_page=" + quantidade.toString()));
      print(response.body);
      if (response.statusCode == 200) {
        /* list=(json.decode(response.body) as List).map((i) =>
              Category.fromJson(i)).toList();
        jsonResponse = json.decode(response.body);
         jsonResponse.forEach((v) {
          list.add(Category.fromJson(v));
        });*/
        // list =
        // CategoryRequestResponse.fromJson(json.decode(response.body)).result!;
         final _cats = jsonResponse.cast<Map<String, dynamic>>();
        list = _cats.map<Category>((cat) => Category.fromJson(cat)).toList();
       
        for (int i = 0; i < list.length; i++) {
          print(list[i].name);
        }
        var island = await FlutterSession().get('island');
        print(island);
        for (var i = 0; i < list.length; i++) {
          if (list[i].name.contains(island) == true) {
            var name = list[i].name.split(" / ");
            list[i].name = name[0];
            ListCategoria.add(list[i]);
          }
        }
      } else if (response.statusCode == 503) {
        print("Erro de serviço");
      } else {
        print("Erro de authentiction");
      }
    } else if (response.statusCode == 503) {
      print("Erro de serviço");
    } else {
      print("Erro de authentiction");
    }

    return ListCategoria;
  }
}
