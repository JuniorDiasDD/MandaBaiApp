
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
      _listFilter.add(Filter(image:"https://png.pngtree.com/png-vector/20210117/ourmid/pngtree-online-shopping-3d-phone-store-png-element-png-image_2762266.jpg" ,name: "Todos"));
      _listFilter.add(Filter(image:"https://cdn-icons-png.flaticon.com/512/1205/1205768.png",name:"Alimentos"));
      _listFilter.add(Filter(image:"https://imagensemoldes.com.br/wp-content/uploads/2020/07/%C3%8Dcone-Refrigerante-PNG.png" ,name: "Bebidas"));
      _listFilter.add(Filter(image:"https://img2.freepng.es/20180313/dde/kisspng-vegetable-fruit-healthy-diet-dicing-3d-creative-fruit-hand-painted-icons-5aa892b1e07d17.3796389315209970419195.jpg" ,name: "Legumes e Verduras"));
      _listFilter.add(Filter(image:"https://spng.subpng.com/20180717/fi/kisspng-juice-vegetable-fruit-food-fruit-and-vegetable-dishes-5b4d9e191563a7.3401624615318134010876.jpg" ,name: "Frutas"));
      _listFilter.add(Filter(image:"https://w7.pngwing.com/pngs/86/721/png-transparent-fish-and-seafood-products-in-kind-clam-sashimi-product-kind-seafood-fish-thumbnail.png" ,name: "Carnes e Peixes"));
      _listFilter.add(Filter(image:"https://cdn-icons-png.flaticon.com/512/3364/3364899.png" ,name: "Higiene"));
      _listFilter.add(Filter(image:"https://w7.pngwing.com/pngs/1014/732/png-transparent-cream-birthday-cake-cheesecake-mousse-white-lace-cake-holder-3d-computer-graphics-food-black-white-thumbnail.png" ,name: "Bolos"));
      _listFilter.add(Filter(image:"https://banner2.cleanpng.com/20180219/eoq/kisspng-house-3d-computer-graphics-building-3d-modeling-3d-house-5a8b9ed0129cb7.1873072015190996000762.jpg" ,name: "Casa"));
      _listFilter.add(Filter(image:"https://3dwarehouse.sketchup.com/warehouse/v1.0/publiccontent/963ed33e-dead-4f73-86ad-0f2d60fd7935" ,name: "Eletrônicos"));
      if (_listFilter.isEmpty) {
        return null;
      }

    }

    return _listFilter;
  }


}
