
import 'package:get/get.dart';
import 'package:manda_bai/Model/filter.dart';

class FullController extends GetxController {

  final _ilha = ''.obs;
  final _listFilter = <Filter>[].obs;

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

      _listFilter.add(Filter(image:"https://www.mandabai.com/wp-content/uploads/2022/02/filterHomeApp.png",name: "Todos"));
      _listFilter.add(Filter(image:"https://www.mandabai.com/wp-content/uploads/2022/02/filterAlimentoApp-1.png",name:"Alimentos"));
      _listFilter.add(Filter(image:"https://www.mandabai.com/wp-content/uploads/2022/02/filterBebidaApp.png" ,name: "Bebidas"));
      _listFilter.add(Filter(image:"https://www.mandabai.com/wp-content/uploads/2022/02/filterAlimentosApp.png" ,name: "Legumes e Verduras"));
      _listFilter.add(Filter(image:"https://www.mandabai.com/wp-content/uploads/2022/02/filterFrutasApp-1.png" ,name: "Frutas"));
      _listFilter.add(Filter(image:"https://www.mandabai.com/wp-content/uploads/2022/02/filterPeixesApp.png" ,name: "Carnes e Peixes"));
      _listFilter.add(Filter(image:"https://www.mandabai.com/wp-content/uploads/2022/02/filtroHigieneApp.png",name: "Higiene"));
      _listFilter.add(Filter(image:"https://www.mandabai.com/wp-content/uploads/2022/02/filterBolos_App-1.png" ,name: "Bolos"));
      _listFilter.add(Filter(image:"https://www.mandabai.com/wp-content/uploads/2022/02/filterCasa_App.png" ,name: "Casa"));
      _listFilter.add(Filter(image:"https://www.mandabai.com/wp-content/uploads/2022/02/filterEletronicosApp.png" ,name: "Eletrônicos"));
      if (_listFilter.isEmpty) {
        return null;
      }
    }
    return _listFilter;
  }


}
