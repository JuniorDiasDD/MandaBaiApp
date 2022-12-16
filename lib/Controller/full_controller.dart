import 'dart:convert';

import 'package:get/get.dart';
import 'package:manda_bai/Controller/static_config.dart';
import 'package:manda_bai/Model/filter.dart';
import 'package:manda_bai/constants/controllers.dart';
import 'package:manda_bai/helpers/result.dart';
import 'package:manda_bai/service/app_data_services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:store_redirect/store_redirect.dart';

class FullController extends GetxController {
  static FullController instance = Get.find();
  final _listFilter = <Filter>[].obs;
  final symbolMoney = ''.obs;
  final initialMoney = ''.obs;
  var prefersDarkMode = false.obs;
  var island = "".obs;
  var language = "".obs;

  List<Filter> get listFilter {
    return _listFilter.value;
  }

  set listFilter(List<Filter> list) {
    _listFilter.value = list;
  }

  getVersion() async {
    return AppDataServices().getGeoDataVersion();
  }

  getSymbolMoney() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getString('money') == null) {
      await prefs.setString('money', "EUR");
      initialMoney.value = 'EUR';
    } else {
      initialMoney.value = prefs.getString('money')!;
    }

    switch (initialMoney.value) {
      case 'EUR':
        {
          symbolMoney.value = '€';
          break;
        }
      case 'ESC':
        {
          symbolMoney.value = '\$';
          break;
        }
      case 'USD':
        {
          symbolMoney.value = '\$';
          break;
        }
    }
  }

  validateLanguage() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var languag = prefs.getString('language');

    if (languag == "null" || languag == null) {
      await prefs.setString('language', "pt");
      language.value = 'pt';
    } else {
      language.value = languag;
    }
  }

  validateTheme() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var theme = prefs.getString('theme');

    if (theme == "null" || theme == null) {
      await prefs.setString('theme', "light");
      prefersDarkMode.value = true;
    } else {
      if (theme == 'light') {
        prefersDarkMode.value = true;
      } else {
        prefersDarkMode.value = true;
      }
    }
  }

  validateIsland() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    if (prefs.getString('island') == null) {
      await prefs.setString('island', "Santiago");
      island.value = 'Santiago';
    } else {
      island.value = prefs.getString('island')!;
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
      //  user.avatar = userCache["avatar"];
      user.telefone = userCache["telefone"];
      user.city = userCache["city"];
      user.country = userCache["country"];
    }
  }

  getInit() async {
    await validateTheme();
    await getSymbolMoney();
    await validateLanguage();
    await validateIsland();
    await getUser();
  }

  var ultimoClick = ''.obs;

  getloadDataHome() async {
    if (ultimoClick.value != fullControllerController.island.value) {
      productController.listProductHome.clear();
      categoryController.listCategory.clear();
      await categoryController.carregarProductByHome();
      await mandaBaiController.loadBanner();
      await mandaBaiController.loadBackground();
      ultimoClick.value = fullControllerController.island.value;
    }
  }

  sendStore() async {
    StoreRedirect.redirect(
      androidAppId: "com.mandabai",
      iOSAppId: "com.mandabai",
    );
  }

  //Setting

  var isSelectedMoney = "".obs;

  Future<SetResult> updateMoney() async {
    if (isSelectedMoney == initialMoney) {
      return SetResult(true);
    }
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    var result = await prefs.setString('money', isSelectedMoney.value);
    await getSymbolMoney();
    if (!result) {
      return SetResult(false);
    }

    return SetResult(true);
  }
}
