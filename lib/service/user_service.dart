import 'dart:convert';

import 'package:manda_bai/Controller/static_config.dart';
import 'package:manda_bai/Model/user.dart';
import 'package:manda_bai/constants/controllers.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class UserService {
  Future<bool> login(String username, String password) async {
    var island = fullControllerController.island.value;
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
            body: {'username': username, 'password': password});
        break;
    }

    // print(response.statusCode.toString() + "\n" + response.body);
    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      final SharedPreferences prefs = await SharedPreferences.getInstance();

      await prefs.setString('id', jsonResponse["data"]["ID"].toString());
      await prefs.setString('username', username);
      await prefs.setString('password', password);
      user.senha = password;
      user.username = username;
      GetUser();
      return true;
    } else if (response.statusCode == 503) {
      print("Erro de serviço");
      return false;
    }
    return false;
  }

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

    if (response.statusCode == 201) {
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
  Future updateAccount() async {
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

   var u= await http.post(Uri.parse(request_login_Santiago),
        body: {'username': user.username, 'password': user.senha});
   var body=jsonDecode(u.body);
   var id=body['ID'].toString();
    var response = await http.put(
        Uri.parse(getUserSantiago + id.toString() + "?" + keySantiago),
        headers: headers,
        body: data);
print(response.statusCode);
    if (response.statusCode == 200) {
     var updateId= await http.post(Uri.parse(request_login_SantoAntao),
          body: {'username': user.username, 'password': user.senha});
     var body=jsonDecode(updateId.body);
     id=body['ID'].toString();
      await http.put(
          Uri.parse(getUserSantoAntao + id.toString() + "?" + keySantoAntao),
          headers: headers,
          body: data);
     updateId= await http.post(Uri.parse(request_login_SaoNicolau),
          body: {'username': user.username, 'password': user.senha});
      body=jsonDecode(updateId.body);
     id=body['ID'].toString();
      await http.put(
          Uri.parse(getUserSaoNicolau + id.toString() + "?" + keySaoNicolau),
          headers: headers,
          body: data);
     updateId=await http.post(Uri.parse(request_login_SaoVicente),
          body: {'username': user.username, 'password': user.senha});
     body=jsonDecode(updateId.body);
     id=body['ID'].toString();
      await http.put(
          Uri.parse(getUserSaoVicente + id.toString() + "?" + keySaoVicente),
          headers: headers,
          body: data);
     updateId=  await http.post(Uri.parse(request_login_BoaVista),
          body: {'username': user.username, 'password': user.senha});
     body=jsonDecode(updateId.body);
     id=body['ID'].toString();
      await http.put(
          Uri.parse(getUserBoaVista + id.toString() + "?" + keyBoaVista),
          headers: headers,
          body: data);
     updateId=await http.post(Uri.parse(request_login_Sal),
          body: {'username': user.username, 'password': user.senha});
     body=jsonDecode(updateId.body);
     id=body['ID'].toString();
      await http.put(Uri.parse(getUserSal + id.toString() + "?" + keySal),
          headers: headers, body: data);
     updateId= await http.post(Uri.parse(request_login_Maio),
          body: {'username': user.username, 'password': user.senha});
     body=jsonDecode(updateId.body);
     id=body['ID'].toString();
      await http.put(Uri.parse(getUserMaio + id.toString() + "?" + keyMaio),
          headers: headers, body: data);
     updateId= await http.post(Uri.parse(request_login_Fogo),
          body: {'username': user.username, 'password': user.senha});
     body=jsonDecode(updateId.body);
     id=body['ID'].toString();
      await http.put(Uri.parse(getUserFogo + id.toString() + "?" + keyFogo),
          headers: headers, body: data);
     updateId= await http.post(Uri.parse(request_login_Brava),
          body: {'username': user.username, 'password': user.senha});
     body=jsonDecode(updateId.body);
     id=body['ID'].toString();
      await http.put(Uri.parse(getUserBrava + id.toString() + "?" + keyBrava),
          headers: headers, body: data);

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
}
