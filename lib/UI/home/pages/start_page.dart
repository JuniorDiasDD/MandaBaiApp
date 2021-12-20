import 'dart:convert';
import 'dart:ui';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:manda_bai/Controller/request.dart';
import 'package:manda_bai/Controller/static_config.dart';
import 'package:manda_bai/Core/app_fonts.dart';
import 'package:manda_bai/Core/app_images.dart';
import 'package:manda_bai/UI/home/components/item_category.dart';
import 'package:manda_bai/UI/home/components/item_new.dart';
import 'package:manda_bai/data/madaBaiData.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class StartPage extends StatefulWidget {
  @override
  _StartPageState createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
  final List<String> imagesList = [
    "https://www.mandabai.com/wp-content/uploads/2021/08/post-mandabai-facebook-05.jpg",
    "https://www.mandabai.com/wp-content/uploads/2021/08/post-mandabai-facebook-17.png",
    "https://www.mandabai.com/wp-content/uploads/2021/12/PicsArt_12-16-09.28.55-scaled.jpg",
    "https://www.mandabai.com/wp-content/uploads/2021/12/PicsArt_12-07-05.43.14-scaled.jpg",
    "https://www.mandabai.com/wp-content/uploads/2021/12/PicsArt_11-25-08.04.52.jpg",
    "https://www.mandabai.com/wp-content/uploads/2021/12/PicsArt_11-20-12.59.37.jpg",
    "https://www.mandabai.com/wp-content/uploads/2021/12/PicsArt_12-12-04.13.45-scaled.jpg"
  ];

  Future _carregarCategory() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var island_atualizar = prefs.getString('island_atualizar');
    //  print(island_atualizar);
    if (island_atualizar != null && island_atualizar == "true") {
      list_category = await ServiceRequest.loadCategory();

      if (list_category.isEmpty) {
        return null;
      }

      await prefs.setString('island_atualizar', "false");
    } else {
      if (list_category.isEmpty) {
        // print("entrou");
        list_category = await ServiceRequest.loadCategory();

        if (list_category.isEmpty) {
          return null;
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

  @override
  void initState() {
    super.initState();
    validateMoney();
    validateLanguage();
    validateDados();
    //removerId();
  }

  int _current = 0;
  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () => Navigator.pushReplacementNamed(context, '/home'),
      child: WillPopScope(
        onWillPop: () {
          return new Future(() => false);
        },
        child: Scaffold(
          body: SingleChildScrollView(
            child: Column(
              children: [
                Stack(
                  children: [
                    CarouselSlider(
                      options: CarouselOptions(
                          viewportFraction: 1,
                          autoPlayAnimationDuration:
                              const Duration(milliseconds: 100),
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
                                height: Get.height * 0.25,
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
                              margin: EdgeInsets.symmetric(
                                  vertical: 10.0, horizontal: 2.0),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: _current == index
                                    ? Colors.green
                                    : Colors.green[50],
                              ),
                            );
                          },
                        ).toList(), // this was the part the I had to add
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: Get.height * 0.01,
                ),
                Align(
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
                          image: AppImages.camara, title: "Serviços da Câmara"),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: EdgeInsets.only(
                          top: Get.height * 0.01, left: Get.width * 0.023),
                      child: Text(
                        AppLocalizations.of(context)!.title_categories,
                        style: Theme.of(context).textTheme.headline1,
                      ),
                    ),
                  ],
                ),
                FutureBuilder(
                  future: _carregarCategory(),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (!snapshot.hasData) {
                      return Container(
                        height: Get.height * 0.2,
                        width: Get.width,
                        child: Center(
                          child: Image.asset(
                            AppImages.loading,
                            width: Get.width * 0.2,
                            height: Get.height * 0.2,
                            alignment: Alignment.center,
                          ),
                        ),
                      );
                    } else {
                      if (snapshot.data == null) {
                        return Container(
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
                          margin: EdgeInsets.only(top: Get.height * 0.012),
                          height: Get.height * 0.5,
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
    );
  }
}
