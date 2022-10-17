import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import 'package:manda_bai/Model/filter.dart';
import 'package:manda_bai/service/app_data_services.dart';
import 'package:store_redirect/store_redirect.dart';
import 'package:url_launcher/url_launcher.dart';

class FullController extends GetxController {
  static FullController instance = Get.find();
  final _ilha = ''.obs;
  final _listFilter = <Filter>[].obs;
  final String _versionCollection = "version";

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

  Future carregarFilter() async {
    if (_listFilter.isEmpty) {
      _listFilter.add(Filter(
          image:
              "https://www.mandabai.com/wp-content/uploads/2022/02/filterHomeApp.png",
          name: "Todos"));
      _listFilter.add(Filter(
          image:
              "https://www.mandabai.com/wp-content/uploads/2022/02/filterAlimentoApp-1.png",
          name: "Alimentos"));
      _listFilter.add(Filter(
          image:
              "https://www.mandabai.com/wp-content/uploads/2022/02/filterBebidaApp.png",
          name: "Bebidas"));
      _listFilter.add(Filter(
          image:
              "https://www.mandabai.com/wp-content/uploads/2022/02/filterAlimentosApp.png",
          name: "Legumes e Verduras"));
      _listFilter.add(Filter(
          image:
              "https://www.mandabai.com/wp-content/uploads/2022/02/filterFrutasApp-1.png",
          name: "Frutas"));
      _listFilter.add(Filter(
          image:
              "https://www.mandabai.com/wp-content/uploads/2022/02/filterPeixesApp.png",
          name: "Carnes e Peixes"));
      _listFilter.add(Filter(
          image:
              "https://www.mandabai.com/wp-content/uploads/2022/02/filtroHigieneApp.png",
          name: "Higiene"));
      _listFilter.add(Filter(
          image:
              "https://www.mandabai.com/wp-content/uploads/2022/02/filterBolos_App-1.png",
          name: "Bolos"));
      _listFilter.add(Filter(
          image:
              "https://www.mandabai.com/wp-content/uploads/2022/02/filterCasa_App.png",
          name: "Casa"));
      _listFilter.add(Filter(
          image:
              "https://www.mandabai.com/wp-content/uploads/2022/02/filterEletronicosApp.png",
          name: "Eletrônicos"));
      if (_listFilter.isEmpty) {
        return null;
      }
    }
    return _listFilter;
  }

  getVersion() async {
    return AppDataServices().getGeoDataVersion();
  }


  sendStore() async {
    print("object");
    StoreRedirect.redirect(
      androidAppId: "com.mandabai",
      iOSAppId: "com.mandabai",
    );
  }

}
