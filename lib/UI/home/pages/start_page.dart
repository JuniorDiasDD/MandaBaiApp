import 'dart:async';
import 'dart:convert';
import 'package:animations/animations.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:manda_bai/Controller/full_controller.dart';
import 'package:manda_bai/Controller/request.dart';
import 'package:manda_bai/Controller/static_config.dart';
import 'package:manda_bai/Core/app_fonts.dart';
import 'package:manda_bai/Core/app_images.dart';
import 'package:manda_bai/Model/category.dart';
import 'package:manda_bai/UI/about/pages/info_page.dart';
import 'package:manda_bai/UI/home/components/item_category.dart';
import 'package:manda_bai/UI/home/components/item_filter.dart';
import 'package:manda_bai/UI/home/pop_up/popup_message_internet.dart';
import 'package:manda_bai/data/madaBaiData.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'home_page.dart';

class StartPage extends StatefulWidget {
  @override
  _StartPageState createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
  final FullController controller = Get.find();
  ConnectivityResult _connectionStatus = ConnectivityResult.none;
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;
  int net = 0;
  bool _onFirstPage = true;
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

  List<Category> list_full_category = [];
  Future _carregarCategory() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    controller.ilha = prefs.getString('island')!;
    var island_atualizar = prefs.getString('island_atualizar');
    if (island_atualizar != null && island_atualizar == "true") {
      list_category = await ServiceRequest.loadCategory(true);
      await prefs.setString('island_atualizar', "false");
      if (list_category.isEmpty) {
        return null;
      } else {
        setState(() {
          list_full_category = list_category;
        });
      }
    } else {
      if (list_full_category.isEmpty) {
        //  print("entrou");
        if (list_category.isEmpty) {
          list_category = await ServiceRequest.loadCategory(false);

          if (list_category.isEmpty) {
            return null;
          } else {
            setState(() {
              list_full_category = list_category;
            });
          }
        }
      }
    }

    return list_category;
  }

  validateMoney() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var money = prefs.getString('money');
    if (money == "null" || money == null) {
      await prefs.setString('money', "EUR");
    }
  }

  validateLanguage() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var language = prefs.getString('language');

    if (language == "null" || language == null) {
      await prefs.setString('language', "pt");
    }
  }

  validateDados() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    var username = prefs.getString('username');
    var password = prefs.getString('password');

    if (password != null && username != null) {
      final String? userString = prefs.getString('user');
      var userCache = json.decode(userString!);

      user.username = username.toString();
      user.senha = password.toString();

      user.name = userCache["name"];
      user.email = userCache["email"];
      user.nickname = userCache["nickname"];
      user.avatar = userCache["avatar"];
      user.telefone = userCache["telefone"];
      user.city = userCache["city"];
      user.country = userCache["country"];
    }
  }

  removerId() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('onboarding');
  }

  Future getFilter(value) async {
    setState(() {
      list_category = [];
      if (!list_full_category.isEmpty) {
        if (value == "Todos") {
          list_category = list_full_category;
        } else {
          for (var i = 0; i < list_full_category.length; i++) {
            if (list_full_category[i].name == value) {
              list_category.add(list_full_category[i]);
            }
          }
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
    validateMoney();
    validateLanguage();
    validateDados();
    //removerId();
  }

  @override
  void dispose() {
    _connectivitySubscription.cancel();
    super.dispose();
  }

  int _current = 0;
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
                      CarouselSlider(
                        options: CarouselOptions(
                            viewportFraction: 1,
                            autoPlayInterval: const Duration(seconds: 10),
                            autoPlayAnimationDuration: const Duration(seconds: 1),
                            autoPlay: true,
                            enlargeCenterPage: true,
                            onPageChanged: (index, reason) {
                              setState(() {
                                _current = index;
                              });
                            }),
                        items: imagesList
                            .map(
                              (item) => Center(
                                child: Image.network(
                                  item,
                                  fit: BoxFit.cover,
                                  width: Get.width,
                                  height: Get.height * 0.27,
                                ),
                              ),
                            )
                            .toList(),
                      ),
                      SizedBox(
                        height: Get.height * 0.25,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: imagesList.map(
                            (image) {
                              int index = imagesList.indexOf(image);
                              return Container(
                                width: 10.0,
                                height: 10.0,
                                margin: const EdgeInsets.symmetric(
                                    vertical: 10.0, horizontal: 2.0),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: _current == index
                                      ? Theme.of(context).primaryColor
                                      : Colors.green[100],
                                ),
                              );
                            },
                          ).toList(), // this was the part the I had to add
                        ),
                      ),
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
                                  boxShadow: [
                                    BoxShadow(
                                      color: Theme.of(context).cardColor,
                                      blurRadius: 1.0,
                                      spreadRadius: 0.0,
                                      offset: Offset(0.5, 0.5),
                                    ),
                                  ],
                                  color: Theme.of(context).dialogBackgroundColor,
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: Image.asset(
                                    AppImages.appLogoIcon,
                                    width: Get.width * 0.3,
                                  ),
                                ),
                              ),
                            ),
                            const Spacer(),
                            GestureDetector(
                              onTap: () async {
                                final SharedPreferences prefs =
                                    await SharedPreferences.getInstance();
                                var check = prefs.getString('id');
                                if (check != 'null' && check != null) {
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => HomePage(index: 4)));
                                }else{
                                  Navigator.pushNamed(context, '/login');
                                }

                              },
                              child: Container(
                                width: Get.width * 0.1,
                                height: Get.width * 0.1,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Theme.of(context).cardColor,
                                      blurRadius: 1.0,
                                      spreadRadius: 0.0,
                                      offset: Offset(0.5, 0.5),
                                    ),
                                  ],
                                  color: Theme.of(context).dialogBackgroundColor,
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: Icon(Icons.person),
                                ),
                              ),
                            ),
                          ],
                        ),
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
                  SizedBox(height: 10,),
                  FutureBuilder(
                    future: controller.carregarFilter(),
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      if (snapshot.data == null) {
                        return const SizedBox();
                      } else {
                        return SizedBox(
                          height: Get.height * 0.12,
                          child: ListView.builder(
                            padding: const EdgeInsets.only(
                              top: 0.0,
                            ),
                            scrollDirection: Axis.horizontal,
                            itemCount: snapshot.data.length,
                            itemBuilder: (BuildContext context, index) {
                              var list = controller.listFilter[index];
                              return GestureDetector(
                                  onTap: () {
                                    getFilter(list.name);
                                  },
                                  child: ItemFilter(filter: list));
                            },
                          ),
                        );
                      }
                    },
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: EdgeInsets.only(left: Get.width * 0.05),
                      child: Text(
                        AppLocalizations.of(context)!.title_categories,
                        style: Theme.of(context).textTheme.headline1,
                      ),
                    ),
                  ),
                  FutureBuilder(
                    future: _carregarCategory(),
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      switch (snapshot.connectionState) {
                        case ConnectionState.waiting:
                          return SizedBox(
                            height: Get.height * 0.2,
                            width: Get.width,
                            child: Center(
                              child: Image.network(
                                AppImages.loading,
                                width: Get.width * 0.15,
                                height: Get.height * 0.2,
                                alignment: Alignment.center,
                              ),
                            ),
                          );
                        default:
                          if (snapshot.data == null) {
                            print("vazio");
                            return SizedBox(
                              height: Get.height * 0.2,
                              width: Get.width,
                              child: Center(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.public_off_outlined,
                                      color: Colors.grey,
                                      size: Get.height * 0.06,
                                    ),
                                    Text(
                                      AppLocalizations.of(context)!
                                          .text_unavailable_service,
                                      style: TextStyle(
                                        fontFamily: AppFonts.poppinsBoldFont,
                                        fontSize: Get.width * 0.035,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          } else {
                            return Container(
                              height: Get.height * 0.485,
                              child: ListView.builder(
                                padding: EdgeInsets.only(
                                  top: 0.0,
                                  bottom: Get.height * 0.03,
                                ),
                                scrollDirection: Axis.vertical,
                                itemCount: snapshot.data.length,
                                itemBuilder: (BuildContext context, index) {
                                  var list = list_category[index];
                                  return ListViewItemComponent(category: list);
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
