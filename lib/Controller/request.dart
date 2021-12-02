import 'dart:convert';
import 'package:flutter_session/flutter_session.dart';
import 'package:manda_bai/Controller/static_config.dart';
import 'package:manda_bai/Model/cart_model.dart';
import 'package:manda_bai/Model/category.dart';
import 'package:http/http.dart' as http;
import 'package:manda_bai/Model/product.dart';
import 'package:manda_bai/Model/user.dart';

class ServiceRequest {
  // ! Load Category
  static Future<List<Category>> loadCategory() async {
    List<Category> list = [];
    List<Category> list_final = [];
    var response = await http.get(Uri.parse(categorias));
    var jsonResponse = json.decode(response.body);
    if (response.statusCode == 200) {
      var quantidade = response.headers['x-wp-total'];
      response = await http
          .get(Uri.parse(categorias + "&per_page=" + quantidade.toString()));
      jsonResponse = json.decode(response.body);
      if (response.statusCode == 200) {
        final _cats = jsonResponse.cast<Map<String, dynamic>>();
        list = _cats.map<Category>((cat) => Category.fromJson(cat)).toList();
        var island = await FlutterSession().get('island');
        for (var i = 0; i < list.length; i++) {
          if (list[i].name.contains(island) == true) {
            var name = list[i].name.split(" / ");
            list[i].name = name[0];
            list_final.add(list[i]);
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
    return list_final;
  }

  //! Load Products
  static Future<List<Product>> loadProduct(id) async {
    print(id);
    List<Product> list = [];
    var response = await http.get(Uri.parse(productCategorias + id.toString()));
    final jsonResponse = json.decode(response.body);
    //  print(response.body);
    if (response.statusCode == 200) {
      final _cats = jsonResponse.cast<Map<String, dynamic>>();
      list = _cats.map<Product>((cat) => Product.fromJson(cat)).toList();
    } else if (response.statusCode == 503) {
      print("Erro de serviço");
    } else {
      print("Erro de authentiction");
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

    //  print(response.body);
    if (response.statusCode == 201) {
      final jsonResponse = json.decode(response.body);
      var session = FlutterSession();
      await session.set('id', jsonResponse["id"]);
      return true;
    } else if (response.statusCode == 503) {
      print("Erro de serviço");
      return false;
    } else {
      print("Erro de authentiction");
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
    } else if (response.statusCode == 503) {
      print("Erro de serviço");
      return false;
    } else {
      print("Erro de authentiction");
      return false;
    }
  }

  //! Get User

  static Future GetUser() async {
    var id = await FlutterSession().get('id');
    var response = await http.post(Uri.parse(
      getUser + id.toString() + "?" + key,
    ));
    final jsonResponse = json.decode(response.body);
    // print(response.body);
    if (response.statusCode == 200) {
      user.name = jsonResponse["first_name"];
      user.email = jsonResponse["email"];
      user.nickname = jsonResponse["last_name"];
      user.username = jsonResponse["username"];
      user.avatar = jsonResponse["avatar_url"];
      user.telefone = jsonResponse["billing"]["phone"];
      return true;
    } else if (response.statusCode == 503) {
      print("Erro de serviço");
      return false;
    } else {
      print("Erro de authentiction");
      return false;
    }
  }

  //! Cart
  //? getCart
  static Future<List<CartModel>> loadCart() async {
    List<CartModel> list = [];

    String basicAuth = 'Basic ' + base64Encode(utf8.encode('john.doe:123'));
    var response = await http.get(Uri.parse(getCart),
        headers: <String, String>{'authorization': basicAuth});

    final jsonResponse = json.decode(response.body);
    print(response.body);
    if (response.statusCode == 200) {
      final _cats = jsonResponse['items'].cast<Map<String, dynamic>>();
      list = _cats.map<CartModel>((cat) => CartModel.fromJson(cat)).toList();
    } else if (response.statusCode == 503) {
      print("Erro de serviço");
    } else {
      print("Erro de authentiction");
    }
    return list;
  }
}
