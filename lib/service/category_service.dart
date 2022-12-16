import 'dart:convert';

import 'package:manda_bai/Controller/static_config.dart';
import 'package:manda_bai/Model/category.dart';
import 'package:manda_bai/constants/controllers.dart';
import 'package:http/http.dart' as http;

class CategoryService{

// ! Load Category
   Future<List<Category>> loadCategory() async {
    List<Category> list = [];

    var island = fullControllerController.island.value;

    var response;
    switch (island) {
      case "Santo Antão":
        response = await http.get(Uri.parse(categoriasSaoAntao));
        break;
      case "São Vicente":
        response = await http.get(Uri.parse(categoriasSaoVicente));
        break;
      case "São Nicolau":
        response = await http.get(Uri.parse(categoriasSaoNicolau));
        break;
      case "Boa Vista":
        response = await http.get(Uri.parse(categoriasBoaVista));
        break;
      case "Sal":
        response = await http.get(Uri.parse(categoriasSal));
        break;
      case "Maio":
        response = await http.get(Uri.parse(categoriasMaio));
        break;
      case "Santiago":
        response = await http.get(Uri.parse(categoriasSantiago));
        break;
      case "Fogo":
        response = await http.get(Uri.parse(categoriasFogo));
        break;
      case "Brava":
        response = await http.get(Uri.parse(categoriasBrava));
        break;
    }
    if (response.statusCode == 200) {
      var page = response.headers['x-wp-totalpages'];
      int pages = int.parse(page);
      if (pages > 1) {
        var quantidade = response.headers['x-wp-total'];
        switch (island) {
          case "Santo Antão":
            response = await http.get(Uri.parse(
                categoriasSaoAntao + "&per_page=" + quantidade.toString()));
            break;
          case "São Vicente":
            response = await http.get(Uri.parse(
                categoriasSaoVicente + "&per_page=" + quantidade.toString()));
            break;
          case "São Nicolau":
            response = await http.get(Uri.parse(
                categoriasSaoNicolau + "&per_page=" + quantidade.toString()));
            break;
          case "Boa Vista":
            response = await http.get(Uri.parse(
                categoriasBoaVista + "&per_page=" + quantidade.toString()));
            break;
          case "Sal":
            response = await http.get(Uri.parse(
                categoriasSal + "&per_page=" + quantidade.toString()));
            break;
          case "Maio":
            response = await http.get(Uri.parse(
                categoriasMaio + "&per_page=" + quantidade.toString()));
            break;
          case "Santiago":
            response = await http.get(Uri.parse(
                categoriasSantiago + "&per_page=" + quantidade.toString()));
            break;
          case "Fogo":
            response = await http.get(Uri.parse(
                categoriasFogo + "&per_page=" + quantidade.toString()));
            break;
          case "Brava":
            response = await http.get(Uri.parse(
                categoriasBrava + "&per_page=" + quantidade.toString()));
            break;
        }
      }
      var jsonResponse = json.decode(response.body);
      final _cats = jsonResponse.cast<Map<String, dynamic>>();
      list = _cats.map<Category>((cat) => Category.fromJson(cat)).toList();
      list.sort((a, b) => a.name.toString().compareTo(b.name.toString()));
    } else if (response.statusCode == 503) {
      print("Erro de serviço");
    } else {
      print("Erro de authentiction");
    }

    return list;
  }
}