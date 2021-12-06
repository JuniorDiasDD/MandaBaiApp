import 'dart:convert';
import 'package:flutter_session/flutter_session.dart';
import 'package:manda_bai/Controller/static_config.dart';
import 'package:manda_bai/Model/cart_model.dart';
import 'package:manda_bai/Model/category.dart';
import 'package:http/http.dart' as http;
import 'package:manda_bai/Model/favorite.dart';
import 'package:manda_bai/Model/location.dart';
import 'package:manda_bai/Model/product.dart';
import 'package:manda_bai/Model/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ServiceRequest {
  // ! Load Category
  static Future<List<Category>> loadCategory() async {
    List<Category> list = [];
    List<Category> list_final = [];
    var response = await http.get(Uri.parse(categorias));

    if (response.statusCode == 200) {
      var jsonResponse = json.decode(response.body);
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
    List<Product> list = [];
    List<Product> list_page = [];
    var response = await http.get(Uri.parse(productCategorias + id.toString()));
    //  print(response.body);
    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      var quantidade = response.headers['x-wp-total'];
      int total_wp = int.parse(quantidade!);
      if (total_wp < 100 || total_wp == 100) {
        final _cats = jsonResponse.cast<Map<String, dynamic>>();
        list = _cats.map<Product>((cat) => Product.fromJson(cat)).toList();
      } else {
        int cont = 2;
        if (total_wp > 200 && total_wp < 300 || total_wp == 300) {
          cont = 3;
        }
        for (int i = 1; i < cont; i++) {
          response = await http.get(Uri.parse(productCategorias +
              id.toString() +
              "&per_page=100&page=" +
              i.toString()));
          if (response.statusCode == 200) {
            final jsonResponse = json.decode(response.body);
            final _cats = jsonResponse.cast<Map<String, dynamic>>();
            list_page =
                _cats.map<Product>((cat) => Product.fromJson(cat)).toList();
            for (int d = 0; d < list_page.length; d++) {
              list.add(list_page[d]);
            }
          } else {
            print("Erro em carregar products da page=" + i.toString());
          }
        }
      }
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

  //! Get User

  static Future GetUser() async {
    var id = await FlutterSession().get('id');
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

  //! Cart
  //? getCart
  static Future<List<CartModel>> loadCart() async {
    List<CartModel> list = [];

    String basicAuth =
        'Basic ' + base64Encode(utf8.encode(user.username + ':' + user.senha));
    var response = await http.get(Uri.parse(getCart),
        headers: <String, String>{'authorization': basicAuth});
    print(response.body);

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      final _cats = jsonResponse['items'].cast<Map<String, dynamic>>();
      list = _cats.map<CartModel>((cat) => CartModel.fromJson(cat)).toList();
    } else if (response.statusCode == 503) {
      print("Erro de serviço");
    } else {
      print("Erro de authentiction");
    }
    return list;
  }

  //! removeItemCart
  static Future<List<CartModel>> removeCart(List<String> list_item) async {
    List<CartModel> list = [];

    String basicAuth =
        'Basic ' + base64Encode(utf8.encode(user.username + ':' + user.senha));

    for (int i = 0; i < list_item.length; i++) {
      var response = await http.delete(Uri.parse(removeItemCart + list_item[i]),
          headers: <String, String>{'authorization': basicAuth});
      print(response.body);

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        final _cats = jsonResponse['items'].cast<Map<String, dynamic>>();
        list = _cats.map<CartModel>((cat) => CartModel.fromJson(cat)).toList();
      } else if (response.statusCode == 503) {
        print("Erro de serviço");
      } else {
        print("Erro em eliminar item " + list_item[i]);
      }
    }

    return list;
  }

  //! Cart
  //? addCart
  static Future addCart(item) async {
    String basicAuth =
        'Basic ' + base64Encode(utf8.encode(user.username + ':' + user.senha));
    var response = await http.post(Uri.parse(addItemCart),
        headers: <String, String>{'authorization': basicAuth},
        body: {'id': item.toString(), 'quantity': "1"});
    print(response.body);

    if (response.statusCode == 200) {
      //  final jsonResponse = json.decode(response.body);
      return true;
    } else if (response.statusCode == 503) {
      print("Erro de serviço");
    } else {
      print("Erro de authentiction");
    }
    return false;
  }

  //! Favorite
  //?add favorite
  static Future addFavrite(int id) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String itemFavortiesString = prefs.getString('itens_favorites');
    var island = await FlutterSession().get('island');
    if (itemFavortiesString != null) {
      // decode and store data in SharedPreferences
      List<Favorite> list = Favorite.decode(itemFavortiesString);
      list.add(new Favorite(id: id, island: island));

      // Encode and store data in SharedPreferences
      final String encodedData = Favorite.encode(list);

      await prefs.setString('itens_favorites', encodedData);
    } else {
      List<Favorite> list = [];
      list.add(new Favorite(id: id, island: island));
      // Encode and store data in SharedPreferences
      final String encodedData = Favorite.encode(list);

      await prefs.setString('itens_favorites', encodedData);
    }
  }

  //?remove favorite
  static Future removeFavrite(int id) async {
    print("id" + id.toString());
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String itemFavortiesString = prefs.getString('itens_favorites');

    if (itemFavortiesString != null) {
      // decode and store data in SharedPreferences
      List<Favorite> list = Favorite.decode(itemFavortiesString);
      List<Favorite> list_new = [];
      if (list.length < 2) {
        prefs.remove('itens_favorites');
      } else {
        for (int i = 0; i < list.length; i++) {
          if (list[i].id != id) {
            list_new.add(list[i]);
          }
        }
        // Encode and store data in SharedPreferences
        prefs.remove('itens_favorites');
        final String encodedData = Favorite.encode(list_new);

        await prefs.setString('itens_favorites', encodedData);
      }
    }
  }

  static Future<List<Product>> loadFavorite() async {
    List<Product> list = [];
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String itemFavortiesString = prefs.getString('itens_favorites');

    if (itemFavortiesString != null) {
      // decode and store data in SharedPreferences
      List<Favorite> listFavorites = Favorite.decode(itemFavortiesString);
      var island = await FlutterSession().get('island');
      for (int i = 0; i < listFavorites.length; i++) {
        if (listFavorites[i].island == island) {
          var response = await http.get(Uri.parse(
              get_Produto + listFavorites[i].id.toString() + "?" + key));
          final jsonResponse = json.decode(response.body);
          //  print(response.body);
          if (response.statusCode == 200) {
            list.add(Product(
                id: jsonResponse['id'],
                name: jsonResponse['name'].toString(),
                description: jsonResponse['description'].toString(),
                price: double.parse(jsonResponse['price']),
                rating_count: jsonResponse['rating_count'] ?? 0,
                sale_price: jsonResponse['sale_price'].toString(),
                in_stock: jsonResponse['manage_stock'].toString(),
                on_sale: jsonResponse['on_sale'].toString(),
                stock_quantity: jsonResponse['stock_quantity'].toString(),
                image: jsonResponse['images'][0]["src"],
                favorite: true));
          } else {
            print("Erro em carregar o produto");
          }
        }
      }
    } else {
      return list;
    }
    return list;
  }

  //!location delivery
  static Future<List<Location>> loadLocation() async {
    List<Location> list = [];

    final SharedPreferences prefs = await SharedPreferences.getInstance();

    // await prefs.remove('itens_location');
    final String itemLocationString = prefs.getString('itens_location');
    if (itemLocationString != null) {
      //  print("nao vazio");
      // decode and store data in SharedPreferencesSS
      List<Location> list = Location.decode(itemLocationString);
      return list;
    } else {
      print("vaziooo");
    }
    return list;
  }

  //?add location
  static Future addLocation(Location location) async {
    Location new_location = location;
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String itemLocationString = prefs.getString('itens_location');

    if (itemLocationString != null) {
      // decode and store data in SharedPreferences
      List<Location> list = Location.decode(itemLocationString);
      new_location.id = list[list.length - 1].id + 1;

      list.add(new_location);
      // Encode and store data in SharedPreferences
      final String encodedData = Location.encode(list);
      await prefs.setString('itens_location', encodedData);
    } else {
      List<Location> list = [];
      list.add(new_location);
      // Encode and store data in SharedPreferences
      final String encodedData = Location.encode(list);

      await prefs.setString('itens_location', encodedData);
    }

    itemLocationString = prefs.getString('itens_location');
    if (itemLocationString != null) {
      List<Location> list = Location.decode(itemLocationString);
      for (int i = 0; i < list.length; i++) {
        print("-" + list[i].name);
        if (list[i].id == new_location.id) {
          return true;
        }
      }
    } else {
      return false;
    }
    return false;
  }

  //?remove location
  static Future removeLocation(int id) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String itemLocationString = prefs.getString('itens_location');

    if (itemLocationString != null) {
      // decode and store data in SharedPreferences
      List<Location> list = Location.decode(itemLocationString);
      List<Location> list_new = [];
      if (list.length < 2) {
        prefs.remove('itens_location');
      } else {
        for (int i = 0; i < list.length; i++) {
          if (list[i].id != id) {
            list_new.add(list[i]);
          }
        }
        // Encode and store data in SharedPreferences
        prefs.remove('itens_location');
        final String encodedData = Location.encode(list_new);

        await prefs.setString('itens_location', encodedData);
      }
    }
  }
}
