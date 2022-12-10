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
import 'package:manda_bai/constants/controllers.dart';
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
    //print("--"+response.body);
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

  //! Load Products
  static Future<List<Product>> loadProduct(id) async {
    print('entro product');

    List<Product> list = [];
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var island = prefs.getString('island');

    var response;
    if (productController.statusLoadProdutoPage == "init") {
      loadProdutoPage = 1;
      switch (island) {
        case "Santo Antão":
          response = await http
              .get(Uri.parse(productCategoriasSaoAntao + id.toString()));
          break;
        case "São Vicente":
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
    } else if (productController.statusLoadProdutoPage == "next") {
      if (loadProdutoPage == 1) {
        loadProdutoPage = 2;
      }

      switch (island) {
        case "Santo Antão":
          response = await http.get(Uri.parse(productCategoriasSaoAntao +
              id.toString() +
              "&page=" +
              loadProdutoPage.toString()));
          break;
        case "São Vicente":
          response = await http.get(Uri.parse(productCategoriasSaoVicente +
              id.toString() +
              "&page=" +
              loadProdutoPage.toString()));
          break;
        case "São Nicolau":
          response = await http.get(Uri.parse(productCategoriasSaoNicolau +
              id.toString() +
              "&page=" +
              loadProdutoPage.toString()));
          break;
        case "Boa Vista":
          response = await http.get(Uri.parse(productCategoriasBoaVista +
              id.toString() +
              "&page=" +
              loadProdutoPage.toString()));
          break;
        case "Sal":
          response = await http.get(Uri.parse(productCategoriasSal +
              id.toString() +
              "&page=" +
              loadProdutoPage.toString()));
          break;
        case "Maio":
          response = await http.get(Uri.parse(productCategoriasMaio +
              id.toString() +
              "&page=" +
              loadProdutoPage.toString()));
          break;
        case "Santiago":
          response = await http.get(Uri.parse(productCategoriasSantiago +
              id.toString() +
              "&page=" +
              loadProdutoPage.toString()));
          //  print(productCategoriasSantiago + id.toString());
          break;
        case "Fogo":
          response = await http.get(Uri.parse(productCategoriasFogo +
              id.toString() +
              "&page=" +
              loadProdutoPage.toString()));
          break;
        case "Brava":
          response = await http.get(Uri.parse(productCategoriasBrava +
              id.toString() +
              "&page=" +
              loadProdutoPage.toString()));
          break;
      }
    }

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);

      if (jsonResponse != "[]") {
        final _cats = jsonResponse.cast<Map<String, dynamic>>();
        list = _cats.map<Product>((cat) => Product.fromJson(cat)).toList();
        var quantidade = response.headers['x-wp-total'];
        loadProdutoTotal = int.parse(quantidade);
        var page = response.headers['x-wp-totalpages'];
        int pages = int.parse(page);
        //  print("TotalPage: "+pages.toString()+" - AtualPage:p "+loadProdutoPage.toString());
        if (pages == 1 || pages == loadProdutoPage) {
          productController.statusLoadProdutoPage = "close";
          return list;
        } else {
          if (productController.statusLoadProdutoPage == "init") {
            loadProdutoPage = 1;
          } else {
            productController.statusLoadProdutoPage = "next";
            loadProdutoPage++;
          }

          return list;
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
    var response = await http.post(Uri.parse(register_client_Santiago),
        headers: headers, body: data);
    /*await http.post(Uri.parse(register_client),
        headers: headers, body: data);*/
    print(response.body);
    if (response.statusCode == 201) {
      final jsonResponse = json.decode(response.body);

      /*registro para os dominios*/
      await http.post(Uri.parse(register_client_SantoAntao),
          headers: headers, body: data);
      await http.post(Uri.parse(register_client_SaoVicente),
          headers: headers, body: data);
      await http.post(Uri.parse(register_client_SaoNicolau),
          headers: headers, body: data);
      await http.post(Uri.parse(register_client_Sal),
          headers: headers, body: data);
      await http.post(Uri.parse(register_client_BoaVista),
          headers: headers, body: data);
      await http.post(Uri.parse(register_client_Maio),
          headers: headers, body: data);
      await http.post(Uri.parse(register_client_Santiago),
          headers: headers, body: data);
      await http.post(Uri.parse(register_client_Fogo),
          headers: headers, body: data);
      await http.post(Uri.parse(register_client_Brava),
          headers: headers, body: data);

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
      "user_email": user.email,
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
    await http.post(Uri.parse(request_login),
        body: {'username': user.username, 'password': user.senha});

    var response = await http.put(
        Uri.parse(updateUser + id.toString() + "?" + key),
        headers: headers,
        body: data);

    if (response.statusCode == 200) {
      await http.post(Uri.parse(request_login_SantoAntao),
          body: {'username': user.username, 'password': user.senha});
      await http.put(
          Uri.parse(getUserSantoAntao + id.toString() + "?" + keySantoAntao),
          headers: headers,
          body: data);
      await http.post(Uri.parse(request_login_SaoNicolau),
          body: {'username': user.username, 'password': user.senha});
      await http.put(
          Uri.parse(getUserSaoNicolau + id.toString() + "?" + keySaoNicolau),
          headers: headers,
          body: data);
      await http.post(Uri.parse(request_login_SaoVicente),
          body: {'username': user.username, 'password': user.senha});
      await http.put(
          Uri.parse(getUserSaoVicente + id.toString() + "?" + keySaoVicente),
          headers: headers,
          body: data);
      await http.post(Uri.parse(request_login_BoaVista),
          body: {'username': user.username, 'password': user.senha});
      await http.put(
          Uri.parse(getUserBoaVista + id.toString() + "?" + keyBoaVista),
          headers: headers,
          body: data);
      await http.post(Uri.parse(request_login_Sal),
          body: {'username': user.username, 'password': user.senha});
      await http.put(Uri.parse(getUserSal + id.toString() + "?" + keySal),
          headers: headers, body: data);
      await http.post(Uri.parse(request_login_Maio),
          body: {'username': user.username, 'password': user.senha});
      await http.put(Uri.parse(getUserMaio + id.toString() + "?" + keyMaio),
          headers: headers, body: data);
      await http.post(Uri.parse(request_login_Fogo),
          body: {'username': user.username, 'password': user.senha});
      await http.put(
          Uri.parse(getUserSantiago + id.toString() + "?" + keySantiago),
          headers: headers,
          body: data);
      await http.put(Uri.parse(getUserFogo + id.toString() + "?" + keyFogo),
          headers: headers, body: data);
      await http.post(Uri.parse(request_login_Brava),
          body: {'username': user.username, 'password': user.senha});
      await http.put(Uri.parse(getUserBrava + id.toString() + "?" + keyBrava),
          headers: headers, body: data);
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
      case "Santo Antão":
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

    print(response.statusCode + "\n" + response.body);
    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      final SharedPreferences prefs = await SharedPreferences.getInstance();

      await prefs.setString('id', jsonResponse["data"]["ID"].toString());
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

  static Future loginFresh() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var island = prefs.getString('island');

    var response;
    switch (island) {
      case "Santo Antão":
        {
          response = await http.post(Uri.parse(request_login_SantoAntao),
              body: {'username': user.username, 'password': user.senha});

          break;
        }

      case "São Vicente":
        {
          response = await http.post(Uri.parse(request_login_SaoVicente),
              body: {'username': user.username, 'password': user.senha});

          break;
        }

      case "São Nicolau":
        {
          response = await http.post(Uri.parse(request_login_SaoNicolau),
              body: {'username': user.username, 'password': user.senha});

          break;
        }

      case "Boa Vista":
        {
          response = await http.post(Uri.parse(request_login_BoaVista),
              body: {'username': user.username, 'password': user.senha});

          break;
        }

      case "Sal":
        {
          response = await http.post(Uri.parse(request_login_Sal),
              body: {'username': user.username, 'password': user.senha});

          break;
        }

      case "Maio":
        {
          response = await http.post(Uri.parse(request_login_Maio),
              body: {'username': user.username, 'password': user.senha});

          break;
        }

      case "Santiago":
        {
          response = await http.post(Uri.parse(request_login_Santiago),
              body: {'username': user.username, 'password': user.senha});

          break;
        }

      case "Fogo":
        {
          response = await http.post(Uri.parse(request_login_Fogo),
              body: {'username': user.username, 'password': user.senha});

          break;
        }

      case "Brava":
        {
          response = await http.post(Uri.parse(request_login_Brava),
              body: {'username': user.username, 'password': user.senha});

          break;
        }
    }
    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('id', jsonResponse["data"]["ID"].toString());
      return true;
    }
  }

//! login cocart
  static Future loginCoCart() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var island = prefs.getString('island');

    var response, responseCocart;
    switch (island) {
      case "Santo Antão":
        {
          response = await http.post(Uri.parse(request_login_SantoAntao),
              body: {'username': user.username, 'password': user.senha});
          responseCocart = await http.post(
              Uri.parse(request_loginCocart_SantoAntao),
              body: {'username': user.username, 'password': user.senha});
          break;
        }

      case "São Vicente":
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
          responseCocart = await http.post(Uri.parse(request_loginCocart_Brava),
              body: {'username': user.username, 'password': user.senha});
          break;
        }
    }

    //print("Cocart:" + responseCocart.statusCode.toString());
    return responseCocart.statusCode;
  }
  //! Get User

  static Future GetUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var id = prefs.getString('id');
    var island = fullControllerController.island.value;

    var response;
    switch (island) {
      case "Santo Antão":
        {
          response = await http.post(Uri.parse(
            getUserSantoAntao + id.toString() + "?" + keySantoAntao,
          ));
          break;
        }

      case "São Vicente":
        {
          response = await http.post(Uri.parse(
            getUserSaoVicente + id.toString() + "?" + keySaoVicente,
          ));
          break;
        }

      case "São Nicolau":
        {
          response = await http.post(Uri.parse(
            getUserSaoNicolau + id.toString() + "?" + keySaoNicolau,
          ));
          break;
        }

      case "Boa Vista":
        {
          response = await http.post(Uri.parse(
            getUserBoaVista + id.toString() + "?" + keyBoaVista,
          ));
          break;
        }

      case "Sal":
        {
          response = await http.post(Uri.parse(
            getUserSal + id.toString() + "?" + keySal,
          ));
          break;
        }

      case "Maio":
        {
          response = await http.post(Uri.parse(
            getUserMaio + id.toString() + "?" + keyMaio,
          ));
          break;
        }

      case "Santiago":
        {
          response = await http.post(Uri.parse(
            getUserSantiago + id.toString() + "?" + keySantiago,
          ));
          break;
        }

      case "Fogo":
        {
          response = await http.post(Uri.parse(
            getUserFogo + id.toString() + "?" + keyFogo,
          ));
          break;
        }

      case "Brava":
        {
          response = await http.post(Uri.parse(
            getUserBrava + id.toString() + "?" + keyBrava,
          ));
          break;
        }
    }

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
    do {
      var loginCocart = await loginCoCart();
      String basicAuth = 'Basic ' +
          base64Encode(utf8.encode(user.username! + ':' + user.senha!));
      var island = fullControllerController.island.value;

      if (loginCocart == 200) {
        switch (island) {
          case "Santo Antão":
            response = await http.get(Uri.parse(getCartSaoAntao),
                headers: <String, String>{'authorization': basicAuth});
            break;
          case "São Vicente":
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
      }
    } while (response.statusCode == 503);

    return listCart;
  }

  //! removeItemCart
  static Future<List<CartModel>> removeCart(List<String> list_item) async {
    List<CartModel> list = [];
    String basicAuth =
        'Basic ' + base64Encode(utf8.encode(user.username! + ':' + user.senha!));
    switch (fullControllerController.island.value) {
      case "Santo Antão":
        {
          for (int i = 0; i < list_item.length; i++) {
            var response = await http.delete(
                Uri.parse(removeItemCartSantoAntao + list_item[i]),
                headers: <String, String>{'authorization': basicAuth});

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
      case "São Vicente":
        {
          for (int i = 0; i < list_item.length; i++) {
            var response = await http.delete(
                Uri.parse(removeItemCartSaoVicente + list_item[i]),
                headers: <String, String>{'authorization': basicAuth});
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

    return list;
  }

  //! Cart
  //? addCart
  static Future addCart(item, quant) async {
    var loginCocart = await loginCoCart();
    String basicAuth =
        'Basic ' + base64Encode(utf8.encode(user.username! + ':' + user.senha!));
    var island = fullControllerController.island.value;

    if (loginCocart == 200) {
      var response;
      switch (island) {
        case "Santo Antão":
          response = await http.post(Uri.parse(addItemCartSantoAntao),
              headers: <String, String>{'authorization': basicAuth},
              body: {'id': item.toString(), 'quantity': quant.toString()});
          break;
        case "São Vicente":
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
        List<CartModel> list = [];
        final jsonResponse = json.decode(response.body);
        final _cats = jsonResponse['items'].cast<Map<String, dynamic>>();
        list = _cats.map<CartModel>((cat) => CartModel.fromJson(cat)).toList();
        cartPageController.listCart.value = list;
        return true;
      } else if (response.statusCode == 503) {
        print("Erro de serviço");
      } else {
        print("Erro de authentiction");
      }
    }
    return false;
  }

  //! Favorite
  //?add favorite
  static Future addFavrite(int id) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? itemFavortiesString = prefs.getString('itens_favorites');
    final String? itemusernameString = prefs.getString('username');
    var island = fullControllerController.island.value;
    if (itemFavortiesString != null) {
      // decode and store data in SharedPreferences
      List<Favorite> list = Favorite.decode(itemFavortiesString);
      list.add(Favorite(
          id: id, island: island.toString(), username: itemusernameString!));

      // Encode and store data in SharedPreferences
      final String encodedData = Favorite.encode(list);
      await prefs.setString('itens_favorites', encodedData);
    } else {
      List<Favorite> list = [];
      list.add(Favorite(
          id: id, island: island.toString(), username: itemusernameString!));
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
    // prefs.remove('itens_favorites');
    final String? itemFavortiesString = prefs.getString('itens_favorites');

    if (itemFavortiesString != null) {
      final String? itemusernameString = prefs.getString('username');
      // decode and store data in SharedPreferences
      List<Favorite> listFavorites = Favorite.decode(itemFavortiesString);
      var island = prefs.getString('island');

      for (int i = 0; i < listFavorites.length; i++) {
        if (listFavorites[i].island == island) {
          if (listFavorites[i].username == itemusernameString) {
            var response;
            switch (island) {
              case "Santo Antão":
                response = await http.get(Uri.parse(get_ProdutoSaoAntao +
                    listFavorites[i].id.toString() +
                    "?" +
                    keySantoAntao));
                break;
              case "São Vicente":
                response = await http.get(Uri.parse(get_ProdutoSaoVicente +
                    listFavorites[i].id.toString() +
                    "?" +
                    keySaoVicente));
                break;
              case "São Nicolau":
                response = await http.get(Uri.parse(get_ProdutoSaoNicolau +
                    listFavorites[i].id.toString() +
                    "?" +
                    keySaoNicolau));
                break;
              case "Boa Vista":
                response = await http.get(Uri.parse(get_ProdutoBoaVista +
                    listFavorites[i].id.toString() +
                    "?" +
                    keyBoaVista));
                break;
              case "Sal":
                response = await http.get(Uri.parse(get_ProdutoSal +
                    listFavorites[i].id.toString() +
                    "?" +
                    keySal));
                break;
              case "Maio":
                response = await http.get(Uri.parse(get_ProdutoMaio +
                    listFavorites[i].id.toString() +
                    "?" +
                    keyMaio));
                break;
              case "Santiago":
                response = await http.get(Uri.parse(get_ProdutoSantiago +
                    listFavorites[i].id.toString() +
                    "?" +
                    keySantiago));
                break;
              case "Fogo":
                response = await http.get(Uri.parse(get_ProdutoFogo +
                    listFavorites[i].id.toString() +
                    "?" +
                    keyFogo));
                break;
              case "Brava":
                response = await http.get(Uri.parse(get_ProdutoBrava +
                    listFavorites[i].id.toString() +
                    "?" +
                    keyBrava));
                break;
            }
            if (response.statusCode == 200) {
              final jsonResponse = json.decode(response.body);
              list.add(Product(
                  id: jsonResponse['id'],
                  name: jsonResponse['name'].toString(),
                  description: jsonResponse['description'].toString(),
                  price: double.parse(jsonResponse['price']),
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
    final String? itemLocationString = prefs.getString('itens_location');
    if (itemLocationString != null) {
      final String? itemusernameString = prefs.getString('username');
      List<Location> listApp = Location.decode(itemLocationString);
      for (int i = 0; i < listApp.length; i++) {
        if (listApp[i].username == itemusernameString) {
          list.add(listApp[i]);
        }
      }
      // decode and store data in SharedPreferencesSS

      return list;
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
      new_location.idUpdate = list[list.length - 1].id! + 1;

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
        if (list[i].id == new_location.id) {
          locationController.listLocation.value=list;
          return true;
        }
      }
    } else {
      return false;
    }
    return false;
  }

  //?remove location
 static Future<bool> removeLocation(int id) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? itemLocationString = prefs.getString('itens_location');

    if (itemLocationString != null) {

      // decode and store data in SharedPreferences
      List<Location> list = Location.decode(itemLocationString);
      List<Location> list_new = [];
      if (list.length < 2) {
        prefs.remove('itens_location');
        return true;
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
        return true;
      }
    }
  return false;
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
  static Future<List<Order>> loadOrder(String island) async {
    List<Order> list = [];
    List<Order> listOrder = [];
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var id = prefs.getString('id');
    var response;

    if (fullControllerController.island.value != island) {
      switch (island) {
        case "Santo Antão":
          {
            response = await http.post(Uri.parse(request_login_SantoAntao),
                body: {'username': user.username, 'password': user.senha});

            break;
          }

        case "São Vicente":
          {
            response = await http.post(Uri.parse(request_login_SaoVicente),
                body: {'username': user.username, 'password': user.senha});

            break;
          }

        case "São Nicolau":
          {
            response = await http.post(Uri.parse(request_login_SaoNicolau),
                body: {'username': user.username, 'password': user.senha});

            break;
          }

        case "Boa Vista":
          {
            response = await http.post(Uri.parse(request_login_BoaVista),
                body: {'username': user.username, 'password': user.senha});

            break;
          }

        case "Sal":
          {
            response = await http.post(Uri.parse(request_login_Sal),
                body: {'username': user.username, 'password': user.senha});

            break;
          }

        case "Maio":
          {
            response = await http.post(Uri.parse(request_login_Maio),
                body: {'username': user.username, 'password': user.senha});

            break;
          }

        case "Santiago":
          {
            response = await http.post(Uri.parse(request_login_Santiago),
                body: {'username': user.username, 'password': user.senha});

            break;
          }

        case "Fogo":
          {
            response = await http.post(Uri.parse(request_login_Fogo),
                body: {'username': user.username, 'password': user.senha});

            break;
          }

        case "Brava":
          {
            response = await http.post(Uri.parse(request_login_Brava),
                body: {'username': user.username, 'password': user.senha});

            break;
          }
      }
      if (response.statusCode == 200) {
        //  print("login:"+response.body);
        final jsonResponse = json.decode(response.body);
        id = jsonResponse["data"]["ID"].toString();
      }
    }

    switch (island) {
      case "Santo Antão":
        response = await http
            .get(Uri.parse(getOrderSantoAntao + "&customer=" + id.toString()));
        break;
      case "São Vicente":
        response = await http
            .get(Uri.parse(getOrderSaoVicente + "&customer=" + id.toString()));
        break;
      case "São Nicolau":
        response = await http
            .get(Uri.parse(getOrderSaoNicolau + "&customer=" + id.toString()));
        break;
      case "Boa Vista":
        response = await http
            .get(Uri.parse(getOrderBoaVista + "&customer=" + id.toString()));
        break;
      case "Sal":
        response = await http
            .get(Uri.parse(getOrderSal + "&customer=" + id.toString()));
        break;
      case "Maio":
        response = await http
            .get(Uri.parse(getOrderMaio + "&customer=" + id.toString()));
        break;
      case "Santiago":
        response = await http
            .get(Uri.parse(getOrderSantiago + "&customer=" + id.toString()));
        break;
      case "Fogo":
        response = await http
            .get(Uri.parse(getOrderFogo + "&customer=" + id.toString()));
        break;
      case "Brava":
        response = await http
            .get(Uri.parse(getOrderBrava + "&customer=" + id.toString()));
        break;
    }
    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      final _cats = jsonResponse.cast<Map<String, dynamic>>();
      list = _cats.map<Order>((cat) => Order.fromJson(cat)).toList();

      for (int i = 0; i < list.length; i++) {
        if (!list[i].status.contains("pagamento") && !list[i].status.contains("Pagamento")) {
          listOrder.add(list[i]);
        }
      }
    } else if (response.statusCode == 503) {
      print("Erro de serviço");
    } else {
      print("Erro de authentiction");
    }
    return listOrder;
  }

  //! registar
  static Future createOrder(
      String status,
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
    if (status == "cancelled") {
      data = json.encode({
        "customer_id": id.toString(),
        "set_paid": false,
        "status": "cancelled",
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
            "method_title": "Encomenda de App",
            "total": "5"
          }
        ]
      });
    } else {
      if (isCheckedPromocao == true) {
        data = json.encode({
          "customer_id": id.toString(),
          "set_paid": false,
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
              "method_title": "Encomenda de App",
              "total": "5"
            }
          ]
        });
      } else {
        data = json.encode({
          "customer_id": id.toString(),
          "set_paid": false,
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
              "method_title": "Encomenda de App",
              "total": "5"
            }
          ]
        });
      }
    }
    /*   var response =
        await http.post(Uri.parse(getOrder), headers: headers, body: data);*/
    var island = prefs.getString('island');
    var response;
    switch (island) {
      case "Santo Antão":
        response = await http.post(Uri.parse(getOrderSantoAntao),
            headers: headers, body: data);
        break;
      case "São Vicente":
        response = await http.post(Uri.parse(getOrderSaoVicente),
            headers: headers, body: data);
        break;
      case "São Nicolau":
        response = await http.post(Uri.parse(getOrderSaoNicolau),
            headers: headers, body: data);
        break;
      case "Boa Vista":
        response = await http.post(Uri.parse(getOrderBoaVista),
            headers: headers, body: data);
        break;
      case "Sal":
        response = await http.post(Uri.parse(getOrderSal),
            headers: headers, body: data);
        break;
      case "Maio":
        response = await http.post(Uri.parse(getOrderMaio),
            headers: headers, body: data);
        break;
      case "Santiago":
        response = await http.post(Uri.parse(getOrderSantiago),
            headers: headers, body: data);
        break;
      case "Fogo":
        response = await http.post(Uri.parse(getOrderFogo),
            headers: headers, body: data);
        break;
      case "Brava":
        response = await http.post(Uri.parse(getOrderBrava),
            headers: headers, body: data);
        break;
    }
    if (response.statusCode == 201) {
      final jsonResponse = json.decode(response.body);
      return jsonResponse["id"];
    } else if (response.statusCode == 503) {
      print("Erro de serviço");
      return "Erro de serviço";
    } else if (response.statusCode == 400) {
      print("Erro de cupom");
      return "Erro de cupom";
    } else {
      print("Erro de authentiction");
      return "false";
    }
    return false;
  }

  static Future getOrderIdStatus(order) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var island = prefs.getString('island');
    var response;
    switch (island) {
      case "Santo Antão":
        response = await http
            .get(Uri.parse(getOrderIdSantoAntao + order + "?" + keySantoAntao));
        break;
      case "São Vicente":
        response = await http
            .get(Uri.parse(getOrderIdSaoVicente + order + "?" + keySaoVicente));
        break;
      case "São Nicolau":
        response = await http
            .get(Uri.parse(getOrderIdSaoNicolau + order + "?" + keySaoNicolau));
        break;
      case "Boa Vista":
        response = await http
            .get(Uri.parse(getOrderIdBoaVista + order + "?" + keyBoaVista));
        break;
      case "Sal":
        response =
            await http.get(Uri.parse(getOrderIdSal + order + "?" + keySal));
        break;
      case "Maio":
        response =
            await http.get(Uri.parse(getOrderIdMaio + order + "?" + keyMaio));
        break;
      case "Santiago":
        response = await http
            .get(Uri.parse(getOrderIdSantiago + order + "?" + keySantiago));
        break;
      case "Fogo":
        response =
            await http.get(Uri.parse(getOrderIdFogo + order + "?" + keyFogo));
        break;
      case "Brava":
        response =
            await http.get(Uri.parse(getOrderIdBrava + order + "?" + keyBrava));
        break;
    }
    // var response = await http.get(Uri.parse(getOrderId + order + "?" + key));
    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      return jsonResponse["status"];
    } else if (response.statusCode == 503) {
      print("Erro de serviço");
    } else {
      print("Erro de authentiction");
    }
    return null;
  }

  //! load product by id
  static Future loadProductbyId(id) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var island = prefs.getString('island');
    var response;
    switch (island) {
      case "Santo Antão":
        response = await http.get(Uri.parse(
            get_ProdutoSaoAntao + id.toString() + "?" + keySantoAntao));
        break;
      case "São Vicente":
        response = await http.get(Uri.parse(
            get_ProdutoSaoVicente + id.toString() + "?" + keySaoVicente));
        break;
      case "São Nicolau":
        response = await http.get(Uri.parse(
            get_ProdutoSaoNicolau + id.toString() + "?" + keySaoNicolau));
        break;
      case "Boa Vista":
        response = await http.get(
            Uri.parse(get_ProdutoBoaVista + id.toString() + "?" + keyBoaVista));
        break;
      case "Sal":
        response = await http
            .get(Uri.parse(get_ProdutoSal + id.toString() + "?" + keySal));
        break;
      case "Maio":
        response = await http
            .get(Uri.parse(get_ProdutoMaio + id.toString() + "?" + keyMaio));
        break;
      case "Santiago":
        response = await http.get(
            Uri.parse(get_ProdutoSantiago + id.toString() + "?" + keySantiago));
        break;
      case "Fogo":
        response = await http
            .get(Uri.parse(get_ProdutoFogo + id.toString() + "?" + keyFogo));
        break;
      case "Brava":
        response = await http
            .get(Uri.parse(get_ProdutoBrava + id.toString() + "?" + keyBrava));
        break;
    }
    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      Product novo = Product(
          id: jsonResponse['id'],
          name: jsonResponse['name'].toString(),
          description: jsonResponse['description'].toString(),
          price: double.parse(jsonResponse['price']),
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

  //SET PASSWORD
  static Future resetPassword(email) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    var island = prefs.getString('island');

    var response;
    switch (island) {
      case "Santo Antão":
        response = await http.post(Uri.parse(resetPasswordSantiado),
            body: {'email': email.toString()});
        break;
      case "São Vicente":
        response = await http.post(Uri.parse(resetPasswordSantiado),
            body: {'email': email.toString()});
        break;
      case "São Nicolau":
        response = await http.post(Uri.parse(resetPasswordSantiado),
            body: {'email': email.toString()});
        break;
      case "Boa Vista":
        response = await http.post(Uri.parse(resetPasswordSantiado),
            body: {'email': email.toString()});
        break;
      case "Sal":
        response = await http.post(Uri.parse(resetPasswordSantiado),
            body: {'email': email.toString()});
        break;
      case "Maio":
        response = await http.post(Uri.parse(resetPasswordSantiado),
            body: {'email': email.toString()});
        break;
      case "Santiago":
        response = await http.post(Uri.parse(resetPasswordSantiado),
            body: {'email': email.toString()});
        break;
      case "Fogo":
        response = await http.post(Uri.parse(resetPasswordSantiado),
            body: {'email': email.toString()});
        break;
      case "Brava":
        response = await http.post(Uri.parse(resetPasswordSantiado),
            body: {'email': email.toString()});
        break;
    }
    print(response.body);
    if (response.statusCode == 200) {
      return true;
    } else if (response.statusCode == 503) {
      print("Erro de serviço");
    } else {
      print("Erro de authentiction");
    }

    return false;
  }

  //validate code the email
  static Future validateCodePassword(email, code) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    var island = prefs.getString('island');

    var response;
    switch (island) {
      case "Santo Antão":
        response = await http.post(Uri.parse(validateCodeSantiado),
            body: {'email': email.toString(), 'code': code.toString()});
        break;
      case "São Vicente":
        response = await http.post(Uri.parse(validateCodeSantiado),
            body: {'email': email.toString(), 'code': code.toString()});
        break;
      case "São Nicolau":
        response = await http.post(Uri.parse(validateCodeSantiado),
            body: {'email': email.toString(), 'code': code.toString()});
        break;
      case "Boa Vista":
        response = await http.post(Uri.parse(validateCodeSantiado),
            body: {'email': email.toString(), 'code': code.toString()});
        break;
      case "Sal":
        response = await http.post(Uri.parse(validateCodeSantiado),
            body: {'email': email.toString(), 'code': code.toString()});
        break;
      case "Maio":
        response = await http.post(Uri.parse(validateCodeSantiado),
            body: {'email': email.toString(), 'code': code.toString()});
        break;
      case "Santiago":
        response = await http.post(Uri.parse(validateCodeSantiado),
            body: {'email': email.toString(), 'code': code.toString()});
        break;
      case "Fogo":
        response = await http.post(Uri.parse(validateCodeSantiado),
            body: {'email': email.toString(), 'code': code.toString()});
        break;
      case "Brava":
        response = await http.post(Uri.parse(validateCodeSantiado),
            body: {'email': email.toString(), 'code': code.toString()});
        break;
    }
    print(response.body);
    if (response.statusCode == 200) {
      return true;
    } else if (response.statusCode == 503) {
      print("Erro de serviço");
    } else {
      print("Erro de authentiction");
    }
    return false;
  }

  static Future setPassword(email, code, password) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    var island = prefs.getString('island');

    var response;
    switch (island) {
      case "Santo Antão":
        response = await http.post(Uri.parse(setPasswordSantiado), body: {
          'email': email.toString(),
          'code': code.toString(),
          'password': password.toString()
        });
        break;
      case "São Vicente":
        response = await http.post(Uri.parse(setPasswordSantiado), body: {
          'email': email.toString(),
          'code': code.toString(),
          'password': password.toString()
        });
        break;
      case "São Nicolau":
        response = await http.post(Uri.parse(setPasswordSantiado), body: {
          'email': email.toString(),
          'code': code.toString(),
          'password': password.toString()
        });
        break;
      case "Boa Vista":
        response = await http.post(Uri.parse(setPasswordSantiado), body: {
          'email': email.toString(),
          'code': code.toString(),
          'password': password.toString()
        });
        break;
      case "Sal":
        response = await http.post(Uri.parse(setPasswordSantiado), body: {
          'email': email.toString(),
          'code': code.toString(),
          'password': password.toString()
        });
        break;
      case "Maio":
        response = await http.post(Uri.parse(setPasswordSantiado), body: {
          'email': email.toString(),
          'code': code.toString(),
          'password': password.toString()
        });
        break;
      case "Santiago":
        response = await http.post(Uri.parse(setPasswordSantiado), body: {
          'email': email.toString(),
          'code': code.toString(),
          'password': password.toString()
        });
        break;
      case "Fogo":
        response = await http.post(Uri.parse(setPasswordSantiado), body: {
          'email': email.toString(),
          'code': code.toString(),
          'password': password.toString()
        });
        break;
      case "Brava":
        response = await http.post(Uri.parse(setPasswordSantiado), body: {
          'email': email.toString(),
          'code': code.toString(),
          'password': password.toString()
        });
        break;
    }
    if (response.statusCode == 200) {
      return true;
    } else if (response.statusCode == 503) {
      print("Erro de serviço");
    } else {
      print("Erro de authentiction");
    }
    return false;
  }
}
