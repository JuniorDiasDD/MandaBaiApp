import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:manda_bai/Controller/request.dart';
import 'package:manda_bai/Controller/static_config.dart';
import 'package:manda_bai/Core/app_colors.dart';
import 'package:manda_bai/Core/app_fonts.dart';
import 'package:manda_bai/Core/app_images.dart';
import 'package:manda_bai/Model/category.dart';
import 'package:manda_bai/Model/favorite.dart';
import 'package:manda_bai/Model/product.dart';
import 'package:manda_bai/UI/category_filter/controller/categoryController.dart';
import 'package:manda_bai/UI/home/components/product_list_component.dart';
import 'package:manda_bai/UI/home/pop_up/popup_message_internet.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CategoryPage extends StatefulWidget {
  Category category;
  String filter_most, filter_less;
  CategoryPage(
      {required this.category,
      required this.filter_most,
      required this.filter_less});

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  final CategoryController controller = Get.put(CategoryController());
  ConnectivityResult _connectionStatus = ConnectivityResult.none;
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;

  int net = 0;

  Future<void> initConnectivity() async {
    late ConnectivityResult result;
    try {
      result = await _connectivity.checkConnectivity();
    } on PlatformException catch (e) {
      print('Couldn\'t check connectivity status' + e.toString());
      return;
    }

    if (!mounted) {
      return Future.value(null);
    }
    return _updateConnectionStatus(result);
  }

  Future<void> _updateConnectionStatus(ConnectivityResult result) async {
    setState(() {
      _connectionStatus = result;
      print(_connectionStatus.toString());
      if (_connectionStatus == ConnectivityResult.none) {
        net = 1;
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return PopupMessageInternet(
                  mensagem: AppLocalizations.of(context)!.message_erro_internet,
                  icon: Icons.signal_wifi_off);
            });
      } else {
        if (net != 0) {
          Navigator.pop(context);
        }
      }
    });
  }

  @override
  void initState() {
    super.initState();
    initConnectivity();

    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
    statusLoadProdutoPage = "init";
    loadProdutoPage = 1;
    controller.loading = false;
    controller.loadingMais = false;
    _controller = ScrollController();
    _controller.addListener(_scrollListener);
    setState(() {
      dropdownValue = widget.filter_less;
      list_filter = [widget.filter_less, widget.filter_most];
    });
  }

  @override
  void dispose() {
    _connectivitySubscription.cancel();
    super.dispose();
  }

  TextEditingController pesquisa = TextEditingController();
  List<Product> list_product = [];
  List<Product> list_product_cont = [];
  List<Product> list_product_full = [];
  List<Favorite> list_favorite = [];
  String dropdownValue = '';
  List<String> list_filter = [];
  static const int crossAxisCount = 2;
  int size_list = 0;
  int size_load = 0;
  double position = 0.0;
  var money = "EUR";
  bool focus = false;
  late ScrollController _controller;
  _scrollListener() async {
    if (_controller.offset >= _controller.position.maxScrollExtent &&
        !_controller.position.outOfRange) {
      if (statusLoadProdutoPage != "close") {
        controller.loadingMais = true;

        statusLoadProdutoPage = "next";

        position = _controller.position.maxScrollExtent;
        await _carregarAtualizar();
      }

      print("reach the bottom");
    }
    if (_controller.offset <= _controller.position.minScrollExtent &&
        !_controller.position.outOfRange) {
      print("reach the top");
    }
  }

  _search() {
    list_product = [];
    setState(() {
      for (int i = 0; i < list_product_full.length; i++) {
        if (list_product_full[i].name.toLowerCase().contains(pesquisa.text.toLowerCase())) {
          list_product.add(list_product_full[i]);
          size_load = list_product.length;
        }
      }
    });
  }

  _ordenar() {
    list_product = [];
    setState(() {
      list_product = list_product_full;
      if (dropdownValue == widget.filter_less) {
        Comparator<Product> pesagemComparator =
            (a, b) => a.price.compareTo(b.price);
        list_product.sort(pesagemComparator);
      } else if (dropdownValue == widget.filter_most) {
        Comparator<Product> pesagemComparator =
            (a, b) => b.price.compareTo(a.price);
        list_product.sort(pesagemComparator);
      }
    });
  }

  Future _carregar() async {
    if (statusLoadProdutoPage == "init" && pesquisa.text.isEmpty) {
      if (list_product.isEmpty) {
        list_product = await ServiceRequest.loadProduct(widget.category.id);
        if (list_product.isEmpty) {
          return null;
        } else {
          final SharedPreferences prefs = await SharedPreferences.getInstance();
          var check = prefs.getString('id');
          if (check != 'null' && check != null) {
            final String? itemFavortiesString =
            prefs.getString('itens_favorites');
            final String? itemUsernameString =
            prefs.getString('username');
            if (itemFavortiesString != null) {
              list_favorite = Favorite.decode(itemFavortiesString);
              for (int i = 0; i < list_product.length; i++) {
                for (int f = 0; f < list_favorite.length; f++) {
                  if (list_product[i].id == list_favorite[f].id && list_favorite[f].username==itemUsernameString) {
                    list_product[i].favorite = true;
                  }
                }
              }
            }
          }
          money = prefs.getString('money')!;
          var value;
          if (money == "USD") {
            value = await ServiceRequest.loadDolar();
          }
          if (money != "EUR") {
            for (int m = 0; m < list_product.length; m++) {
              switch (money) {
                case 'USD':
                  {
                    if (value != false) {
                      double dolar = double.parse(value);
                      list_product[m].price = list_product[m].price / dolar;
                    }
                    break;
                  }
                case 'ECV':
                  {
                    list_product[m].price = list_product[m].price * 110.87;
                    break;
                  }
              }
            }
          }

          if (list_product_full.isEmpty) {
            list_product_full = list_product;
          }
        }
      }
      setState(() {
        size_list = loadProdutoTotal;
        size_load = list_product.length;
      });
    }

    return list_product;
  }

  Future _carregarAtualizar() async {
    if (statusLoadProdutoPage != "init" && statusLoadProdutoPage != "close") {
      list_product_cont = await ServiceRequest.loadProduct(widget.category.id);
      if (list_product_cont.isEmpty) {
        statusLoadProdutoPage = "close";
        return null;
      } else {
        if (!list_favorite.isEmpty) {
          for (int i = 0; i < list_product_cont.length; i++) {
            for (int f = 0; f < list_favorite.length; f++) {
              if (list_product_cont[i].id == list_favorite[f].id) {
                list_product_cont[i].favorite = true;
              }
            }
          }
        }
        var value;
        if (money == "USD") {
          value = await ServiceRequest.loadDolar();
        }
        if (money != "EUR") {
          for (int m = 0; m < list_product_cont.length; m++) {
            switch (money) {
              case 'USD':
                {
                  if (value != false) {
                    double dolar = double.parse(value);
                    list_product_cont[m].price =
                        list_product_cont[m].price / dolar;
                  }
                  break;
                }
              case 'ECV':
                {
                  list_product_cont[m].price =
                      list_product_cont[m].price * 110.87;
                  break;
                }
            }
          }
        }
        if (!list_product_cont.isEmpty) {
          setState(() {
            for (int m = 0; m < list_product_cont.length; m++) {
              list_product.add(list_product_cont[m]);
            }
          });

          list_product_full = list_product;
        }
      }
    }
    setState(() {
      controller.loadingMais = false;
      size_load = list_product.length;
      focus = true;
    });

    return list_product;
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    /*24 is for notification bar on Android*/
    final double itemHeight = (size.height) / 3;
    final double itemWidth = size.width / 2;
    return SafeArea(
      child: Scaffold(
        floatingActionButton: focus
            ? FloatingActionButton.small(
                backgroundColor: Theme.of(context).primaryColor,
                onPressed: () {
                  _controller.animateTo(
                    position,
                    duration: Duration(seconds: 1),
                    curve: Curves.easeIn,
                  );
                  focus = false;
                },
                child: const Icon(
                  Icons.arrow_downward,
                  color: Colors.white,
                ),
              )
            : null,
        body: SingleChildScrollView(
          child: Column(
            children: [

              Stack(
                children: [
                  Column(
                    children: [
                      Container(
                        color: Theme.of(context).primaryColor,
                        child: Row(
                          children: [
                            Align(
                              alignment: Alignment.topLeft,
                              child: IconButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                  //_controller.jumpTo(position);
                                },
                                icon: const Icon(Icons.arrow_back,
                                    color: Colors.white),
                              ),
                            ),
                            const Spacer(),
                            Container(
                              width: Get.width * 0.2,
                              margin: EdgeInsets.only(
                                right: Get.width * 0.04,
                              ),
                              child: DropdownButton(
                                icon: const Icon(
                                  Icons.filter_alt_sharp,
                                  color: Colors.white,
                                  size: 20.09,
                                ),
                                isExpanded: true,
                                elevation: 16,
                                underline: DropdownButtonHideUnderline(
                                    child: Container()),
                                items: list_filter.map((val) {
                                  return DropdownMenuItem(
                                    value: val,
                                    child: Text(val,
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline4),
                                  );
                                }).toList(),
                                //  value: dropdownValue,
                                onChanged: (String? value) {
                                  setState(() {
                                    dropdownValue = value!;
                                    _ordenar();
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(
                            top: Get.height * 0.01, left: Get.width * 0.04),
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            widget.category.name +
                                " (" +
                                size_load.toString() +
                                "/" +
                                size_list.toString() +
                                ")",
                            style: Theme.of(context).textTheme.headline1,
                          ),
                        ),
                      ),
                      FutureBuilder(
                        future: _carregar(),
                        builder: (BuildContext context, AsyncSnapshot snapshot) {
                          switch (snapshot.connectionState) {
                            case ConnectionState.waiting:
                              return SizedBox(
                                height: Get.height * 0.2,
                                width: Get.width,
                                child: Center(
                                  child: Image.network(
                                    AppImages.loading,
                                    width: Get.width * 0.2,
                                    height: Get.height * 0.2,
                                    alignment: Alignment.center,
                                  ),
                                ),
                              );
                            default:
                              if (snapshot.data == null) {
                                return SizedBox(
                                  height: Get.height * 0.4,
                                  width: Get.width,
                                  child: Center(
                                    child: Text(
                                      AppLocalizations.of(context)!
                                          .text_no_product,
                                      style: TextStyle(
                                        fontFamily: AppFonts.poppinsBoldFont,
                                        fontSize: Get.width * 0.035,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ),
                                );
                              } else {
                                return Container(
                                  height: Get.height * 0.85,
                                  margin: EdgeInsets.only(
                                    left: Get.width * 0.05,
                                    right: Get.width * 0.05,
                                  ),
                                  child: GridView.builder(
                                    padding: const EdgeInsets.only(
                                      top: 0.0,
                                    ),
                                    gridDelegate:
                                         SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      crossAxisSpacing: Get.width * 0.05,
                                      mainAxisSpacing: Get.width * 0.02,
                                      mainAxisExtent: Get.width * 0.5,
                                      childAspectRatio: 8.0 / 9.0,
                                    ),
                                    itemCount: list_product.length,
                                    controller: _controller,
                                    itemBuilder: (BuildContext ctx, index) {
                                      var list = list_product[index];
                                      return ProductListComponent(product: list);
                                    },
                                  ),
                                );
                              }
                          }
                        },
                      ),
                    ],
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 5.0),
                      child: SizedBox(
                        width: Get.width * 0.7,
                        height: 40,
                        child: TextField(
                          cursorColor: AppColors.greenColor,
                          controller: pesquisa,
                          style: Theme.of(context).textTheme.headline4,
                          decoration: InputDecoration(
                            focusedBorder: const OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(30.0)),
                                borderSide:
                                    BorderSide(color: AppColors.greenColor)),
                            hintText: AppLocalizations.of(context)!.search,
                            hintStyle: Theme.of(context).textTheme.headline4,
                            contentPadding:
                                const EdgeInsets.only(top: 10, left: 15),
                            suffixIcon: const Icon(
                              Icons.search,
                              color: AppColors.greenColor,
                            ),
                            filled: true,
                            fillColor: Theme.of(context).backgroundColor,
                            border: const OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(30.0),
                              ),
                            ),
                          ),
                          onChanged: (text) {
                            _search();
                          },
                        ),
                      ),
                    ),
                  ),
                  Obx(
                    () => SizedBox(
                      child: controller.loadingMais
                          ? Container(
                              color: Colors.black54,
                              height: Get.height,
                              child: Center(
                                child: Text(
                                    AppLocalizations.of(context)!.load_more,
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline4!
                                        .copyWith(
                                          color: Colors.white,
                                        )),
                              ),
                            )
                          : null,
                    ),
                  ),
                  Obx(
                    () => SizedBox(
                      child: controller.loading
                          ? Container(
                              color: Colors.black54,
                              height: Get.height,
                              child: Center(
                                child: Image.network(
                                  AppImages.loading,
                                  width: Get.width * 0.2,
                                  height: Get.height * 0.2,
                                  alignment: Alignment.center,
                                ),
                              ),
                            )
                          : null,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
