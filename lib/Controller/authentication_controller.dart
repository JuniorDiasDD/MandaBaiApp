import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:manda_bai/Controller/static_config.dart';
import 'package:manda_bai/Model/user.dart';
import 'package:manda_bai/constants/controllers.dart';
import 'package:manda_bai/constants/form_validation.dart';
import 'package:manda_bai/helpers/result.dart';
import 'package:manda_bai/service/user_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AuthenticationController extends GetxController {
  static AuthenticationController instance = Get.find();

  UserService userService = UserService();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final GlobalKey<FormState> formKeyEditPassword = GlobalKey<FormState>();
  final input_email = TextEditingController();
  final input_telefone = TextEditingController();
  final input_nickname = TextEditingController();
  final input_username = TextEditingController();
  final input_senha = TextEditingController();
  final input_senhaCurrent = TextEditingController();
  final input_senhaConf = TextEditingController();
  final input_nome = TextEditingController();
  final input_city = TextEditingController();
  final input_country = TextEditingController();

  final GlobalKey<FormState> formKeyLogin = GlobalKey<FormState>();
  final input_usernameLogin = TextEditingController();
  final input_senhaLogin = TextEditingController();
  final loading = false.obs;
  final statePassword = true.obs;
  final statePasswordLogin = true.obs;

  Future<SetResult> validateAndSave(BuildContext context) async {
    final FormState? form = formKey.currentState;
    if (form!.validate()) {
      if (authenticationController.input_senha.text.length < 7) {
        return SetResult(false,
            errorMessage: AppLocalizations.of(context)!.message_password_weak);
      } else if (RegExp(r'\d+\w*\d+')
              .hasMatch(authenticationController.input_senha.text) &&
          !authenticationController.input_senha.text
              .contains(RegExp(r'[A-Z]'))) {
        return SetResult(false,
            errorMessage:
                AppLocalizations.of(context)!.message_password_reasonable);
      } else if (authenticationController.input_senha.text
          .contains(RegExp(r'[A-Z]'))) {
        return SetResult(false,
            errorMessage:
                AppLocalizations.of(context)!.message_password_strong);
      }

      var email = input_email.text.trim();
      if (!validateEmail(email)) {
        return SetResult(false, errorMessage: "Email invalido.");
      }

      var firstName=input_nome.text;
      if (firstName.contains(RegExp(noSpecialCharactersRegex)) || firstName.contains(RegExp(noNumberCharactersStrictRegex))) {
        return SetResult(false,
            errorMessage: "O Nome não pode ter carateres especiais e nem Numeros");
      }

      var nickname=input_nickname.text;
      if (nickname.contains(RegExp(noSpecialCharactersRegex)) || nickname.contains(RegExp(noNumberCharactersStrictRegex))) {
        return SetResult(false,
            errorMessage: "O Apelido não pode ter carateres especiais e nem Numeros");
      }

      var city=input_city.text;
      if (city.contains(RegExp(noSpecialCharactersRegex)) || city.contains(RegExp(noNumberCharactersStrictRegex))) {
        return SetResult(false,
            errorMessage: "A cidade não pode ter carateres especiais e nem Numeros");
      }

      var country=input_country.text;
      if (country.contains(RegExp(noSpecialCharactersRegex)) || country.contains(RegExp(noNumberCharactersStrictRegex))) {
        return SetResult(false,
            errorMessage: "O Pais não pode ter carateres especiais e nem Numeros");
      }

      User newUser = User(
          name:firstName ,
          telefone: input_telefone.text,
          email: email,
          senha: input_senha.text,
          username: input_username.text,
          nickname:nickname ,
          avatar: "",
          city: city,
          country: country);

      var result = await userService.createAccount(newUser);
      if (result) {
        return SetResult(true);
      }
      return SetResult(false, errorMessage: 'Nao foi possivel registar');
    } else {
      return SetResult(false,
          errorMessage: AppLocalizations.of(context)!.validator_empty_field);
    }
  }

  Future<SetResult> validateAndSaveLogin(BuildContext context) async {
    final FormState? form = formKeyLogin.currentState;
    if (form!.validate()) {
      String username = input_usernameLogin.text;
      String password = input_senhaLogin.text;
      var result = await userService.login(username, password);
      if (!result) {
        return SetResult(false,
            errorMessage:
                AppLocalizations.of(context)!.message_error_cridencials);
      }
      return SetResult(true);
    } else {
      return SetResult(false,
          errorMessage: AppLocalizations.of(context)!.validator_empty_field);
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
      user = User();
      cartPageController.listCart.clear();
      favoriteController.list_product.clear();

      return SetResult(true);
    }
    return SetResult(false, errorMessage: 'Error to logout');
  }

  Future<SetResult> validateEditProfile(BuildContext context) async {
    final FormState? form = formKey.currentState;
    if (form!.validate()) {
      var email = input_email.text.trim();
      if (!validateEmail(email)) {
        return SetResult(false, errorMessage: "Email invalido.");
      }

      var firstName=input_nome.text;
      if (firstName.contains(RegExp(noSpecialCharactersRegex)) || firstName.contains(RegExp(noNumberCharactersStrictRegex))) {
        return SetResult(false,
            errorMessage: "O Nome não pode ter carateres especiais e nem Numeros");
      }

      var nickname=input_nickname.text;
      if (nickname.contains(RegExp(noSpecialCharactersRegex)) || nickname.contains(RegExp(noNumberCharactersStrictRegex))) {
        return SetResult(false,
            errorMessage: "O Apelido não pode ter carateres especiais e nem Numeros");
      }

      var city=input_city.text;
      if (city.contains(RegExp(noSpecialCharactersRegex)) || city.contains(RegExp(noNumberCharactersStrictRegex))) {
        return SetResult(false,
            errorMessage: "A cidade não pode ter carateres especiais e nem Numeros");
      }

      var country=input_country.text;
      if (country.contains(RegExp(noSpecialCharactersRegex)) || country.contains(RegExp(noNumberCharactersStrictRegex))) {
        return SetResult(false,
            errorMessage: "O Pais não pode ter carateres especiais e nem Numeros");
      }
      user.name = firstName;
      user.email = email;
      user.nickname = nickname;
      user.telefone = input_telefone.text.trim();
      user.city = city;
      user.country = country;

      var check = await userService.updateAccount();
      if(check){
        return SetResult(true);
      }

      return SetResult(false, errorMessage:AppLocalizations.of(context)!.message_update_failed);
    } else {
      return SetResult(false,
          errorMessage: AppLocalizations.of(context)!.validator_empty_field);
    }
  }

  Future<SetResult> validateEditPassword(BuildContext context) async {
    final FormState? form = formKeyEditPassword.currentState;
    if (form!.validate()) {
      var password = input_senha.text.trimLeft().trimRight();
      var passwordCurrent = input_senhaCurrent.text.trimLeft().trimRight();
      var passwordConf = input_senhaConf.text.trimLeft().trimRight();
      if (authenticationController.input_senhaCurrent.text.length < 7) {
        return SetResult(false,
            errorMessage: AppLocalizations.of(context)!.message_password_weak);
      } else if (RegExp(r'\d+\w*\d+')
              .hasMatch(authenticationController.input_senhaCurrent.text) &&
          !authenticationController.input_senhaCurrent.text
              .contains(RegExp(r'[A-Z]'))) {
        return SetResult(false,
            errorMessage:
                AppLocalizations.of(context)!.message_password_reasonable);
      } else if (authenticationController.input_senhaCurrent.text
          .contains(RegExp(r'[A-Z]'))) {
        return SetResult(false,
            errorMessage:
                AppLocalizations.of(context)!.message_password_strong);
      }
      if (passwordConf != password) {
        return SetResult(false,
            errorMessage: AppLocalizations.of(context)!.message_error_text);
      }

      return SetResult(true);
    } else {
      return SetResult(false,
          errorMessage: AppLocalizations.of(context)!.validator_empty_field);
    }
  }

  clearInputsChangePassword() {
    input_senhaConf.clear();
    input_senhaCurrent.clear();
    input_senha.clear();
  }


}
