import 'dart:async';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:manda_bai/Core/app_colors.dart';
import 'package:manda_bai/Core/app_images.dart';
import 'package:manda_bai/UI/category_filter/components/product_list_component.dart';
import 'package:manda_bai/UI/category_filter/pages/category_page.dart';
import 'package:manda_bai/UI/home/components/item_filter.dart';
import 'package:manda_bai/UI/widget/ErrorPage.dart';
import 'package:manda_bai/UI/widget/HeaderTitle.dart';
import 'package:manda_bai/UI/widget/PromotionText.dart';
import 'package:manda_bai/UI/widget/dialog_custom.dart';
import 'package:manda_bai/UI/home/pop_up/popup_message_internet.dart';
import 'package:manda_bai/UI/widget/Empty.dart';
import 'package:manda_bai/constants/controllers.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:websafe_svg/websafe_svg.dart';

class StartPage extends StatefulWidget {
  const StartPage({Key? key}) : super(key: key);

  @override
  _StartPageState createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
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
    super.initState();
    initConnectivity();
    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
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
        return Future(() => false);
      },
      child: SafeArea(
        child: Scaffold(
          body: SingleChildScrollView(
            child: Column(
              children: [
                Stack(
                  children: [

                    SizedBox(
                      width: Get.width,
                      height: Get.height * 0.22,
                      child: Obx(
                        ()=> Image.network(
                          mandaBaiController.imageBackground.value,
                          fit: BoxFit.cover,
                          width: Get.width,
                          height: Get.height * 0.2,
                        ),
                      ),
                    ),
                    Column(
                      children: [
                        Padding(
                          padding:
                              const EdgeInsets.only(left: 8.0, right: 8.0),
                          child: Row(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Navigator.pushReplacementNamed(context, '/island');
                                },
                                child: Container(
                                  width: Get.width * 0.1,
                                  height: Get.width * 0.1,
                                  margin: const EdgeInsets.only(top: 8),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(50),
                                    color: AppColors.grey50.withOpacity(0.8),
                                  ),
                                  child: const Padding(
                                    padding: EdgeInsets.all(4.0),
                                    child: Icon(Icons.close,color: Colors.black,),
                                  ),
                                ),
                              ),
                              const Spacer(),
                              GestureDetector(
                                onTap: () async {
                                  if (!await authenticationController
                                      .checkLogin()) {
                                    showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return DialogCustom(
                                            textButton:
                                                AppLocalizations.of(context)!
                                                    .button_login,
                                            action: () {
                                              Navigator.pushNamed(
                                                  context, '/login');
                                            },
                                          );
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
                                          borderRadius:
                                              BorderRadius.circular(50),
                                          color: AppColors.grey50
                                              .withOpacity(0.8),
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
                                          margin:
                                              const EdgeInsets.only(right: 2),
                                          decoration: BoxDecoration(
                                            color: Theme.of(context)
                                                .primaryColor,
                                            borderRadius:
                                                const BorderRadius.all(
                                                    Radius.circular(10)),
                                          ),
                                          child: FutureBuilder(
                                            future: cartPageController
                                                .carregarCart(),
                                            builder: (BuildContext context,
                                                AsyncSnapshot snapshot) {
                                              switch (
                                                  snapshot.connectionState) {
                                                case ConnectionState.waiting:
                                                  return const Padding(
                                                    padding: EdgeInsets.only(
                                                        top: 10.0,
                                                        left: 8,
                                                        right: 8,
                                                        bottom: 10),
                                                    child:
                                                        CircularProgressIndicator(
                                                      color: AppColors.white,
                                                      strokeWidth: 1,
                                                    ),
                                                  );
                                                default:
                                                  if (snapshot.data == null) {
                                                    return Center(
                                                      child: Text(
                                                        "0",
                                                        style: Theme.of(
                                                                context)
                                                            .textTheme
                                                            .subtitle1!
                                                            .copyWith(
                                                                color: AppColors
                                                                    .white),
                                                      ),
                                                    );
                                                  } else {
                                                    return Center(
                                                      child: Obx(
                                                        () => Text(
                                                          cartPageController
                                                              .listCart.length
                                                              .toString(),
                                                          style: Theme.of(
                                                                  context)
                                                              .textTheme
                                                              .subtitle1!
                                                              .copyWith(
                                                                  color: AppColors
                                                                      .white),
                                                        ),
                                                      ),
                                                    );
                                                  }
                                              }
                                            },
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
                              left: Get.width * 0.05,
                              right: Get.width * 0.05),
                          child: CarouselSlider(
                            options: CarouselOptions(
                              viewportFraction: 1,
                              autoPlayInterval: const Duration(seconds: 10),
                              autoPlayAnimationDuration:
                                  const Duration(seconds: 1),
                              autoPlay: true,
                              enlargeCenterPage: true,
                            ),
                            items: mandaBaiController.bannerData
                                .map(
                                  (item) => Center(
                                    child: Image.network(
                                      item.image!,
                                      fit: BoxFit.cover,
                                      width: Get.width,
                                      height: Get.height * 0.2,
                                    ),
                                  ),
                                )
                                .toList(),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
               /* Padding(
                  padding: EdgeInsets.only(
                      left: Get.width * 0.05, right: Get.width * 0.05),
                  child: Search(
                    textHint: AppLocalizations.of(context)!.search,
                    function: () {},
                    controller: productController.pesquisa,
                  ),
                ),
                const SizedBox(
                  height: 8.0,
                ),
            */

                        if (mandaBaiController.discountData.isEmpty)
                           const Empty()
                         else
                          SizedBox(
                            height: Get.height * 0.1,
                            width: Get.width,
                            child: Obx(
                                  () => ListView.builder(
                                padding: const EdgeInsets.only(
                                  top: 0.0,
                                ),
                                scrollDirection: Axis.horizontal,
                                itemCount: mandaBaiController.discountData.length,
                                itemBuilder: (BuildContext context, index) {
                                  var discount = mandaBaiController.discountData[index];
                                  return PromotionText(
                                    discount: discount,
                                  );
                                },
                              ),
                            ),
                          ),

                FutureBuilder(
                  future: categoryController.carregarFilter(),
                  builder: (context, AsyncSnapshot snapshot) {
                    if (snapshot.hasError) {
                      return const ErrorPage(text: 'Erro the system');
                    }
                    if (snapshot.connectionState == ConnectionState.done && categoryController.listFilter.isNotEmpty) {
                      return Column(
                        children: [
                          HeaderTitle(
                            title: AppLocalizations.of(context)!
                                .title_categories,
                            buttonText:
                                AppLocalizations.of(context)!.look_full,
                            action: () {
                              Navigator.pushNamed(context, '/categories');
                            },
                          ),
                          Wrap(
                            children: categoryController.listFilter.map((e) => Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 8.0),
                              child: ItemFilter(filter: e),
                            )).toList(),
                          ),

                        ],
                      );
                    }
                    return Center(
                      child: SizedBox(
                          width: 32,
                          height: 32,
                          child: CircularProgressIndicator(
                            color: Theme.of(context).primaryColor,
                            strokeWidth: 2,
                          )),
                    );
                  },
                ),
                Obx(
                  () => productController.listProductHome.isEmpty
                      ? Container()
                      : HeaderTitle(
                          title: AppLocalizations.of(context)!.gifts,
                          buttonText: AppLocalizations.of(context)!.look_full,
                          action: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => CategoryPage(
                                      category:
                                          categoryController.categorySelect,
                                      filter_most:
                                          AppLocalizations.of(context)!
                                              .filter_more_price,
                                      filter_less:
                                          AppLocalizations.of(context)!
                                              .filter_less_price)),
                            );
                          },
                        ),
                ),
                FutureBuilder(
                  future: categoryController.carregarProductByHome(),
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
                        if (snapshot.data == null) {
                          return const Empty();
                        } else {
                          return SizedBox(
                            height: Get.height * 0.25,
                            width: Get.width,
                            child: Obx(
                              () => ListView.builder(
                                padding: const EdgeInsets.only(
                                  top: 0.0,
                                ),
                                scrollDirection: Axis.horizontal,
                                itemCount:
                                    productController.listProductHome.length,
                                itemBuilder: (BuildContext context, index) {
                                  var product = productController
                                      .listProductHome[index];
                                  return ProductListComponent(
                                    product: product,
                                    checkOption: false,
                                  );
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
