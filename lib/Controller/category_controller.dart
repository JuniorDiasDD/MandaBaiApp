import 'package:get/get.dart';
import 'package:manda_bai/Controller/request.dart';
import 'package:manda_bai/Model/favorite.dart';
import 'package:manda_bai/Model/filter.dart';
import 'package:manda_bai/constants/controllers.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Model/category.dart';

class CategoryController extends GetxController {
  static CategoryController instance = Get.find();

  final _listFilter = <Filter>[].obs;
  final listCategory = <Category>[].obs;
  final countCategory = 0.obs;
  var categorySelect = Category();

  List<Filter> get listFilter {
    return _listFilter.value;
  }

  set listFilter(List<Filter> list) {
    this._listFilter.value = list;
  }

  Future carregarFilter() async {
    if(listCategory.isEmpty) {
      listCategory.value = await ServiceRequest.loadCategory();
    }
    if (_listFilter.isEmpty) {
      /*_listFilter.add(Filter(
          image:
              "https://www.mandabai.com/wp-content/uploads/2022/02/filterHomeApp.png",
          name: "Todos"));*/
      listCategory.forEach((e) {
        switch (e.name) {
          case 'Alimentos':
            {
              _listFilter.add(Filter(
                  image:
                      "https://www.mandabai.com/wp-content/uploads/2022/02/filterAlimentoApp-1.png",
                  name: "Alimentos",
                  category: e));
              break;
            }
          case 'Bebidas':
            {
              _listFilter.add(Filter(
                  image:
                      "https://www.mandabai.com/wp-content/uploads/2022/02/filterBebidaApp.png",
                  name: "Bebidas",
                  category: e));
              break;
            }
          case 'Legumes e Verduras':
            {
              _listFilter.add(Filter(
                  image:
                      "https://www.mandabai.com/wp-content/uploads/2022/02/filterAlimentosApp.png",
                  name: "Legumes",
                  category: e));
              break;
            }
          case 'Frutas':
            {
              _listFilter.add(Filter(
                  image:
                      "https://www.mandabai.com/wp-content/uploads/2022/02/filterFrutasApp-1.png",
                  name: "Frutas",
                  category: e));
              break;
            }
          case 'Higiene':
            {
              _listFilter.add(Filter(
                  image:
                      "https://www.mandabai.com/wp-content/uploads/2022/02/filtroHigieneApp.png",
                  name: "Higiene",
                  category: e));
              break;
            }
          case 'Bolos':
            {
              _listFilter.add(Filter(
                  image:
                      "https://www.mandabai.com/wp-content/uploads/2022/02/filterBolos_App-1.png",
                  name: "Bolos",
                  category: e));
              break;
            }
          case 'Casa':
            {
              _listFilter.add(Filter(
                  image:
                      "https://www.mandabai.com/wp-content/uploads/2022/02/filterCasa_App.png",
                  name: "Casa",
                  category: e));
              break;
            }
          case 'Eletrônicos':
            {
              _listFilter.add(Filter(
                  image:
                      "https://www.mandabai.com/wp-content/uploads/2022/02/filterEletronicosApp.png",
                  name: "Eletrônicos",
                  category: e));
              break;
            }
        }
      });

      /* _listFilter.add(Filter(
          image:
              "https://www.mandabai.com/wp-content/uploads/2022/02/filterPeixesApp.png",
          name: "Carnes e Peixes"));*/

      if (_listFilter.isEmpty) {
        return null;
      }
    }
    return _listFilter;
  }

  Future carregarProductByIdCategory() async {
    //  if (controller.statusLoadProdutoPage == "init" && pesquisa.text.isEmpty) {
    if (productController.listProduct.isEmpty) {
      productController.listProduct.value =
          await ServiceRequest.loadProduct(categorySelect.id);
      if (productController.listProduct.isEmpty) {
        return null;
      } else {
        final SharedPreferences prefs = await SharedPreferences.getInstance();
        var check = prefs.getString('id');
        if (check != 'null' && check != null) {
          final String? itemFavortiesString =
              prefs.getString('itens_favorites');
          final String? itemUsernameString = prefs.getString('username');
          if (itemFavortiesString != null) {
            productController.listProductFavorite.value =
                Favorite.decode(itemFavortiesString);
            for (int i = 0; i < productController.listProduct.length; i++) {
              for (int f = 0;
                  f < productController.listProductFavorite.length;
                  f++) {
                if (productController.listProduct[i].id ==
                        productController.listProductFavorite[f].id &&
                    productController.listProductFavorite[f].username ==
                        itemUsernameString) {
                  productController.listProduct[i].favorite = true;
                }
              }
            }
          }
        }

        var value;
        if (fullControllerController.initialMoney.value == "USD") {
          value = await ServiceRequest.loadDolar();
        }
        if (fullControllerController.initialMoney.value != "EUR") {
          for (int m = 0; m < productController.listProduct.length; m++) {
            switch (fullControllerController.initialMoney.value) {
              case 'USD':
                {
                  if (value != false) {
                    double dolar = double.parse(value);
                    productController.listProduct[m].price =
                        productController.listProduct[m].price / dolar;
                  }
                  break;
                }
              case 'ECV':
                {
                  productController.listProduct[m].price =
                      productController.listProduct[m].price * 110.87;
                  break;
                }
            }
          }
        }

        /*if (list_product_full.isEmpty) {
            list_product_full = list_product;
          }*/
      }
      //  controller.size_list = loadProdutoTotal;
      //  controller.size_load = list_product.length;
    }
    //  }
    return productController.listProduct;
  }

  Future carregarProductByPresents() async {
    if (listCategory.isEmpty) {
      listCategory.value = await ServiceRequest.loadCategory();
    }
    listCategory.forEach((element) {
      if (element.name == "Presentes") {
        categorySelect = element;
      }
    });

    productController.listProduct.value =
        await ServiceRequest.loadProduct(categorySelect.id);

    if (productController.listProduct.isEmpty) {
      return null;
    } else {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      var check = prefs.getString('id');
      if (check != 'null' && check != null) {
        final String? itemFavortiesString = prefs.getString('itens_favorites');
        final String? itemUsernameString = prefs.getString('username');
        if (itemFavortiesString != null) {
          productController.listProductFavorite.value =
              Favorite.decode(itemFavortiesString);
          for (int i = 0; i < productController.listProduct.length; i++) {
            for (int f = 0;
                f < productController.listProductFavorite.length;
                f++) {
              if (productController.listProduct[i].id ==
                      productController.listProductFavorite[f].id &&
                  productController.listProductFavorite[f].username ==
                      itemUsernameString) {
                productController.listProduct[i].favorite = true;
              }
            }
          }
        }
      }

      var value;
      if (fullControllerController.initialMoney.value == "USD") {
        value = await ServiceRequest.loadDolar();
      }
      if (fullControllerController.initialMoney.value != "EUR") {
        for (int m = 0; m < productController.listProduct.length; m++) {
          switch (fullControllerController.initialMoney.value) {
            case 'USD':
              {
                if (value != false) {
                  double dolar = double.parse(value);
                  productController.listProduct[m].price =
                      productController.listProduct[m].price / dolar;
                }
                break;
              }
            case 'ECV':
              {
                productController.listProduct[m].price =
                    productController.listProduct[m].price * 110.87;
                break;
              }
          }
        }
      }
    }
    return productController.listProduct;
  }

  Future carregarCategory() async {
    listCategory.value = await ServiceRequest.loadCategory();
    if (listCategory.isEmpty) {
      return null;
    }
    return listCategory;
  }
}
