import 'dart:async';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:manda_bai/Core/app_colors.dart';
import 'package:manda_bai/Core/app_images.dart';
import 'package:manda_bai/UI/about/pages/info_page.dart';
import 'package:manda_bai/UI/category_filter/components/product_list_component.dart';
import 'package:manda_bai/UI/category_filter/pages/category_page.dart';
import 'package:manda_bai/UI/home/components/item_filter.dart';
import 'package:manda_bai/UI/home/pop_up/pop_login.dart';
import 'package:manda_bai/UI/home/pop_up/popup_message_internet.dart';
import 'package:manda_bai/UI/widget/Empty.dart';
import 'package:manda_bai/constants/controllers.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:websafe_svg/websafe_svg.dart';
import '../../widget/ErrorPage.dart';
import '../../widget/HeaderTitle.dart';
import '../../widget/PromotionText.dart';
import '../../widget/Search.dart';

class StartPage extends StatefulWidget {
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

  final List<String> imagesList = [
    "https://www.mandabai.com/wp-content/uploads/2022/02/received_1150641802018430-scaled.jpeg",
    "https://www.mandabai.com/wp-content/uploads/2022/02/banner2.png",
    "https://www.mandabai.com/wp-content/uploads/2022/02/banner3.png",
    "https://www.mandabai.com/wp-content/uploads/2022/02/banner1.jpg"
  ];

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
    return RefreshIndicator(
      onRefresh: () => Navigator.pushReplacementNamed(context, '/home'),
      child: WillPopScope(
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
                        child: Image.network(
                          "https://santiago.mandabai.com/wp-content/uploads/2022/11/santiagoBackground.jpeg",
                          fit: BoxFit.cover,
                          width: Get.width,
                          height: Get.height * 0.2,
                        ),
                      ),
                      Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => const InfoPage(),
                                      ),
                                    );
                                  },
                                  child: Container(
                                    width: Get.width * 0.1,
                                    height: Get.width * 0.1,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(50),
                                      color: AppColors.grey50.withOpacity(0.8),
                                    ),
                                    child: const Padding(
                                      padding: EdgeInsets.all(4.0),
                                      child: Icon(Icons.close),
                                    ),
                                  ),
                                ),
                                const Spacer(),
                                GestureDetector(
                                  onTap: () async {
                                    final SharedPreferences prefs =
                                        await SharedPreferences.getInstance();
                                    var check = prefs.getString('id');
                                    if (check == 'null' || check == null) {
                                      showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return const Pop_Login();
                                          });
                                    } else {
                                      Navigator.pushNamed(context, '/cart');
                                    }
                                  },
                                  child: Container(
                                    width: Get.width * 0.1,
                                    height: Get.width * 0.1,
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
                              items: imagesList
                                  .map(
                                    (item) => Center(
                                      child: Image.network(
                                        item,
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
                  //NEW SERVICES
                  /*   Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: EdgeInsets.only(
                          top: Get.height * 0.01, left: Get.width * 0.02),
                      child: Text(
                        AppLocalizations.of(context)!.title_new_services,
                        style: Theme.of(context).textTheme.headline1,
                      ),
                    ),
                  ),
                  Container(
                    height: Get.height * 0.15,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: [
                        ItemNew(image: AppImages.cvmovel, title: "Saldo CvMovel"),
                        ItemNew(
                            image: AppImages.camara, title: AppLocalizations.of(context)!.text_city_council_services,),
                      ],
                    ),
                  ),*/

                  Padding(
                    padding: EdgeInsets.only(
                        left: Get.width * 0.05, right: Get.width * 0.05),
                    child: Search(
                      textHint: AppLocalizations.of(context)!.search,
                      function: () {},
                    ),
                  ),

                  const SizedBox(
                    height: 16,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      PromotionText(
                        title: '-10%',
                        description:
                            AppLocalizations.of(context)!.label_order + ' +100',
                      ),
                      PromotionText(
                        title: '-20%',
                        description:
                            AppLocalizations.of(context)!.label_order + ' +250',
                      ),
                      PromotionText(
                        title: '-25%',
                        description:
                            AppLocalizations.of(context)!.label_order + ' +500',
                      ),
                    ],
                  ),

                  FutureBuilder(
                    future: categoryController.carregarFilter(),
                    builder: (context, AsyncSnapshot snapshot) {
                      if (snapshot.hasError) {
                        return const ErrorPage(text: 'Erro the system');
                      }
                      if (snapshot.connectionState == ConnectionState.done) {
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
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                ItemFilter(
                                    filter: categoryController.listFilter[0]),
                                ItemFilter(
                                    filter: categoryController.listFilter[1]),
                                ItemFilter(
                                    filter: categoryController.listFilter[2]),
                                ItemFilter(
                                    filter: categoryController.listFilter[3]),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                ItemFilter(
                                    filter: categoryController.listFilter[4]),
                                ItemFilter(
                                    filter: categoryController.listFilter[5]),
                                ItemFilter(
                                    filter: categoryController.listFilter[6]),
                                ItemFilter(
                                    filter: categoryController.listFilter[7]),
                              ],
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
                    () => productController.listProduct.isEmpty
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
                    future: categoryController.carregarProductByPresents(),
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
                              child: ListView.builder(
                                padding: const EdgeInsets.only(
                                  top: 0.0,
                                ),
                                scrollDirection: Axis.horizontal,
                                itemCount: snapshot.data.length,
                                itemBuilder: (BuildContext context, index) {
                                  var list =
                                      productController.listProduct[index];
                                  return ProductListComponent(
                                    product: list,
                                    checkOption: false,
                                  );
                                },
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
      ),
    );
  }
}
