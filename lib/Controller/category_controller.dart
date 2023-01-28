import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:manda_bai/Controller/request.dart';
import 'package:manda_bai/Model/favorite.dart';
import 'package:manda_bai/Model/filter.dart';
import 'package:manda_bai/constants/controllers.dart';
import 'package:manda_bai/service/category_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Model/category.dart';

class CategoryController extends GetxController {
  static CategoryController instance = Get.find();
  CategoryService categoryService = CategoryService();
  final _listFilter = <Filter>[].obs;
  final _listCategory = <Category>[].obs;
  final _listCategoryFull = <Category>[].obs;
  final countCategory = 0.obs;
  var categorySelect = Category();

  TextEditingController pesquisa = TextEditingController();

  List<Category> get listCategoryFull {
    return _listCategoryFull;
  }

  set listCategoryFull(List<Category> list) {
    _listCategoryFull.value = list;
  }

  List<Category> get listCategory {
    return _listCategory;
  }

  set listCategory(List<Category> list) {
    _listCategory.value = list;
  }

  List<Filter> get listFilter {
    return _listFilter;
  }

  set listFilter(List<Filter> list) {
    _listFilter.value = list;
  }

  Future carregarFilter() async {
    _listFilter.clear();
    if (listCategory.isEmpty) {
      listCategory = await categoryService.loadCategory();
      if (listCategory.isNotEmpty) {
        listCategoryFull = listCategory;
      }
    }
    if (_listFilter.isEmpty) {

      for (var e in listCategory) {

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
      }

      if (_listFilter.isEmpty) {
        return null;
      }
    }
    return _listFilter;
  }

  Future carregarProductByIdCategory() async {
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

  var destaqueCurrent = ''.obs;

  Future carregarProductByHome() async {
    await mandaBaiController.loadDestaque();
    if (productController.listProductHome.isEmpty ||
        destaqueCurrent != mandaBaiController.destaque) {
      destaqueCurrent = mandaBaiController.destaque;
      if (listCategoryFull.isEmpty) {
        await carregarCategory();
      }
      for (var element in listCategory) {

        if (element.name == mandaBaiController.destaque.value) {
          categorySelect = element;
        }
      }



      productController.listProductHome.value =
          await ServiceRequest.loadProduct(categorySelect.id);

      if (productController.listProductHome.isEmpty) {
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
            if (productController.listProductFavorite.isNotEmpty){
              for (int i = 0; i <
                  productController.listProductHome.length; i++) {
                for (int f = 0;
                f < productController.listProductFavorite.length;
                f++) {
                  if (productController.listProductHome[i].id ==
                      productController.listProductFavorite[f].id &&
                      productController.listProductFavorite[f].username ==
                          itemUsernameString &&
                      productController.listProductFavorite[f].island ==
                          fullControllerController.island.value) {

                    productController.listProductHome[i].favorite = true;
                  } else {
                    productController.listProductHome[i].favorite = false;
                  }
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
          for (int m = 0; m < productController.listProductHome.length; m++) {
            switch (fullControllerController.initialMoney.value) {
              case 'USD':
                {
                  if (value != false) {
                    double dolar = double.parse(value);
                    productController.listProductHome[m].price =
                        productController.listProductHome[m].price / dolar;
                  }
                  break;
                }
              case 'ECV':
                {
                  productController.listProductHome[m].price =
                      productController.listProductHome[m].price * 110.87;
                  break;
                }
            }
          }
        }
      }
    }
    return productController.listProductHome;
  }

  Future carregarCategory() async {
    if (listCategoryFull.isEmpty && pesquisa.text.isEmpty) {
      listCategoryFull = await categoryService.loadCategory();
      if (listCategoryFull.isEmpty) {
        return null;
      }
      listCategory.clear();
      listCategory.addAll(listCategoryFull);
    }
    return listCategory;
  }

  search() {
    listCategory.clear();
    if (pesquisa.text.isEmpty) {
      listCategory.addAll(listCategoryFull);
    } else {
      for (int i = 0; i < listCategoryFull.length; i++) {
        if (listCategoryFull[i]
            .name!
            .toLowerCase()
            .contains(pesquisa.text.toLowerCase())) {
          listCategory.add(listCategoryFull[i]);
        }
      }
    }
  }
}
