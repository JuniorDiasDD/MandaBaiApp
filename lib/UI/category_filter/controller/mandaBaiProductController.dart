import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:manda_bai/Controller/cart_controller.dart';
import 'package:manda_bai/Controller/static_config.dart';
import 'package:manda_bai/Model/cart_model.dart';
import 'package:manda_bai/Model/favorite.dart';
import 'package:manda_bai/Model/product.dart';
import 'package:manda_bai/constants/controllers.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MandaBaiProductController extends GetxController {

  static MandaBaiProductController instance = Get.find();

  late List<Product> list_product;
  late List<Product> list_product_full;
  late List<CartModel> list_cart;
  late List<Favorite> list_favorite;

  final CartPageController cartPageController = Get.put(CartPageController());
 // var category = Category().obs;
  var filter = ''.obs;
  var text_pesquisa = ''.obs;
  //! Load Products
  Future<List<Product>> loadProduct() async {
    List<Product> list_page = [];
    var response = await http
        .get(Uri.parse(productCategorias + 'category.value.id.toString()'));
    //  print(response.body);
    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      var quantidade = response.headers['x-wp-total'];
      int total_wp = int.parse(quantidade!);
      if (total_wp < 100 || total_wp == 100) {
        final _cats = jsonResponse.cast<Map<String, dynamic>>();
        list_product =
            _cats.map<Product>((cat) => Product.fromJson(cat)).toList();
      } else {
        int cont = 2;
        if (total_wp > 200 && total_wp < 300 || total_wp == 300) {
          cont = 3;
        }
        for (int i = 1; i < cont; i++) {
          response = await http.get(Uri.parse(productCategorias +
              'category.value.id.toString()' +
              "&per_page=100&page=" +
              i.toString()));
          if (response.statusCode == 200) {
            final jsonResponse = json.decode(response.body);
            final _cats = jsonResponse.cast<Map<String, dynamic>>();
            list_page =
                _cats.map<Product>((cat) => Product.fromJson(cat)).toList();
            for (int d = 0; d < list_page.length; d++) {
              list_product.add(list_page[d]);
            }
          } else {
            print("Erro em carregar products da page=" + i.toString());
          }
        }
      }
    } else if (response.statusCode == 503) {
      print("Erro de serviço");
    } else {
      print("Erro de authentiction");
    }

    if (list_product.isNotEmpty) {
      getFavorite();
    }
    return list_product;
  }

  getFavorite() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? itemFavortiesString = prefs.getString('itens_favorites');
    if (itemFavortiesString != null) {
      List<Favorite> list = Favorite.decode(itemFavortiesString);
      for (int i = 0; i < list_product.length; i++) {
        for (int f = 0; f < list.length; f++) {
          if (list_product[i].id == list[f].id) {
            list_product[i].favorite = true;
          }
        }
      }
    }
    if (list_product_full.isEmpty) {
      list_product_full = list_product;
    }
  }

  search() {
    // print("click");
    list_product = [];

    for (int i = 0; i < list_product_full.length; i++) {
      if (list_product_full[i].name.contains(text_pesquisa.value)) {
        list_product.add(list_product_full[i]);
      }
    }
  }

  ordenar() {
    list_product = [];

    list_product = list_product_full;
    if (filter.value == "Menos Preço") {
      Comparator<Product> pesagemComparator =
          (a, b) => a.price.compareTo(b.price);
      list_product.sort(pesagemComparator);
    } else if (filter.value == "Mais Preço") {
      Comparator<Product> pesagemComparator =
          (a, b) => b.price.compareTo(a.price);
      list_product.sort(pesagemComparator);
    }
  }

  //! Cart
  //? getCart
  Future<List<CartModel>> loadCart() async {
    String basicAuth = 'Basic ' +
        base64Encode(utf8.encode( authenticationController.user.value.username! +
            ':' +
             authenticationController.user.value.senha!));
    var response = await http.get(Uri.parse(getCart),
        headers: <String, String>{'authorization': basicAuth});
    print(response.body);

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      final _cats = jsonResponse['items'].cast<Map<String, dynamic>>();
      list_cart =
          _cats.map<CartModel>((cat) => CartModel.fromJson(cat)).toList();
    } else if (response.statusCode == 503) {
      print("Erro de serviço");
    } else {
      print("Erro de authentiction");
    }

    if (!list_cart.isEmpty) {
      cartPageController.list = list_cart;
      cartPageController.calcule();
    }
    return list_cart;
  }

  //! removeItemCart
  Future removeCart(ischeck) async {
    String basicAuth = 'Basic ' +
        base64Encode(utf8.encode( authenticationController.user.value.username! +
            ':' +
             authenticationController.user.value.senha!));

    if (ischeck == true) {
      for (int i = 0; i < cartPageController.list.length; i++) {
        var response = await http.delete(
            Uri.parse(removeItemCart + cartPageController.list[i].item_key),
            headers: <String, String>{'authorization': basicAuth});
        print(response.body);

        if (response.statusCode == 200) {
          final jsonResponse = json.decode(response.body);
          final _cats = jsonResponse['items'].cast<Map<String, dynamic>>();
          list_cart =
              _cats.map<CartModel>((cat) => CartModel.fromJson(cat)).toList();
          cartPageController.list = list_cart;
          cartPageController.calcule();
        } else if (response.statusCode == 503) {
          print("Erro de serviço");
        } else {
          print(
              "Erro em eliminar item " + cartPageController.list[i].item_key);
        }
      }
    } else {
      for (int i = 0; i < cartPageController.list.length; i++) {
        if (cartPageController.list[i].checkout == true) {
          var response = await http.delete(
              Uri.parse(removeItemCart + cartPageController.list[i].item_key),
              headers: <String, String>{'authorization': basicAuth});
          print(response.body);

          if (response.statusCode == 200) {
            final jsonResponse = json.decode(response.body);
            final _cats = jsonResponse['items'].cast<Map<String, dynamic>>();
            list_cart =
                _cats.map<CartModel>((cat) => CartModel.fromJson(cat)).toList();
            cartPageController.list = list_cart;
            cartPageController.calcule();
          } else if (response.statusCode == 503) {
            print("Erro de serviço");
          } else {
            print("Erro em eliminar item " +
                cartPageController.list[i].item_key);
          }
        }
      }
    }
  }

  //! Cart
  //? addCart
  Future addCart(item) async {
    String basicAuth = 'Basic ' +
        base64Encode(utf8.encode( authenticationController.user.value.username! +
            ':' +
             authenticationController.user.value.senha!));
    var response = await http.post(Uri.parse(addItemCart),
        headers: <String, String>{'authorization': basicAuth},
        body: {'id': item.toString(), 'quantity': "1"});
    print(response.body);

    if (response.statusCode == 200) {
      return true;
    } else if (response.statusCode == 503) {
      print("Erro de serviço");
    } else {
      print("Erro de authentiction");
    }
    return false;
  }

  //! Favorite
  //?add favorite
  Future addFavrite(int id) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? itemFavortiesString = prefs.getString('itens_favorites');

    if (itemFavortiesString != null) {
      // decode and store data in SharedPreferences
      list_favorite = Favorite.decode(itemFavortiesString);
      list_favorite
          .add(Favorite(id: id, island: fullControllerController.island.value, username: ''));

      // Encode and store data in SharedPreferences
      final String encodedData = Favorite.encode(list_favorite);

      await prefs.setString('itens_favorites', encodedData);
    } else {
      list_favorite
          .add(Favorite(id: id, island: fullControllerController.island.value, username: ''));
      // Encode and store data in SharedPreferences
      final String encodedData = Favorite.encode(list_favorite);

      await prefs.setString('itens_favorites', encodedData);
    }
  }

  //?remove favorite
  Future removeFavrite(int id) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? itemFavortiesString = prefs.getString('itens_favorites');

    if (itemFavortiesString != null) {
      // decode and store data in SharedPreferences
      list_favorite = Favorite.decode(itemFavortiesString);
      List<Favorite> list_new = [];
      if (list_favorite.length < 2) {
        prefs.remove('itens_favorites');
      } else {
        for (int i = 0; i < list_favorite.length; i++) {
          if (list_favorite[i].id != id) {
            list_new.add(list_favorite[i]);
          }
        }
        // Encode and store data in SharedPreferences
        prefs.remove('itens_favorites');
        final String encodedData = Favorite.encode(list_new);

        await prefs.setString('itens_favorites', encodedData);
      }
    }
  }

  Future<List<Product>> loadFavorite() async {
    list_product = [];
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? itemFavortiesString = prefs.getString('itens_favorites');

    if (itemFavortiesString != null) {
      // decode and store data in SharedPreferences
      list_favorite = Favorite.decode(itemFavortiesString);
      if (text_pesquisa.value == "") {
        for (int i = 0; i < list_favorite.length; i++) {
          if (list_favorite[i].island == fullControllerController.island.value) {
            var response = await http.get(Uri.parse(
                get_Produto + list_favorite[i].id.toString() + "?" + key));
            final jsonResponse = json.decode(response.body);
            //  print(response.body);
            if (response.statusCode == 200) {
              list_product.add(Product(
                  id: jsonResponse['id'],
                  name: jsonResponse['name'].toString(),
                  description: jsonResponse['description'].toString(),
                  price: double.parse(jsonResponse['price']),
                  //rating_count: jsonResponse['rating_count'] ?? 0,
                  sale_price: jsonResponse['sale_price'].toString(),
                  in_stock: jsonResponse['manage_stock'].toString(),
                  on_sale: jsonResponse['on_sale'].toString(),
                  stock_quantity: jsonResponse['stock_quantity'].toString(),
                  image: jsonResponse['images'][0]["src"],
                  favorite: true));
            } else {
              print("Erro em carregar o produto");
            }
          }
        }
      }
    } else {
      return list_product;
    }
    list_product_full = list_product;
    return list_product;
  }
  
}
