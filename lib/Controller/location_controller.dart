import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:manda_bai/Controller/request.dart';
import 'package:manda_bai/Model/location.dart';
import 'package:manda_bai/constants/controllers.dart';
import 'package:manda_bai/helpers/result.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocationController extends GetxController {
  static LocationController instance = Get.find();

  final checkEditLocation = false.obs;
  var isRadioSelected = ''.obs;
  final listLocation = <Location>[].obs;
  var location = Location().obs;

  Future carregarLocation() async {
    if (listLocation.isEmpty) {
      listLocation.value = await ServiceRequest.loadLocation();
      if (listLocation.isEmpty) {
        return null;
      }
    }
    return listLocation;
  }

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final inputCidade = TextEditingController();
  final inputEndereco = TextEditingController();
  final inputTel = TextEditingController();
  final inputNome = TextEditingController();

  cleanInptus() {
    inputNome.clear();
    inputCidade.clear();
    inputTel.clear();
    inputEndereco.clear();
  }

  Future<SetResult> validateAndSaveLocation() async {
    final FormState? form = formKey.currentState;
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? itemusernameString = prefs.getString('username');
    if (form!.validate()) {
      Location novo = Location(
          id: 1,
          name: inputNome.text,
          city: inputCidade.text,
          endereco: inputEndereco.text,
          island: fullControllerController.island.value,
          phone: inputTel.text,
          email: "",
          username: itemusernameString!);
      if (location.value.id != null) {
        await ServiceRequest.removeLocation(location.value.id!);
      }
      var result = await ServiceRequest.addLocation(novo);

      if (result) {
        listLocation.add(novo);
      }
      return SetResult(true);
    } else {
      return SetResult(false, errorMessage: "Formulário inválido.");
    }
  }
}
