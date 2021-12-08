import 'dart:convert';
import 'package:flutter_session/flutter_session.dart';
import 'package:get/get.dart';
import 'package:manda_bai/Controller/static_config.dart';
import 'package:manda_bai/Model/cart_model.dart';
import 'package:http/http.dart' as http;
import 'package:manda_bai/Model/favorite.dart';
import 'package:manda_bai/Model/location.dart';
import 'package:manda_bai/Model/product.dart';
import 'package:manda_bai/Model/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MandaBaiController extends GetxController {
  var island = "".obs;
  var money = "".obs;
  var language = "".obs;

  var user = User().obs;
  late List<Location> list_location;
  //!Carregar sessão

  Future loadSessao() async {
    island.value = await FlutterSession().get('island');
    money.value = await FlutterSession().get('money');
    language.value = await FlutterSession().get('language');
    var session = FlutterSession();
    if (language.value == "null" || language.value == null) {
      await session.set('language', "pt");
    }
    if (money.value == "null" || money.value == null) {
      await session.set('money', "EUR");
    }
  }

  //! registar
  Future createAccount(User user) async {
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
  Future login(username, password) async {
    var response = await http.post(Uri.parse(request_login),
        body: {'username': username, 'password': password});

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      var session = FlutterSession();
      await session.set('id', jsonResponse["ID"]);
      await session.set('username', username);
      await session.set('password', password);

      //  print(jsonResponse["ID"]);
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

  validateDadosUser() async {
    var username = await FlutterSession().get('username');
    var password = await FlutterSession().get('password');

    if (password != null && username != null) {
      user.value.Username = username.toString();
      user.value.Senha = password.toString();
    }
  }

  //! Get User

  Future GetUser() async {
    var id = await FlutterSession().get('id');
    var response = await http.post(Uri.parse(
      getUser + id.toString() + "?" + key,
    ));

    // print(response.body);
    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      user.value.Name = jsonResponse["first_name"];
      user.value.Email = jsonResponse["email"];
      user.value.Nickname = jsonResponse["last_name"];
      user.value.Username = jsonResponse["username"];
      user.value.Avatar = jsonResponse["avatar_url"];
      user.value.Telefone = jsonResponse["billing"]["phone"];
      return true;
    } else if (response.statusCode == 503) {
      print("Erro de serviço");
      return false;
    } else {
      print("Erro de authentiction");
      return false;
    }
  }

  //!location delivery
  Future loadLocation() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    // await prefs.remove('itens_location');
    final String itemLocationString = prefs.getString('itens_location');
    if (itemLocationString != null) {
      //  print("nao vazio");
      // decode and store data in SharedPreferencesSS
      list_location = Location.decode(itemLocationString);
      return list_location;
    } else {
      print("vaziooo");
    }
    return null;
  }

  //?add location
  Future addLocation(Location location) async {
    Location new_location = location;
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String itemLocationString = prefs.getString('itens_location');

    if (itemLocationString != null) {
      // decode and store data in SharedPreferences
      list_location = Location.decode(itemLocationString);
      new_location.Id = list_location[list_location.length - 1].id! + 1;

      list_location.add(new_location);
      // Encode and store data in SharedPreferences
      final String encodedData = Location.encode(list_location);
      await prefs.setString('itens_location', encodedData);
    } else {
      list_location = [];
      list_location.add(new_location);
      // Encode and store data in SharedPreferences
      final String encodedData = Location.encode(list_location);

      await prefs.setString('itens_location', encodedData);
    }

    itemLocationString = prefs.getString('itens_location');
    if (itemLocationString != null) {
      list_location = Location.decode(itemLocationString);
      for (int i = 0; i < list_location.length; i++) {
        print("-" + list_location[i].name!);
        if (list_location[i].id == new_location.id) {
          return true;
        }
      }
    } else {
      return false;
    }
    return false;
  }

  //?remove location
  Future removeLocation(int id) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String itemLocationString = prefs.getString('itens_location');

    List<Location> list_new = [];
    if (list_location.length < 2) {
      prefs.remove('itens_location');
    } else {
      for (int i = 0; i < list_location.length; i++) {
        if (list_location[i].id != id) {
          list_new.add(list_location[i]);
        }
      }
      // Encode and store data in SharedPreferences
      prefs.remove('itens_location');
      final String encodedData = Location.encode(list_new);

      await prefs.setString('itens_location', encodedData);
    }
  }
}
