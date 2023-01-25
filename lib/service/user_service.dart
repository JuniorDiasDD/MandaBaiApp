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
        response = await http.post(Uri.parse(request_loginCocart_SantoAntao),
            body: {'username': username, 'password': password});
        break;
      case "São  Vicente":
        response = await http.post(Uri.parse(request_loginCocart_SaoVicente),
            body: {'username': username, 'password': password});
        break;
      case "São Nicolau":
        response = await http.post(Uri.parse(request_loginCocart_SaoNicolau),
            body: {'username': username, 'password': password});
        break;
      case "Boa Vista":
        response = await http.post(Uri.parse(request_loginCocart_BoaVista),
            body: {'username': username, 'password': password});
        break;
      case "Sal":
        response = await http.post(Uri.parse(request_loginCocart_Sal),
            body: {'username': username, 'password': password});
        break;
      case "Maio":
        response = await http.post(Uri.parse(request_loginCocart_Maio),
            body: {'username': username, 'password': password});
        break;
      case "Santiago":
        response = await http.post(Uri.parse(request_loginCocart_Santiago),
            body: {'username': username, 'password': password});
        break;
      case "Fogo":
        response = await http.post(Uri.parse(request_loginCocart_Fogo),
            body: {'username': username, 'password': password});
        break;
      case "Brava":
        response = await http.post(Uri.parse(request_loginCocart_Brava),
            body: {'username': username, 'password': password});
        break;
    }

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      final SharedPreferences prefs = await SharedPreferences.getInstance();

      await prefs.setString('id', jsonResponse["user_id"].toString());
      await prefs.setString('username', username);
      await prefs.setString('password', password);
       authenticationController.user.value.senha = password;
       authenticationController.user.value.username = username;
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

       authenticationController.user.value.name = jsonResponse["first_name"];
       authenticationController.user.value.email = jsonResponse["email"];
       authenticationController.user.value.nickname = jsonResponse["last_name"];
       authenticationController.user.value.username = jsonResponse["username"];
       authenticationController.user.value.avatar = jsonResponse["avatar_url"];
       authenticationController.user.value.telefone = jsonResponse["billing"]["phone"];
       authenticationController.user.value.city = jsonResponse["billing"]["city"];
       authenticationController.user.value.country = jsonResponse["billing"]["country"];
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final String encodedData = json.encode(User.toMap(authenticationController.user.value));
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

    print(fullControllerController.island.value);

    var response;
    switch (fullControllerController.island.value) {
      case "Santo Antão":
        {
          response = await http.post(Uri.parse(register_client_SantoAntao),
              headers: headers, body: data);
          break;
        }

      case "São Vicente":
        {
          response = await http.post(Uri.parse(register_client_SaoVicente),
              headers: headers, body: data);
          break;
        }

      case "São Nicolau":
        {
          response = await http.post(Uri.parse(register_client_SaoNicolau),
              headers: headers, body: data);
          break;
        }

      case "Boa Vista":
        {
          response = await http.post(Uri.parse(register_client_BoaVista),
              headers: headers, body: data);
          break;
        }

      case "Sal":
        {
          response = await http.post(Uri.parse(register_client_Sal),
              headers: headers, body: data);
          break;
        }

      case "Maio":
        {
          response = await http.post(Uri.parse(register_client_Maio),
              headers: headers, body: data);
          break;
        }

      case "Santiago":
        {
          response = await http.post(Uri.parse(register_client_Santiago),
              headers: headers, body: data);
          break;
        }

      case "Fogo":
        {
          response = await http.post(Uri.parse(register_client_Fogo),
              headers: headers, body: data);
          break;
        }

      case "Brava":
        {
          response = await http.post(Uri.parse(register_client_Brava),
              headers: headers, body: data);
          break;
        }
    }

    if (response.statusCode == 201) {
      return true;
    } else {
      var jsonResponse = json.decode(response.body);
      authenticationController.errorMessage.value=jsonResponse['message'];
      return false;
    }
  }

  //! registar
  Future updateAccount() async {
    var headers = {
      'Content-Type': 'application/json',
    };

    var data = json.encode({
      "user_email":  authenticationController.user.value.email,
      "first_name":  authenticationController.user.value.name,
      "last_name":  authenticationController.user.value.nickname,
      "password":  authenticationController.user.value.senha,
      "billing": {
        "first_name":  authenticationController.user.value.name,
        "last_name":  authenticationController.user.value.nickname,
        "company": "",
        "address_1": "",
        "address_2": "",
        "city":  authenticationController.user.value.city,
        "state": "",
        "postcode": "",
        "country":  authenticationController.user.value.country,
        "email":  authenticationController.user.value.email,
        "phone":  authenticationController.user.value.telefone,
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
    var id = prefs.get('id');
    var island = fullControllerController.island.value;

    var response;
    switch (island) {
      case "Santo Antão":
        response = await http.put(
            Uri.parse(getUserSantoAntao + id.toString() + "?" + keySantoAntao),
            headers: headers,
            body: data);
        break;
      case "São Vicente":
        response = await http.put(
            Uri.parse(getUserSaoVicente + id.toString() + "?" + keySaoVicente),
            headers: headers,
            body: data);
        break;
      case "São Nicolau":
        response = await http.put(
            Uri.parse(getUserSaoNicolau + id.toString() + "?" + keySaoNicolau),
            headers: headers,
            body: data);
        break;
      case "Boa Vista":
        response = await http.put(
            Uri.parse(getUserBoaVista + id.toString() + "?" + keyBoaVista),
            headers: headers,
            body: data);
        break;
      case "Sal":
        response = await http.put(
            Uri.parse(getUserSal + id.toString() + "?" + keySal),
            headers: headers,
            body: data);
        break;
      case "Maio":
        response = await http.put(
            Uri.parse(getUserMaio + id.toString() + "?" + keyMaio),
            headers: headers,
            body: data);
        break;
      case "Santiago":
        response = await http.put(
            Uri.parse(getUserSantiago + id.toString() + "?" + keySantiago),
            headers: headers,
            body: data);
        break;
      case "Fogo":
        response = await http.put(
            Uri.parse(getUserFogo + id.toString() + "?" + keyFogo),
            headers: headers,
            body: data);
        break;
      case "Brava":
        await http.put(Uri.parse(getUserBrava + id.toString() + "?" + keyBrava),
            headers: headers, body: data);
        break;
    }

    /*var u= await http.post(Uri.parse(request_login_Santiago),
        body: {'username':  authenticationController.user.value.username, 'password':  authenticationController.user.value.senha});
   var body=jsonDecode(u.body);
   var id=body['ID'].toString();*/

    if (response.statusCode == 200) {
      await GetUser();
      return true;
    } else if (response.statusCode == 503) {
      print("Erro de serviço");
      return false;
    } else {
      print("Erro de authentiction");
      return false;
    }
  }

  //SET PASSWORD
  Future resetPasswordCurrent(email) async {
    var island = fullControllerController.island.value;

    var response;
    switch (island) {
      case "Santo Antão":
        response = await http.post(Uri.parse(urlSantoAntao + resetPassword),
            body: {'email': email.toString()});
        break;
      case "São Vicente":
        response = await http.post(Uri.parse(urlSaoVicente + resetPassword),
            body: {'email': email.toString()});
        break;
      case "São Nicolau":
        response = await http.post(Uri.parse(urlSaoNicolau + resetPassword),
            body: {'email': email.toString()});
        break;
      case "Boa Vista":
        response = await http.post(Uri.parse(urlBoaVista + resetPassword),
            body: {'email': email.toString()});
        break;
      case "Sal":
        response = await http.post(Uri.parse(urlSal + resetPassword),
            body: {'email': email.toString()});
        break;
      case "Maio":
        response = await http.post(Uri.parse(urlMaio + resetPassword),
            body: {'email': email.toString()});
        break;
      case "Santiago":
        response = await http.post(Uri.parse(urlSantiago + resetPassword),
            body: {'email': email.toString()});
        break;
      case "Fogo":
        response = await http.post(Uri.parse(urlFogo + resetPassword),
            body: {'email': email.toString()});
        break;
      case "Brava":
        response = await http.post(Uri.parse(urlBrava + resetPassword),
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
  Future validateCodePassword(email, code) async {
    var island = fullControllerController.island.value;

    var response;
    switch (island) {
      case "Santo Antão":
        response = await http.post(Uri.parse(urlSantoAntao + validateCode),
            body: {'email': email.toString(), 'code': code.toString()});
        break;
      case "São Vicente":
        response = await http.post(Uri.parse(urlSaoVicente + validateCode),
            body: {'email': email.toString(), 'code': code.toString()});
        break;
      case "São Nicolau":
        response = await http.post(Uri.parse(urlSaoNicolau + validateCode),
            body: {'email': email.toString(), 'code': code.toString()});
        break;
      case "Boa Vista":
        response = await http.post(Uri.parse(urlBoaVista + validateCode),
            body: {'email': email.toString(), 'code': code.toString()});
        break;
      case "Sal":
        response = await http.post(Uri.parse(urlSal + validateCode),
            body: {'email': email.toString(), 'code': code.toString()});
        break;
      case "Maio":
        response = await http.post(Uri.parse(urlMaio + validateCode),
            body: {'email': email.toString(), 'code': code.toString()});
        break;
      case "Santiago":
        response = await http.post(Uri.parse(urlSantiago + validateCode),
            body: {'email': email.toString(), 'code': code.toString()});
        break;
      case "Fogo":
        response = await http.post(Uri.parse(urlFogo + validateCode),
            body: {'email': email.toString(), 'code': code.toString()});
        break;
      case "Brava":
        response = await http.post(Uri.parse(urlBrava + validateCode),
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

  Future setPassword(email, code, password) async {
    var island = fullControllerController.island.value;

    var response;
    switch (island) {
      case "Santo Antão":
        response =
            await http.post(Uri.parse(urlSantoAntao + setPasswordUrl), body: {
          'email': email.toString(),
          'code': code.toString(),
          'password': password.toString()
        });
        break;
      case "São Vicente":
        response =
            await http.post(Uri.parse(urlSaoVicente + setPasswordUrl), body: {
          'email': email.toString(),
          'code': code.toString(),
          'password': password.toString()
        });
        break;
      case "São Nicolau":
        response =
            await http.post(Uri.parse(urlSaoNicolau + setPasswordUrl), body: {
          'email': email.toString(),
          'code': code.toString(),
          'password': password.toString()
        });
        break;
      case "Boa Vista":
        response =
            await http.post(Uri.parse(urlBoaVista + setPasswordUrl), body: {
          'email': email.toString(),
          'code': code.toString(),
          'password': password.toString()
        });
        break;
      case "Sal":
        response = await http.post(Uri.parse(urlSal + setPasswordUrl), body: {
          'email': email.toString(),
          'code': code.toString(),
          'password': password.toString()
        });
        break;
      case "Maio":
        response = await http.post(Uri.parse(urlMaio + setPasswordUrl), body: {
          'email': email.toString(),
          'code': code.toString(),
          'password': password.toString()
        });
        break;
      case "Santiago":
        response =
            await http.post(Uri.parse(urlSantiago + setPasswordUrl), body: {
          'email': email.toString(),
          'code': code.toString(),
          'password': password.toString()
        });
        break;
      case "Fogo":
        response = await http.post(Uri.parse(urlFogo + setPasswordUrl), body: {
          'email': email.toString(),
          'code': code.toString(),
          'password': password.toString()
        });
        break;
      case "Brava":
        response = await http.post(Uri.parse(urlBrava + setPasswordUrl), body: {
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
