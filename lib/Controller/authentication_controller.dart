import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:manda_bai/Model/user.dart';
import 'package:manda_bai/constants/controllers.dart';
import 'package:manda_bai/constants/form_validation.dart';
import 'package:manda_bai/helpers/result.dart';
import 'package:manda_bai/service/user_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AuthenticationController extends GetxController {

  var errorMessage="".obs;

  static AuthenticationController instance = Get.find();
  var user =  User(
      name: " ",
      nickname: " ",
      telefone: " ",
      senha: "",
      email: "",
      avatar: "",
      username: "",
      city: "",
      country: "").obs;
  UserService userService = UserService();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final GlobalKey<FormState> formKeyEditPassword = GlobalKey<FormState>();
  final GlobalKey<FormState> formKeyValidateCode = GlobalKey<FormState>();
  final resetCode = TextEditingController();
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

  var dropdownValue = '--Selecione a Ilha--'.obs;
  List<String> listIsland = [
    '--Selecione a Ilha--',
    'Santo Antão',
    'São Vicente',
    'São Nicolau',
    'Sal',
    'Boa Vista',
    'Maio',
    'Santiago',
    'Fogo',
    'Brava',
  ];

  Future<SetResult> validateAndSave(BuildContext context) async {
    final FormState? form = formKey.currentState;
    if (form!.validate()) {
      if (authenticationController.input_senha.text.length < 7) {
        return SetResult(false,
            errorMessage: AppLocalizations.of(context)!.message_password_weak);
      } else if (!input_senha.text
          .contains(RegExp(r'[A-Z]'))) {
        return SetResult(false,
            errorMessage:
                AppLocalizations.of(context)!.message_password_strong);
      }

      var email = input_email.text.trim();
      if (!validateEmail(email)) {
        return SetResult(false, errorMessage: "Email invalido.");
      }

      var firstName = input_nome.text;
      if (firstName.contains(RegExp(noSpecialCharactersRegex)) ||
          firstName.contains(RegExp(noNumberCharactersStrictRegex))) {
        return SetResult(false,
            errorMessage:
                "O Nome não pode ter carateres especiais e nem Numeros");
      }

      var nickname = input_nickname.text;
      if (nickname.contains(RegExp(noSpecialCharactersRegex)) ||
          nickname.contains(RegExp(noNumberCharactersStrictRegex))) {
        return SetResult(false,
            errorMessage:
                "O Apelido não pode ter carateres especiais e nem Numeros");
      }

      var city = input_city.text;
      if (city.contains(RegExp(noSpecialCharactersRegex)) ||
          city.contains(RegExp(noNumberCharactersStrictRegex))) {
        return SetResult(false,
            errorMessage:
                "A cidade não pode ter carateres especiais e nem Numeros");
      }

      var country = input_country.text;
      if (country.contains(RegExp(noSpecialCharactersRegex)) ||
          country.contains(RegExp(noNumberCharactersStrictRegex))) {
        return SetResult(false,
            errorMessage:
                "O Pais não pode ter carateres especiais e nem Numeros");
      }
      User newUser = User(
          name: firstName,
          telefone: input_telefone.text,
          email: email,
          senha: input_senha.text,
          username: input_username.text,
          nickname: nickname,
          avatar: "",
          city: city,
          country: country);

      var result =
          await userService.createAccount(newUser);
      if (result) {
        return SetResult(true);
      }
      return SetResult(false, errorMessage: errorMessage.value);
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
      user.value = User();
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

      var firstName = input_nome.text;
      if (firstName.contains(RegExp(noSpecialCharactersRegex)) ||
          firstName.contains(RegExp(noNumberCharactersStrictRegex))) {
        return SetResult(false,
            errorMessage:
                "O Nome não pode ter carateres especiais e nem Numeros");
      }

      var nickname = input_nickname.text;
      if (nickname.contains(RegExp(noSpecialCharactersRegex)) ||
          nickname.contains(RegExp(noNumberCharactersStrictRegex))) {
        return SetResult(false,
            errorMessage:
                "O Apelido não pode ter carateres especiais e nem Numeros");
      }

      var city = input_city.text;
      if (city.contains(RegExp(noSpecialCharactersRegex)) ||
          city.contains(RegExp(noNumberCharactersStrictRegex))) {
        return SetResult(false,
            errorMessage:
                "A cidade não pode ter carateres especiais e nem Numeros");
      }

      var country = input_country.text;
      if (country.contains(RegExp(noSpecialCharactersRegex)) ||
          country.contains(RegExp(noNumberCharactersStrictRegex))) {
        return SetResult(false,
            errorMessage:
                "O Pais não pode ter carateres especiais e nem Numeros");
      }
      user.value.name = firstName;
      user.value.email = email;
      user.value.nickname = nickname;
      user.value.telefone = input_telefone.text.trim();
      user.value.city = city;
      user.value.country = country;

      var check = await userService.updateAccount();
      if (check) {
        return SetResult(true);
      }

      return SetResult(false,
          errorMessage: AppLocalizations.of(context)!.message_update_failed);
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

  clearInputsRegister(){
    input_email.clear();
    input_telefone.clear();
    input_nickname.clear();
    input_username.clear();
    input_senha.clear();
    input_nome.clear();
    input_city.clear();
    input_country.clear();
  }
  clearInputsChange() {
    input_senhaConf.clear();
    input_senhaCurrent.clear();
    input_senha.clear();
    input_email.clear();
    resetCode.clear();
    input_senhaLogin.clear();
    input_usernameLogin.clear();
    input_username.clear();
  }
  clearInputsChangePassword() {
    input_senhaConf.clear();
    input_senhaCurrent.clear();
    input_senha.clear();

  }



  Future<SetResult> sendEmail(BuildContext context) async {
    final FormState? form = formKey.currentState;
    if (form!.validate()) {
      var email = input_email.text.trim();
      if (!validateEmail(email)) {
        return SetResult(false, errorMessage: "Email invalido.");
      }

      var check = await userService.resetPasswordCurrent(email);
      if (!check) {
          return SetResult(false, errorMessage: AppLocalizations.of(context)!.message_erro_email_set_password);
      }
    } else {
      return SetResult(false,
          errorMessage: AppLocalizations.of(context)!.validator_empty_field);
    }
    minuto.value = 5;
    segundo.value = 59;
    startTimer();
    return SetResult(true);
  }

  Future<SetResult> validateCodePassword(BuildContext context) async {
    final FormState? form = formKeyValidateCode.currentState;
    if (form!.validate()) {
      var check = await userService.validateCodePassword(
          input_email.text.trim(), resetCode.text);
      if (!check) {
        return SetResult(false,
            errorMessage:
                AppLocalizations.of(context)!.message_erro_validate_code);
      }
      return SetResult(true);
    } else {
      return SetResult(false,
          errorMessage: AppLocalizations.of(context)!.validator_empty_field);
    }
  }

  Future<SetResult> createNewPassword(BuildContext context) async {
    final FormState? form = formKeyEditPassword.currentState;
    if (form!.validate()) {
      var senha = input_senha.text.trimRight().trimLeft();
      var senhaConf = input_senhaConf.text.trimRight().trimLeft();
      if (senha != senhaConf) {
        return SetResult(false,
            errorMessage: AppLocalizations.of(context)!.message_error_text);
      }
      if (senha.length < 7) {
        return SetResult(false,
            errorMessage: AppLocalizations.of(context)!.message_password_weak);

      } else if (!senha.contains(RegExp(r'[A-Z]'))) {
        return SetResult(false,
            errorMessage:
                AppLocalizations.of(context)!.message_password_strong);
      }

      var check = await userService.setPassword(
          input_email.text.trim(), resetCode.text.trim(), senha);
      if (!check) {
        return SetResult(false,
            errorMessage: AppLocalizations.of(context)!.message_update_failed);
      }

      return SetResult(true);
    } else {
      return SetResult(false,
          errorMessage: AppLocalizations.of(context)!.validator_empty_field);
    }
  }

  late Timer timer;

  var minuto = 5.obs, segundo = 59.obs;
  void startTimer() {
    const oneSec = Duration(seconds: 1);
    timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        if (minuto.value == 0 && segundo.value == 0) {
          timer.cancel();
        } else if (segundo.value == 0) {
          minuto.value--;
          segundo.value = 59;
        } else {
          segundo.value--;
        }
      },
    );
  }

  Future<SetResult> newPassword(BuildContext context) async {

    var check = await userService.resetPasswordCurrent(input_email.text.trim());
    if (check) {
      minuto.value = 5;
      segundo.value = 59;
      startTimer();
      return SetResult(true);
    }
    return SetResult(false,errorMessage:'Erro ao enviar codigo' );
  }
}
