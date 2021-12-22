import 'dart:convert';
import 'package:manda_bai/Controller/static_config.dart';
import 'package:manda_bai/Model/cart_model.dart';
import 'package:manda_bai/Model/category.dart';
import 'package:http/http.dart' as http;
import 'package:manda_bai/Model/favorite.dart';
import 'package:manda_bai/Model/location.dart';
import 'package:manda_bai/Model/order.dart';
import 'package:manda_bai/Model/product.dart';
import 'package:manda_bai/Model/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ServiceRequest {
  // ! Load Category
  static Future<List<Category>> loadCategory() async {
    List<Category> list = [];

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var island = prefs.getString('island');
    if (island == null) {
      island = "Santiago";
    }
    var response;
    switch (island) {
      case "São Antão":
        response = await http.get(Uri.parse(categoriasSaoAntao));
        break;
      case "São  Vicente":
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

    //  print(response.body);
    if (response.statusCode == 200) {
      var jsonResponse = json.decode(response.body);
      final _cats = jsonResponse.cast<Map<String, dynamic>>();
      list = _cats.map<Category>((cat) => Category.fromJson(cat)).toList();
    } else if (response.statusCode == 503) {
      print("Erro de serviço");
    } else {
      print("Erro de authentiction");
    }

    return list;
  }

  //! Load Products
  static Future<List<Product>> loadProduct(id) async {
    List<Product> list = [];
    List<Product> list_page = [];
//print(id.toString());
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var island = prefs.getString('island');

    var response;
    switch (island) {
      case "São Antão":
        response = await http
            .get(Uri.parse(productCategoriasSaoAntao + id.toString()));
        break;
      case "São  Vicente":
        response = await http
            .get(Uri.parse(productCategoriasSaoVicente + id.toString()));
        break;
      case "São Nicolau":
        response = await http
            .get(Uri.parse(productCategoriasSaoNicolau + id.toString()));
        break;
      case "Boa Vista":
        response = await http
            .get(Uri.parse(productCategoriasBoaVista + id.toString()));
        break;
      case "Sal":
        response =
            await http.get(Uri.parse(productCategoriasSal + id.toString()));
        break;
      case "Maio":
        response =
            await http.get(Uri.parse(productCategoriasMaio + id.toString()));
        break;
      case "Santiago":
        response = await http
            .get(Uri.parse(productCategoriasSantiago + id.toString()));
        break;
      case "Fogo":
        response =
            await http.get(Uri.parse(productCategoriasFogo + id.toString()));
        break;
      case "Brava":
        response =
            await http.get(Uri.parse(productCategoriasBrava + id.toString()));
        break;
    }

   // print(island.toString() + "-" + response.body);
    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      var quantidade = response.headers['x-wp-total'];
      int total_wp = int.parse(quantidade!);
      if (total_wp < 101) {
        final _cats = jsonResponse.cast<Map<String, dynamic>>();
        list = _cats.map<Product>((cat) => Product.fromJson(cat)).toList();
      } else {
        int cont = 1, falta = 0;
        if (total_wp < 200) {
          cont = 2;
          falta = total_wp - 100;
        } else {
          cont = 3;
          falta = total_wp - 200;
        }
        for (int i = 1; i <= cont; i++) {
          switch (island) {
            case "São Antão":
              response = await http.get(Uri.parse(productCategoriasSaoAntao +
                  id.toString() +
                  "&per_page=100&page=" +
                  i.toString()));
              break;
            case "São  Vicente":
              response = await http.get(Uri.parse(productCategoriasSaoVicente +
                  id.toString() +
                  "&per_page=100&page=" +
                  i.toString()));
              break;
            case "São Nicolau":
              response = await http.get(Uri.parse(productCategoriasSaoNicolau +
                  id.toString() +
                  "&per_page=100&page=" +
                  i.toString()));
              break;
            case "Boa Vista":
              response = await http.get(Uri.parse(productCategoriasBoaVista +
                  id.toString() +
                  "&per_page=100&page=" +
                  i.toString()));
              break;
            case "Sal":
              response = await http.get(Uri.parse(productCategoriasSal +
                  id.toString() +
                  "&per_page=100&page=" +
                  i.toString()));
              break;
            case "Maio":
              response = await http.get(Uri.parse(productCategoriasMaio +
                  id.toString() +
                  "&per_page=100&page=" +
                  i.toString()));
              break;
            case "Santiago":
              response = await http.get(Uri.parse(productCategoriasSantiago +
                  id.toString() +
                  "&per_page=100&page=" +
                  i.toString()));
              break;
            case "Fogo":
              response = await http.get(Uri.parse(productCategoriasFogo +
                  id.toString() +
                  "&per_page=100&page=" +
                  i.toString()));
              break;
            case "Brava":
              response = await http.get(Uri.parse(productCategoriasBrava +
                  id.toString() +
                  "&per_page=100&page=" +
                  i.toString()));
              break;
          }
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
  //  print(list.length.toString());
    return list;
  }

  //! registar
  static Future createAccount(User user) async {
    var headers = {
      'Content-Type': 'application/json',
    };

    var data = json.encode({
      "email": user.email,
      "first_name": user.name + " Tester",
      "last_name": user.nickname,
      "username": user.username,
      "password": user.senha,
      "billing": {
        "first_name": user.name + " Tester",
        "last_name": user.nickname,
        "company": "",
        "address_1": "",
        "address_2": "",
        "city": user.city,
        "state": "",
        "postcode": "",
        "country": user.country,
        "email": user.email,
        "phone": user.telefone
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
    if (response.statusCode == 201) {
      final jsonResponse = json.decode(response.body);

      return true;
    } else if (response.statusCode == 503) {
      print("Erro de serviço");
      return false;
    } else {
      print("Erro de authentiction");
      return false;
    }
  }

  //! registar
  static Future updateAccount() async {
    var headers = {
      'Content-Type': 'application/json',
    };

    var data = json.encode({
      "email": user.email,
      "first_name": user.name,
      "last_name": user.nickname,
      "password": user.senha,
      "billing": {
        "first_name": user.name,
        "last_name": user.nickname,
        "company": "",
        "address_1": "",
        "address_2": "",
        "city": user.city,
        "state": "",
        "postcode": "",
        "country": user.country,
        "email": user.email,
        "phone": user.telefone,
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
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var id = prefs.getString('id');
    var response = await http.put(
        Uri.parse(updateUser + id.toString() + "?" + key),
        headers: headers,
        body: data);

    if (response.statusCode == 200) {
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
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var island = prefs.getString('island');

    var response;
    switch (island) {
      case "São Antão":
        response = await http.post(Uri.parse(request_login_SantoAntao),
            body: {'username': username, 'password': password});
        break;
      case "São  Vicente":
        response = await http.post(Uri.parse(request_login_SaoVicente),
            body: {'username': username, 'password': password});
        break;
      case "São Nicolau":
        response = await http.post(Uri.parse(request_login_SaoNicolau),
            body: {'username': username, 'password': password});
        break;
      case "Boa Vista":
        response = await http.post(Uri.parse(request_login_BoaVista),
            body: {'username': username, 'password': password});
        break;
      case "Sal":
        response = await http.post(Uri.parse(request_login_Sal),
            body: {'username': username, 'password': password});
        break;
      case "Maio":
        response = await http.post(Uri.parse(request_login_Maio),
            body: {'username': username, 'password': password});
        break;
      case "Santiago":
        response = await http.post(Uri.parse(request_login_Santiago),
            body: {'username': username, 'password': password});
        break;
      case "Fogo":
        response = await http.post(Uri.parse(request_login_Fogo),
            body: {'username': username, 'password': password});
        break;
      case "Brava":
        response = await http.post(Uri.parse(request_login_Brava),
            body: {'username': password.username, 'password': password});
        break;
    }

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      final SharedPreferences prefs = await SharedPreferences.getInstance();

      await prefs.setString('id', jsonResponse["ID"].toString());
      await prefs.setString('username', username);
      await prefs.setString('password', password);
      user.senha = password;
      user.username = username;
      //  loginCoCart();
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

//! login cocart
  static Future loginCoCart() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var island = prefs.getString('island');

    var response, responseCocart;
    switch (island) {
      case "São Antão":
        {
          response = await http.post(Uri.parse(request_login_SantoAntao),
              body: {'username': user.username, 'password': user.senha});
          responseCocart = await http.post(
              Uri.parse(request_loginCocart_SantoAntao),
              body: {'username': user.username, 'password': user.senha});
          break;
        }

      case "São  Vicente":
        {
          response = await http.post(Uri.parse(request_login_SaoVicente),
              body: {'username': user.username, 'password': user.senha});
          responseCocart = await http.post(
              Uri.parse(request_loginCocart_SaoVicente),
              body: {'username': user.username, 'password': user.senha});
          break;
        }

      case "São Nicolau":
        {
          response = await http.post(Uri.parse(request_login_SaoNicolau),
              body: {'username': user.username, 'password': user.senha});
          responseCocart = await http.post(
              Uri.parse(request_loginCocart_SaoNicolau),
              body: {'username': user.username, 'password': user.senha});
          break;
        }

      case "Boa Vista":
        {
          response = await http.post(Uri.parse(request_login_BoaVista),
              body: {'username': user.username, 'password': user.senha});
          responseCocart = await http.post(
              Uri.parse(request_loginCocart_BoaVista),
              body: {'username': user.username, 'password': user.senha});
          break;
        }

      case "Sal":
        {
          response = await http.post(Uri.parse(request_login_Sal),
              body: {'username': user.username, 'password': user.senha});
          responseCocart = await http.post(Uri.parse(request_loginCocart_Sal),
              body: {'username': user.username, 'password': user.senha});
          break;
        }

      case "Maio":
        {
          response = await http.post(Uri.parse(request_login_Maio),
              body: {'username': user.username, 'password': user.senha});
          responseCocart = await http.post(Uri.parse(request_loginCocart_Maio),
              body: {'username': user.username, 'password': user.senha});
          break;
        }

      case "Santiago":
        {
          response = await http.post(Uri.parse(request_login_Santiago),
              body: {'username': user.username, 'password': user.senha});
          responseCocart = await http.post(
              Uri.parse(request_loginCocart_Santiago),
              body: {'username': user.username, 'password': user.senha});
          break;
        }

      case "Fogo":
        {
          response = await http.post(Uri.parse(request_login_Fogo),
              body: {'username': user.username, 'password': user.senha});
          responseCocart = await http.post(Uri.parse(request_loginCocart_Fogo),
              body: {'username': user.username, 'password': user.senha});
          break;
        }

      case "Brava":
        {
          response = await http.post(Uri.parse(request_login_Brava),
              body: {'username': user.username, 'password': user.senha});
        //  print(request_loginCocart_Brava);
          responseCocart = await http.post(Uri.parse(request_loginCocart_Brava),
              body: {'username': user.username, 'password': user.senha});
          break;
        }
    }
    //  print(response.body);
    print("Cocart:" + responseCocart.statusCode.toString());
  }
  //! Get User

  static Future GetUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var id = prefs.getString('id');

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
      user.city = jsonResponse["billing"]["city"];
      user.country = jsonResponse["billing"]["country"];
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final String encodedData = json.encode(User.toMap(user));
      await prefs.setString('user', encodedData);
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
    List<CartModel> listCart = [];
    var response;
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    do {
      await loginCoCart();
      String basicAuth = 'Basic ' +
          base64Encode(utf8.encode(user.username + ':' + user.senha));
      var island = prefs.getString('island');

      var response;
      switch (island) {
        case "São Antão":
          response = await http.get(Uri.parse(getCartSaoAntao),
              headers: <String, String>{'authorization': basicAuth});
          break;
        case "São  Vicente":
          response = await http.get(Uri.parse(getCartSaoVicente),
              headers: <String, String>{'authorization': basicAuth});
          break;
        case "São Nicolau":
          response = await http.get(Uri.parse(getCartSaoNicolau),
              headers: <String, String>{'authorization': basicAuth});
          break;
        case "Boa Vista":
          response = await http.get(Uri.parse(getCartBoaVista),
              headers: <String, String>{'authorization': basicAuth});
          break;
        case "Sal":
          response = await http.get(Uri.parse(getCartSal),
              headers: <String, String>{'authorization': basicAuth});
          break;
        case "Maio":
          response = await http.get(Uri.parse(getCartMaio),
              headers: <String, String>{'authorization': basicAuth});
          break;
        case "Santiago":

          response = await http.get(Uri.parse(getCartSantiago),
              headers: <String, String>{'authorization': basicAuth});
          break;
        case "Fogo":
          response = await http.get(Uri.parse(getCartFogo),
              headers: <String, String>{'authorization': basicAuth});
          break;
        case "Brava":
          response = await http.get(Uri.parse(getCartBrava),
              headers: <String, String>{'authorization': basicAuth});
          break;
      }

     // print(response.body);
     // print(response.statusCode);
      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        final _cats = jsonResponse['items'].cast<Map<String, dynamic>>();
        listCart =
            _cats.map<CartModel>((cat) => CartModel.fromJson(cat)).toList();

        return listCart;
      } else if (response.statusCode == 503) {
        print("Erro de serviço");
      } else {
        print("Erro de authentiction");
      }

    } while (response.statusCode == 503);

    return listCart;
  }

  //! removeItemCart
  static Future<List<CartModel>> removeCart(List<String> list_item) async {
    List<CartModel> list = [];
    List<CartModel> listCart = [];
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    // await loginCoCart();
    String basicAuth =
        'Basic ' + base64Encode(utf8.encode(user.username + ':' + user.senha));
    var island = prefs.getString('island');

    var response;
    switch (island) {
      case "São Antão":
        {
          for (int i = 0; i < list_item.length; i++) {
            var response = await http.delete(
                Uri.parse(removeItemCartSantoAntao + list_item[i]),
                headers: <String, String>{'authorization': basicAuth});
            // print(response.body);

            if (response.statusCode == 200) {
              final jsonResponse = json.decode(response.body);
              final _cats = jsonResponse['items'].cast<Map<String, dynamic>>();
              list = _cats
                  .map<CartModel>((cat) => CartModel.fromJson(cat))
                  .toList();
            } else if (response.statusCode == 503) {
              print("Erro de serviço");
            } else {
              print("Erro em eliminar item " + list_item[i]);
            }
          }
          break;
        }
      case "São  Vicente":
        {
          for (int i = 0; i < list_item.length; i++) {
            var response = await http.delete(
                Uri.parse(removeItemCartSaoVicente + list_item[i]),
                headers: <String, String>{'authorization': basicAuth});
            // print(response.body);

            if (response.statusCode == 200) {
              final jsonResponse = json.decode(response.body);
              final _cats = jsonResponse['items'].cast<Map<String, dynamic>>();
              list = _cats
                  .map<CartModel>((cat) => CartModel.fromJson(cat))
                  .toList();
            } else if (response.statusCode == 503) {
              print("Erro de serviço");
            } else {
              print("Erro em eliminar item " + list_item[i]);
            }
          }
          break;
        }
      case "São Nicolau":
        {
          for (int i = 0; i < list_item.length; i++) {
            var response = await http.delete(
                Uri.parse(removeItemCartSaoNicolau + list_item[i]),
                headers: <String, String>{'authorization': basicAuth});
            // print(response.body);

            if (response.statusCode == 200) {
              final jsonResponse = json.decode(response.body);
              final _cats = jsonResponse['items'].cast<Map<String, dynamic>>();
              list = _cats
                  .map<CartModel>((cat) => CartModel.fromJson(cat))
                  .toList();
            } else if (response.statusCode == 503) {
              print("Erro de serviço");
            } else {
              print("Erro em eliminar item " + list_item[i]);
            }
          }
          break;
        }
      case "Boa Vista":
        {
          for (int i = 0; i < list_item.length; i++) {
            var response = await http.delete(
                Uri.parse(removeItemCartBoaVista + list_item[i]),
                headers: <String, String>{'authorization': basicAuth});
            // print(response.body);

            if (response.statusCode == 200) {
              final jsonResponse = json.decode(response.body);
              final _cats = jsonResponse['items'].cast<Map<String, dynamic>>();
              list = _cats
                  .map<CartModel>((cat) => CartModel.fromJson(cat))
                  .toList();
            } else if (response.statusCode == 503) {
              print("Erro de serviço");
            } else {
              print("Erro em eliminar item " + list_item[i]);
            }
          }
          break;
        }
      case "Sal":
        {
          for (int i = 0; i < list_item.length; i++) {
            var response = await http.delete(
                Uri.parse(removeItemCartSal + list_item[i]),
                headers: <String, String>{'authorization': basicAuth});
            // print(response.body);

            if (response.statusCode == 200) {
              final jsonResponse = json.decode(response.body);
              final _cats = jsonResponse['items'].cast<Map<String, dynamic>>();
              list = _cats
                  .map<CartModel>((cat) => CartModel.fromJson(cat))
                  .toList();
            } else if (response.statusCode == 503) {
              print("Erro de serviço");
            } else {
              print("Erro em eliminar item " + list_item[i]);
            }
          }
          break;
        }
      case "Maio":
        {
          for (int i = 0; i < list_item.length; i++) {
            var response = await http.delete(
                Uri.parse(removeItemCartMaio + list_item[i]),
                headers: <String, String>{'authorization': basicAuth});
            // print(response.body);

            if (response.statusCode == 200) {
              final jsonResponse = json.decode(response.body);
              final _cats = jsonResponse['items'].cast<Map<String, dynamic>>();
              list = _cats
                  .map<CartModel>((cat) => CartModel.fromJson(cat))
                  .toList();
            } else if (response.statusCode == 503) {
              print("Erro de serviço");
            } else {
              print("Erro em eliminar item " + list_item[i]);
            }
          }
          break;
        }
      case "Santiago":
        {
          for (int i = 0; i < list_item.length; i++) {
            var response = await http.delete(
                Uri.parse(removeItemCartSantiago + list_item[i]),
                headers: <String, String>{'authorization': basicAuth});
            // print(response.body);

            if (response.statusCode == 200) {
              final jsonResponse = json.decode(response.body);
              final _cats = jsonResponse['items'].cast<Map<String, dynamic>>();
              list = _cats
                  .map<CartModel>((cat) => CartModel.fromJson(cat))
                  .toList();
            } else if (response.statusCode == 503) {
              print("Erro de serviço");
            } else {
              print("Erro em eliminar item " + list_item[i]);
            }
          }
          break;
        }
      case "Fogo":
        {
          for (int i = 0; i < list_item.length; i++) {
            var response = await http.delete(
                Uri.parse(removeItemCartFogo + list_item[i]),
                headers: <String, String>{'authorization': basicAuth});
            // print(response.body);

            if (response.statusCode == 200) {
              final jsonResponse = json.decode(response.body);
              final _cats = jsonResponse['items'].cast<Map<String, dynamic>>();
              list = _cats
                  .map<CartModel>((cat) => CartModel.fromJson(cat))
                  .toList();
            } else if (response.statusCode == 503) {
              print("Erro de serviço");
            } else {
              print("Erro em eliminar item " + list_item[i]);
            }
          }
          break;
        }

      case "Brava":
        {
          for (int i = 0; i < list_item.length; i++) {
            var response = await http.delete(
                Uri.parse(removeItemCartBrava + list_item[i]),
                headers: <String, String>{'authorization': basicAuth});
            // print(response.body);

            if (response.statusCode == 200) {
              final jsonResponse = json.decode(response.body);
              final _cats = jsonResponse['items'].cast<Map<String, dynamic>>();
              list = _cats
                  .map<CartModel>((cat) => CartModel.fromJson(cat))
                  .toList();
            } else if (response.statusCode == 503) {
              print("Erro de serviço");
            } else {
              print("Erro em eliminar item " + list_item[i]);
            }
          }
          break;
        }
    }

    return listCart;
  }

  //! Cart
  //? addCart
  static Future addCart(item, quant) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await loginCoCart();
    String basicAuth =
        'Basic ' + base64Encode(utf8.encode(user.username + ':' + user.senha));
    var island = prefs.getString('island');

    var response;
    switch (island) {
      case "São Antão":
        response = await http.post(Uri.parse(addItemCartSantoAntao),
            headers: <String, String>{'authorization': basicAuth},
            body: {'id': item.toString(), 'quantity': quant.toString()});
        break;
      case "São  Vicente":
        response = await http.post(Uri.parse(addItemCartSaoVicente),
            headers: <String, String>{'authorization': basicAuth},
            body: {'id': item.toString(), 'quantity': quant.toString()});
        break;
      case "São Nicolau":
        response = await http.post(Uri.parse(addItemCartSaoNicolau),
            headers: <String, String>{'authorization': basicAuth},
            body: {'id': item.toString(), 'quantity': quant.toString()});
        break;
      case "Boa Vista":
        response = await http.post(Uri.parse(addItemCartBoaVista),
            headers: <String, String>{'authorization': basicAuth},
            body: {'id': item.toString(), 'quantity': quant.toString()});
        break;
      case "Sal":
        response = await http.post(Uri.parse(addItemCartSal),
            headers: <String, String>{'authorization': basicAuth},
            body: {'id': item.toString(), 'quantity': quant.toString()});
        break;
      case "Maio":
        response = await http.post(Uri.parse(addItemCartMaio),
            headers: <String, String>{'authorization': basicAuth},
            body: {'id': item.toString(), 'quantity': quant.toString()});
        break;
      case "Santiago":
        response = await http.post(Uri.parse(addItemCartSantiago),
            headers: <String, String>{'authorization': basicAuth},
            body: {'id': item.toString(), 'quantity': quant.toString()});
        break;
      case "Fogo":
        response = await http.post(Uri.parse(addItemCartFogo),
            headers: <String, String>{'authorization': basicAuth},
            body: {'id': item.toString(), 'quantity': quant.toString()});
        break;
      case "Brava":
        response = await http.post(Uri.parse(addItemCartBrava),
            headers: <String, String>{'authorization': basicAuth},
            body: {'id': item.toString(), 'quantity': quant.toString()});
        break;
    }

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
    final String? itemFavortiesString = prefs.getString('itens_favorites');
    var island = prefs.getString('island');
    if (itemFavortiesString != null) {
      // decode and store data in SharedPreferences
      List<Favorite> list = Favorite.decode(itemFavortiesString);
      list.add(new Favorite(id: id, island: island.toString()));

      // Encode and store data in SharedPreferences
      final String encodedData = Favorite.encode(list);

      await prefs.setString('itens_favorites', encodedData);
    } else {
      List<Favorite> list = [];
      list.add(new Favorite(id: id, island: island.toString()));
      // Encode and store data in SharedPreferences
      final String encodedData = Favorite.encode(list);

      await prefs.setString('itens_favorites', encodedData);
    }
  }

  //?remove favorite
  static Future removeFavrite(int id) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? itemFavortiesString = prefs.getString('itens_favorites');

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
    final String? itemFavortiesString = prefs.getString('itens_favorites');

    if (itemFavortiesString != null) {
      // decode and store data in SharedPreferences
      List<Favorite> listFavorites = Favorite.decode(itemFavortiesString);
      var island = prefs.getString('island');
      for (int i = 0; i < listFavorites.length; i++) {
        if (listFavorites[i].island == island) {
          var response = await http.get(Uri.parse(
              get_Produto + listFavorites[i].id.toString() + "?" + key));

          //  print(response.body);
          if (response.statusCode == 200) {
            final jsonResponse = json.decode(response.body);
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
    final String? itemLocationString = prefs.getString('itens_location');
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
    String? itemLocationString = prefs.getString('itens_location');

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
       // print("-" + list[i].name);
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
    final String? itemLocationString = prefs.getString('itens_location');

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

  //! load Dolar
  static Future loadDolar() async {
    var response = await http.get(Uri.parse(url_consulta_Dolar));

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      String dolar = jsonResponse['USD']['bid'];

      return dolar;
    } else if (response.statusCode == 503) {
      print("Erro de serviço");
      return false;
    } else {
      print("Erro de authentiction");
      return false;
    }
  }

  //! order
  //?get ORDER
  static Future<List<Order>> loadOrder() async {
    List<Order> list = [];
    List<Order> list_order = [];
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    var id = prefs.getString('id');
    var response =
        await http.get(Uri.parse(getOrder + "&customer=" + id.toString()));
  //  print(response.body);
    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      final _cats = jsonResponse.cast<Map<String, dynamic>>();
      list = _cats.map<Order>((cat) => Order.fromJson(cat)).toList();

      for (int i = 0; i < list.length; i++) {
        if (list[i].status == "processing" || list[i].status == "completed") {
          list_order.add(list[i]);
        }
      }
    } else if (response.statusCode == 503) {
      print("Erro de serviço");
    } else {
      print("Erro de authentiction");
    }
    return list_order;
  }

  //! registar
  static Future createOrder(
      bool pagamento,
      status,
      Location location,
      List<CartModel> listProduct,
      total,
      note,
      bool isCheckedPromocao,
      String cupon) async {
    var headers = {
      'Content-Type': 'application/json',
    };

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? userString = prefs.getString('user');
    var userCache = json.decode(userString!);
    var id = prefs.getString('id');
    var data;
    if (location == null) {
      data = json.encode({
        "customer_id": id.toString(),
        "payment_method": "",
        "payment_method_title": "",
        "set_paid": pagamento.toString(),
        "status": status.toString(),
        "billing": {
          "first_name": userCache['name'].toString(),
          "last_name": userCache['nickname'].toString(),
          "address_1": "",
          "address_2": "",
          "city": userCache['city'].toString(),
          "state": "",
          "postcode": "",
          "country": userCache['country'].toString(),
          "email": userCache['email'].toString(),
          "phone": userCache['telefone'].toString()
        },
        "shipping": {
          "first_name": "",
          "last_name": "",
          "address_1": "",
          "address_": "",
          "city": "",
          "state": "",
          "postcode": "",
          "country": "",
          "email": "",
          "phone": ""
        },
        "line_items": listProduct
            .map<Map<String, dynamic>>((item) => CartModel.toMap(item))
            .toList(),
        "customer_note": note.toString(),
        "shipping_lines": [
          {
            "method_id": "flat_rate",
            "method_title": "Flat Rate",
            "total": total.toString()
          }
        ]
      });
    } else {
      if (isCheckedPromocao == true) {
        data = json.encode({
          "customer_id": id.toString(),
          "payment_method": "",
          "payment_method_title": "",
          "set_paid": pagamento.toString(),
          "status": status.toString(),
          "coupon_lines": [
            {"code": cupon.toString()}
          ],
          "billing": {
            "first_name": userCache['name'].toString(),
            "last_name": userCache['nickname'].toString(),
            "address_1": "",
            "address_2": "",
            "city": userCache['city'].toString(),
            "state": "",
            "postcode": "",
            "country": userCache['country'].toString(),
            "email": userCache['email'].toString(),
            "phone": userCache['telefone'].toString()
          },
          "shipping": {
            "first_name": location.name,
            "last_name": "",
            "address_1": location.endereco,
            "address_": "",
            "city": location.city,
            "state": "",
            "postcode": "",
            "country": location.island,
            "email": location.email,
            "phone": location.phone
          },
          "line_items": listProduct
              .map<Map<String, dynamic>>((item) => CartModel.toMap(item))
              .toList(),
          "customer_note": note.toString(),
          "shipping_lines": [
            {
              "method_id": "flat_rate",
              "method_title": "Flat Rate",
              "total": "5"
            }
          ]
        });
      } else {
        data = json.encode({
          "customer_id": id.toString(),
          "payment_method": "",
          "payment_method_title": "",
          "set_paid": pagamento.toString(),
          "status": status.toString(),
          "billing": {
            "first_name": userCache['name'].toString(),
            "last_name": userCache['nickname'].toString(),
            "address_1": "",
            "address_2": "",
            "city": userCache['city'].toString(),
            "state": "",
            "postcode": "",
            "country": userCache['country'].toString(),
            "email": userCache['email'].toString(),
            "phone": userCache['telefone'].toString()
          },
          "shipping": {
            "first_name": location.name,
            "last_name": "",
            "address_1": location.endereco,
            "address_": "",
            "city": location.city,
            "state": "",
            "postcode": "",
            "country": location.island,
            "email": location.email,
            "phone": location.phone
          },
          "line_items": listProduct
              .map<Map<String, dynamic>>((item) => CartModel.toMap(item))
              .toList(),
          "customer_note": note.toString(),
          "shipping_lines": [
            {
              "method_id": "flat_rate",
              "method_title": "Flat Rate",
              "total": "5"
            }
          ]
        });
      }
    }


    var response =
        await http.post(Uri.parse(getOrder), headers: headers, body: data);

     // print(response.statusCode);
    //print(response.body);
    if (response.statusCode == 201) {
      List<String> list_item = [];
      for (int i = 0; i < listProduct.length; i++) {
        list_item.add(listProduct[i].item_key);
      }
      if (status == "processing") {
        removeCart(list_item);
      }

      return true;
    } else if (response.statusCode == 503) {
      print("Erro de serviço");
      return false;
    } else {
      print("Erro de authentiction");
      return false;
    }
    return false;
  }

  //! load product by id
  static Future loadProductbyId(id) async {
    var response =
        await http.get(Uri.parse(get_Produto + id.toString() + "?" + key));

    //  print(response.body);
    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      Product novo = new Product(
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
          favorite: false);
      return novo;
    } else {
      print("Erro em carregar o produto");
    }
    return false;
  }
}
