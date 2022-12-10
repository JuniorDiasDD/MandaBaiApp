import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:manda_bai/Core/app_colors.dart';
import 'package:manda_bai/Core/app_images.dart';
import 'package:manda_bai/UI/home/components/item_category.dart';
import 'package:manda_bai/UI/widget/dialog_custom.dart';
import 'package:manda_bai/UI/widget/Empty.dart';
import 'package:manda_bai/constants/controllers.dart';
import 'package:websafe_svg/websafe_svg.dart';
import '../../home/pop_up/popup_message_internet.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CategoriesMenu extends StatefulWidget {
  const CategoriesMenu({Key? key}) : super(key: key);

  @override
  State<CategoriesMenu> createState() => _CategoriesMenuState();
}

class _CategoriesMenuState extends State<CategoriesMenu> {
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
      //  print(_connectionStatus.toString());
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
    initConnectivity();
    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
    super.initState();
  }

  @override
  void dispose() {
    _connectivitySubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 8.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      AppLocalizations.of(context)!.all_categories,
                      style: Theme.of(context).textTheme.headline3,
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
                Padding(
                  padding: EdgeInsets.only(
                      left: Get.width * 0.03,
                      right: Get.width * 0.03,
                      top: 8,
                      bottom: 8),
                  child: TextField(
                    cursorColor: AppColors.greenColor,
                    controller: categoryController.pesquisa,
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
                            color: AppColors.black_claro.withOpacity(0.4),
                            width: 0.0),
                      ),
                    ),
                    onChanged: (text) {
                    //  categoryController.search();
                    },
                  ),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    AppLocalizations.of(context)!.best_product,
                    style: Theme.of(context).textTheme.headline3,
                  ),
                ),
                FutureBuilder(
                  future: categoryController.carregarCategory(),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    switch (snapshot.connectionState) {
                      case ConnectionState.waiting:
                        return SizedBox(
                          height: Get.height * 0.2,
                          width: Get.width,
                          child: Center(
                            child: SizedBox(
                                width: 32,
                                height: 32,
                                child: CircularProgressIndicator(
                                  color: Theme.of(context).primaryColor,
                                  strokeWidth: 2,
                                )),
                          ),
                        );
                      default:
                        if (categoryController.listCategory.isEmpty) {
                          return const Empty();
                        } else {
                          return SizedBox(
                            height: Get.height * 0.8,
                            child: Obx(
                              () => ListView.builder(
                                padding: EdgeInsets.only(
                                  top: 0.0,
                                  bottom: Get.height * 0.03,
                                ),
                                scrollDirection: Axis.vertical,
                                itemCount:
                                    categoryController.listCategory.length,
                                itemBuilder: (BuildContext context, index) {
                                  var list =
                                      categoryController.listCategory[index];
                                  return ListViewItemComponent(category: list);
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
      ),
    );
  }
}
