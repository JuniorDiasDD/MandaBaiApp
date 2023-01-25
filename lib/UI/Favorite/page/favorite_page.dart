import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:manda_bai/Core/app_colors.dart';
import 'package:manda_bai/Core/app_images.dart';
import 'package:manda_bai/UI/Favorite/components/listview_item_favorite.dart';
import 'package:manda_bai/UI/widget/dialog_custom.dart';
import 'package:manda_bai/UI/home/pop_up/popup_message_internet.dart';
import 'package:manda_bai/constants/controllers.dart';
import 'package:websafe_svg/websafe_svg.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class FavoritePage extends StatefulWidget {
  const FavoritePage({Key? key}) : super(key: key);

  @override
  _FavoritePageState createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {

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
    favoriteController.loading = false;
    favoriteController.vazio = false;
    favoriteController.list_product = [];
    favoriteController.list_product_full = [];
  }

  @override
  void dispose() {
    _connectivitySubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        return  Future(() => false);
      },
      child: SafeArea(
        child: Scaffold(
          body: Stack(
            children: [
              SizedBox(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: Text(
                                AppLocalizations.of(context)!.label_favorites,
                                style: Theme.of(context).textTheme.headline3,
                              ),
                            ),
                            GestureDetector(
                              onTap: () async {
                                if (!await authenticationController.checkLogin()) {
                                  showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return DialogCustom(textButton: AppLocalizations.of(context)!.button_login,action: (){
                                          Navigator.pushNamed(context, '/login');
                                        },);
                                      });
                                } else {
                                  Navigator.pushNamed(context, '/cart');
                                }
                              },
                              child: SizedBox(
                                width: Get.width * 0.13,
                                height: Get.width * 0.13,
                                child: Stack(
                                  children: [
                                    Container(
                                      width: Get.width * 0.1,
                                      height: Get.width * 0.1,
                                      margin: const EdgeInsets.only(top: 8),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(50),
                                        color: AppColors.grey50.withOpacity(0.8),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(6.0),
                                        child: WebsafeSvg.asset(
                                            AppImages.iconMenuCartOutline),
                                      ),
                                    ),
                                    Align(
                                      alignment: Alignment.topRight,
                                      child: Container(
                                        width: 20,
                                        height: 26,
                                        margin: const EdgeInsets.only(right: 2),
                                        decoration: BoxDecoration(
                                          color: Theme.of(context).primaryColor,
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(10)),
                                        ),
                                        child: Obx(
                                              () => Center(
                                            child: cartPageController.listCart.isEmpty
                                                ? Text(
                                              "0",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .subtitle1!
                                                  .copyWith(
                                                  color: AppColors.white),
                                            )
                                                : Text(
                                              cartPageController.listCart.length
                                                  .toString(),
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .subtitle1!
                                                  .copyWith(
                                                  color: AppColors.white),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                       Padding(
                          padding: EdgeInsets.only(
                              left: Get.width * 0.03,
                              right: Get.width * 0.03,
                              bottom: 8),
                          child:
                          TextField(
                            cursorColor: AppColors.greenColor,
                            controller:  favoriteController.pesquisa,
                            style: Theme.of(context).textTheme.headline4,
                            decoration: InputDecoration(
                              hintText: AppLocalizations.of(context)!.search,
                              hintStyle: Theme.of(context).textTheme.headline4,
                              contentPadding: const EdgeInsets.only(top: 8),
                              focusedBorder: const OutlineInputBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(20.0)),
                                  borderSide: BorderSide(color: AppColors.greenColor)),
                              prefixIcon: Icon(
                                Icons.search,
                                color: AppColors.black_claro.withOpacity(0.4),
                              ),
                              filled: true,
                              fillColor: AppColors.grey50.withOpacity(0.5),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(20.0),
                                ),
                                borderSide: BorderSide(
                                    color: AppColors.black_claro.withOpacity(0.4), width: 0.0),
                              ),
                            ),
                            onChanged: (text) => favoriteController.search(),
                          ),
                        ),
                      FutureBuilder(
                        future: favoriteController.carregar(),
                        builder:
                            (BuildContext context, AsyncSnapshot snapshot) {
                          switch (snapshot.connectionState) {
                            case ConnectionState.waiting:
                              return SizedBox(
                                height: Get.height * 0.3,
                                width: Get.width,
                                child: Center(
                                  child: Column(
                                    children: [
                                      Image.network(
                                        AppImages.loading,
                                        width: Get.width * 0.2,
                                        height: Get.height * 0.2,
                                        alignment: Alignment.center,
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        AppLocalizations.of(context)!
                                            .loading_time,
                                        textAlign: TextAlign.center,
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline3,
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            default:
                              if (snapshot.data == null &&
                                  favoriteController.vazio != true) {
                                return SizedBox(
                                  height: Get.height * 0.5,
                                  width: Get.width,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      WebsafeSvg.asset(
                                          AppImages.favoriteEmpyt),
                                      const SizedBox(height: 10),
                                      Text(
                                        AppLocalizations.of(context)!
                                            .text_no_favorite_product,
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline3,
                                      ),
                                    ],
                                  ),
                                );
                              } else {
                                return SizedBox(
                                  height: Get.height * 0.82,
                                  child: Obx(
                                    () => ListView.builder(
                                      padding: EdgeInsets.only(
                                        top: 0.0,
                                        bottom: Get.height * 0.03,
                                      ),
                                      scrollDirection: Axis.vertical,
                                      itemCount: favoriteController.list_product.length,
                                      itemBuilder:
                                          (BuildContext context, index) {
                                        var list =
                                        favoriteController.list_product[index];
                                        return ItemFavoriteComponent(
                                            product: list);
                                      },
                                    ),
                                  ),
                                );
                              }
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),
              Obx(
                () => SizedBox(
                  child: favoriteController.loading
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
              Obx(
                () => SizedBox(
                  child: favoriteController.vazio
                      ? Center(
                          child: SizedBox(
                            height: Get.height * 0.5,
                            width: Get.width,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                WebsafeSvg.asset(AppImages.favoriteEmpyt),
                                SizedBox(height: Get.height * 0.08),
                                Text(
                                  AppLocalizations.of(context)!
                                      .text_no_favorite_product,
                                  style: Theme.of(context).textTheme.headline3,
                                ),
                              ],
                            ),
                          ),
                        )
                      : null,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
