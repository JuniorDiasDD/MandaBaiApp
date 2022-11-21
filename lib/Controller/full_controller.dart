import 'dart:convert';

import 'package:get/get.dart';
import 'package:manda_bai/Controller/static_config.dart';
import 'package:manda_bai/Model/filter.dart';
import 'package:manda_bai/service/app_data_services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:store_redirect/store_redirect.dart';


class FullController extends GetxController {
  static FullController instance = Get.find();
  final _ilha = ''.obs;
  final _listFilter = <Filter>[].obs;
  final String _versionCollection = "version";
  final symbolMoney=''.obs;
  final initialMoney=''.obs;

  List<Filter> get listFilter {
    return _listFilter.value;
  }

  set listFilter(List<Filter> list) {
    this._listFilter.value = list;
  }

  String get ilha {
    return _ilha.value;
  }

  set ilha(String ilha) {
    this._ilha.value = ilha;
  }


  getVersion() async {
    return AppDataServices().getGeoDataVersion();
  }

  getSymbolMoney() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    initialMoney.value = prefs.getString('money')!;
    if (initialMoney.isEmpty || symbolMoney.value== "null") {
      await prefs.setString('money', "EUR");
      initialMoney.value='EUR';
    }

    switch(initialMoney.value){
      case 'EUR':{
        symbolMoney.value='€';
        break;
      }
      case 'ESC':{
        symbolMoney.value='\$';
        break;
      }
      case 'USD':{
        symbolMoney.value='\$';
        break;
      }
    }

  }


  validateLanguage() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var language = prefs.getString('language');

    if (language == "null" || language == null) {
      await prefs.setString('language', "pt");
    }
  }

  getUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    var username = prefs.getString('username');
    var password = prefs.getString('password');

    if (password != null && username != null) {
      final String? userString = prefs.getString('user');
      var userCache = json.decode(userString!);

      user.username = username.toString();
      user.senha = password.toString();
      user.name = userCache["name"];
      user.email = userCache["email"];
      user.nickname = userCache["nickname"];
      user.avatar = userCache["avatar"];
      user.telefone = userCache["telefone"];
      user.city = userCache["city"];
      user.country = userCache["country"];
    }
  }

  getInit()async{
    await getSymbolMoney();
    await validateLanguage();
    await getUser();
  }
  sendStore() async {
    print("object");
    StoreRedirect.redirect(
      androidAppId: "com.mandabai",
      iOSAppId: "com.mandabai",
    );
  }

}
