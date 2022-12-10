import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:manda_bai/Controller/request.dart';
import 'package:manda_bai/Controller/static_config.dart';
import 'package:manda_bai/Model/user.dart';
import 'package:manda_bai/constants/controllers.dart';
import 'package:manda_bai/helpers/result.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class AuthenticationController extends GetxController {
  static AuthenticationController instance = Get.find();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final input_email = TextEditingController();
  final input_telefone = TextEditingController();
  final input_nickname = TextEditingController();
  final input_username = TextEditingController();
  final input_senha = TextEditingController();
  final input_nome = TextEditingController();
  final input_city = TextEditingController();
  final input_country = TextEditingController();

  final GlobalKey<FormState> formKeyLogin = GlobalKey<FormState>();
  final input_usernameLogin = TextEditingController();
  final input_senhaLogin = TextEditingController();
  final loading = false.obs;
  final statePassword = true.obs;
  final statePasswordLogin = true.obs;

  Future validateAndSave() async {
    print('entrou validar');
    final FormState? form = formKey.currentState;
    if (form!.validate()) {
      User newUser = User(
          name: input_nome.text,
          telefone: input_telefone.text,
          email: input_email.text,
          senha: input_senha.text,
          username: input_username.text,
          nickname: input_nickname.text,
          avatar: "",
          city: input_city.text,
          country: input_country.text);

      loading.value = true;
      return await ServiceRequest.createAccount(newUser);
    }
    return false;
  }

  Future validateAndSaveLogin() async {
    final FormState? form = formKeyLogin.currentState;
    if (form!.validate()) {
      String username = input_usernameLogin.text;
      String password = input_senhaLogin.text;
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
        //  loginCoCart();
        ServiceRequest.GetUser();
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

  Future<bool> checkLogin() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var check = prefs.getString('id');
    if (check == null || check == 'null') {
      return false;
    }

    return true;
  }

  Future<SetResult> logout() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var check = prefs.getString('id');
    if (check != 'null' || check != null) {
      prefs.remove('id');
      prefs.remove('username');
      prefs.remove('password');
      prefs.remove('user');
      user= User();
      cartPageController.listCart.clear();
      favoriteController.list_product.clear();

      return SetResult(true);
    }
    return SetResult(false, errorMessage: 'Error to logout');
  }
}
