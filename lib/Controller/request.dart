import 'dart:convert';
import 'package:flutter_session/flutter_session.dart';
import 'package:manda_bai/Controller/static_config.dart';
import 'package:manda_bai/Model/category.dart';
import 'package:http/http.dart' as http;
import 'package:manda_bai/Model/product.dart';
import 'package:manda_bai/Model/user.dart';

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
    } else {
      print("Erro de autenticação");
    }
    return list;
  }

  //! Load Products
  static Future<List<Product>> loadProduct(id) async {
    print(id);
    List<Product> list = [];
    var response = await http.get(Uri.parse(productCategorias + id.toString()));
    final jsonResponse = json.decode(response.body);
    print(response.body);
    if (response.statusCode == 200) {
      final _cats = jsonResponse.cast<Map<String, dynamic>>();
      list = _cats.map<Product>((cat) => Product.fromJson(cat)).toList();
    } else {
      print("Erro de autenticação");
    }
    return list;
  }

  //! registar
  static Future createAccount(User user) async {
    var headers = {
      'Content-Type': 'application/json',
    };

    var data = json.encode({
      "email": user.email,
      "first_name": user.name,
      "last_name": user.nickname,
      "username": user.username,
      "password": user.senha,
      "billing": {
        "first_name": user.name,
        "last_name": user.nickname,
        "company": "",
        "address_1": "",
        "address_2": "",
        "city": "",
        "state": "",
        "postcode": "",
        "country": "",
        "email": user.email,
        "phone": ""
      },
      "shipping": {
        "first_name": "",
        "last_name": "",
        "company": "",
        "address_1": "",
        "address_2": "",
        "city": "",
        "state": "",
        "postcode": "",
        "country": ""
      }
    });
    var response = await http.post(Uri.parse(register_client),
        headers: headers, body: data);

    print(response.body);
    //  print(response.statusCode);
    if (response.statusCode == 201) {
      final jsonResponse = json.decode(response.body);
      var session = FlutterSession();
      await session.set('id', jsonResponse["id"]);
      return true;
    } else {
      return false;
    }
  }

  //! Login
  static Future login(username, password) async {
    var response = await http.post(Uri.parse(request_login),
        body: {'username': username, 'password': password});
    final jsonResponse = json.decode(response.body);
    print(response.body);
    if (response.statusCode == 200) {
      var session = FlutterSession();
      await session.set('id', jsonResponse["user_id"]);
      GetUser();
      return true;
    }
    return false;
  }

  //! Get User

  static Future GetUser() async {
    var id = await FlutterSession().get('id');
    var response = await http.post(Uri.parse(
      getUser + id.toString() + "?" + key,
    ));
    print(getUser + id.toString() + "?" + key);
    final jsonResponse = json.decode(response.body);
    print(response.body);
    if (response.statusCode == 200) {
      user.name = jsonResponse["first_name"];
      user.email = jsonResponse["email"];
      user.nickname = jsonResponse["last_name"];
      user.username = jsonResponse["username"];
      user.avatar = jsonResponse["avatar_url"];
      user.telefone = jsonResponse["billing"]["phone"];
      return true;
    }else{
      return false;
    }
  }
}
