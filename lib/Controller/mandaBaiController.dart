import 'dart:convert';
import 'package:get/get.dart';
import 'package:manda_bai/Controller/static_config.dart';
import 'package:http/http.dart' as http;
import 'package:manda_bai/Model/location.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MandaBaiController extends GetxController {
  static MandaBaiController instance = Get.find();
  var island = "".obs;
  var money = "".obs;
  var language = "".obs;

  //var user = User().obs;
  late List<Location> list_location;
  //!Carregar sessão

  Future loadSessao() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    island.value = prefs.getString('island')!;
    money.value = prefs.getString('money')!;
    language.value =  prefs.getString('language')!;

    if (language.value == "null" || language.value == null) {
      await prefs.setString('language', "pt");
    }
    if (money.value == "null" || money.value == null) {
      await prefs.setString('money', "EUR");
    }
  }



  validateDadosUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var username = prefs.get('username');
    var password = prefs.get('password');

    if (password != null && username != null) {
      user.username = username.toString();
      user.senha = password.toString();
    }
  }

  //! Get User

  Future GetUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var id = prefs.get('id');
    var response = await http.post(Uri.parse(
      getUser + id.toString() + "?" + key,
    ));

    // print(response.body);
    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
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

  //!location delivery
  Future loadLocation() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    // await prefs.remove('itens_location');
    final String? itemLocationString = prefs.getString('itens_location');
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
    String? itemLocationString = prefs.getString('itens_location');

    if (itemLocationString != null) {
      // decode and store data in SharedPreferences
      list_location = Location.decode(itemLocationString);
      new_location.idUpdate = list_location[list_location.length - 1].id !+ 1;

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
    final String? itemLocationString = prefs.getString('itens_location');

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
