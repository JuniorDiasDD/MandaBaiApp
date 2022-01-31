import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:manda_bai/Controller/request.dart';
import 'package:manda_bai/Controller/static_config.dart';
import 'package:manda_bai/Core/app_colors.dart';
import 'package:manda_bai/Core/app_images.dart';
import 'package:manda_bai/UI/Contact/contact_page.dart';
import 'package:manda_bai/UI/about/pages/info_page.dart';
import 'package:manda_bai/UI/home/pop_up/pop_login.dart';
import 'package:manda_bai/UI/home/pop_up/popup_message_internet.dart';
import 'package:manda_bai/UI/location_destination/page/destination_page.dart';
import 'package:manda_bai/UI/account/pages/edit_profile.dart';
import 'package:manda_bai/UI/Pedido/pages/pedido_page.dart';
import 'package:manda_bai/UI/home/pop_up/popup_island.dart';
import 'package:manda_bai/UI/home/pop_up/popup_moeda.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _StartPageState createState() => _StartPageState();
}

class _StartPageState extends State<ProfilePage> {
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

  }

  @override
  void dispose() {
    _connectivitySubscription.cancel();
    super.dispose();
  }

  String check = "";
  String island = "";
  String money = "";
  String language = "";
  Future _carregarIsland() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    island = prefs.getString('island')!;
    return island;
  }

  Future _carregarMoney() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    money = prefs.getString('money')!;
    return money;
  }


  Uint8List? image;
  bool image_check = false;
  Future _carregarUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var id = prefs.getString('id');

    if (id != 'null' && id != null) {
      bool check = await ServiceRequest.GetUser();
      if (check == false) {
        return null;
      } else {
        await _carregarUserImage();
        return check;
      }
    }

    return null;
  }

  Future _carregarUserImage() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var image_save = prefs.getString("image");
    if (image_save != null) {
      image = base64Decode(image_save);
      image_check = true;
      return image;
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        return new Future(() => false);
      },
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(
              left: Get.width * 0.05,
              right: Get.width * 0.05,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: Get.height * 0.1),
                FutureBuilder(
                  future: _carregarUser(),
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
                            height: Get.height * 0.1,
                            width: Get.width,
                            child: Center(
                              child: Image.asset(
                                AppImages.appLogo,
                                width: Get.width * 0.5,
                                height: Get.height * 0.1,
                                alignment: Alignment.center,
                              ),
                            ),
                          );
                        } else {
                          return Column(
                            children: [
                              SizedBox(
                                child: image_check == true
                                    ? Container(
                                        width: Get.width * 0.3,
                                        height: Get.width * 0.3,
                                        decoration: BoxDecoration(
                                          color: AppColors.greenColor,
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(100),
                                          ),
                                          boxShadow: [
                                            BoxShadow(
                                              color:
                                                  Theme.of(context).cardColor,
                                              blurRadius: 2.0,
                                              spreadRadius: 0.0,
                                              offset: Offset(2.0,
                                                  2.0), // changes position of shadow
                                            ),
                                          ],
                                          image: DecorationImage(
                                            fit: BoxFit.fill,
                                            image: MemoryImage(image!),
                                          ),
                                        ),
                                      )
                                    : Container(
                                        width: Get.width * 0.3,
                                        height: Get.width * 0.3,
                                        decoration: BoxDecoration(
                                          color: AppColors.greenColor,
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(100),
                                          ),
                                          boxShadow: [
                                            BoxShadow(
                                              color:
                                                  Theme.of(context).cardColor,
                                              blurRadius: 2.0,
                                              spreadRadius: 0.0,
                                              offset: Offset(2.0,
                                                  2.0), // changes position of shadow
                                            ),
                                          ],
                                          image: DecorationImage(
                                            fit: BoxFit.fill,
                                            image: NetworkImage(user.avatar),
                                          ),
                                        ),
                                      ),
                              ),
                              SizedBox(height: Get.height * 0.03),
                              Text(
                                user.name,
                                style: Theme.of(context).textTheme.headline2,
                              ),
                              Text(
                                user.email,
                                style: Theme.of(context).textTheme.headline4,
                              ),
                            ],
                          );
                        }
                    }
                  },
                ),
                SizedBox(height: Get.height * 0.05),
                Container(
                  height: Get.height * 0.06,
                  child: GestureDetector(
                    onTap: () async {
                      final SharedPreferences prefs =
                          await SharedPreferences.getInstance();
                      var check = prefs.getString('id');
                      if (check == 'null' || check == null) {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return Pop_Login();
                            });
                      } else {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => EditPorfilePage(),
                          ),
                        );
                      }
                    },
                    child: Row(
                      children: [
                        Container(
                          height: Get.height * 0.042,
                          width: Get.height * 0.042,
                          decoration: BoxDecoration(
                            color: Colors.teal,
                            borderRadius: const BorderRadius.all(
                              Radius.circular(100),
                            ),
                            border: Border.all(color: Colors.teal),
                          ),
                          child: Icon(
                            Icons.edit,
                            color: Colors.white,
                            size: Get.height * 0.025,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            left: Get.width * 0.02,
                          ),
                          child: Text(
                            AppLocalizations.of(context)!.text_edit_profile,
                            style: Theme.of(context).textTheme.headline3,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: Get.height * 0.01),
                /*Row(
                  children: <Widget>[
                    Expanded(
                      child: SizedBox(
                        width: Get.width * 0.1,
                        child: const Divider(
                          height: 36,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        left: Get.width * 0.05,
                        right: Get.width * 0.05,
                      ),
                      child: Text(
                        AppLocalizations.of(context)!.text_other_services,
                        style: Theme.of(context).textTheme.headline4,
                      ),
                    ),
                    Expanded(
                      child: SizedBox(
                        width: Get.width * 0.4,
                        child: const Divider(
                          height: 36,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: Get.height * 0.06,
                  child: GestureDetector(
                    onTap: () {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return const Carrega_Saldo();
                          });
                    },
                    child: Row(
                      children: [
                        Container(
                          height: Get.height * 0.042,
                          width: Get.height * 0.042,
                          decoration: BoxDecoration(
                            color: Colors.lightBlueAccent,
                            borderRadius: const BorderRadius.all(
                              Radius.circular(100),
                            ),
                            border: Border.all(color: Colors.lightBlueAccent),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Image.network(
                              AppImages.cvmovel,
                            ),
                          ),
                        ),
                        SizedBox(height: Get.height * 0.01),
                        Padding(
                          padding: EdgeInsets.only(
                            left: Get.width * 0.02,
                          ),
                          child: Text(
                            'Saldo CvMóvel',
                            style: Theme.of(context).textTheme.headline3,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: Get.height * 0.01),
                Container(
                  height: Get.height * 0.06,
                  child: GestureDetector(
                    onTap: () {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return Pop_up_Message(
                                mensagem: AppLocalizations.of(context)!
                                    .text_unavailable_service,
                                icon: Icons.device_unknown_sharp,
                                caminho: "erro");
                          });
                    },
                    child: Row(
                      children: [
                        Container(
                          height: Get.height * 0.042,
                          width: Get.height * 0.042,
                          decoration: BoxDecoration(
                            color: Colors.teal[100],
                            borderRadius: const BorderRadius.all(
                              Radius.circular(100),
                            ),
                            border: Border.all(color: Colors.teal.shade100),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Image.network(
                              AppImages.camara,
                            ),
                          ),
                        ),
                        SizedBox(height: Get.height * 0.01),
                        Padding(
                          padding: EdgeInsets.only(
                            left: Get.width * 0.02,
                          ),
                          child: Text(
                            AppLocalizations.of(context)!
                                .text_city_council_services,
                            style: Theme.of(context).textTheme.headline3,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),*/
                Row(
                  children: <Widget>[
                    Expanded(
                      child: SizedBox(
                        width: Get.width * 0.1,
                        child: Divider(
                          height: 36,
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        left: Get.width * 0.05,
                        right: Get.width * 0.05,
                      ),
                      child: Text(
                        AppLocalizations.of(context)!.text_settings,
                        style: Theme.of(context).textTheme.headline4,
                      ),
                    ),
                    Expanded(
                      child: SizedBox(
                        width: Get.width * 0.4,
                        child:  Divider(
                          height: 36,
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Container(
                      height: Get.height * 0.06,
                      child: GestureDetector(
                        onTap: () {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return Popup_Island();
                              });
                        },
                        child: Row(
                          children: [
                            Container(
                              height: Get.height * 0.042,
                              width: Get.height * 0.042,
                              decoration: BoxDecoration(
                                color: Colors.lightBlueAccent,
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(100),
                                ),
                                border:
                                    Border.all(color: Colors.lightBlueAccent),
                              ),
                              child: Image.network(
                                AppImages.santiago,
                                color: Colors.white,
                                height: Get.height * 0.1,
                                width: Get.width * 0.6,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                left: Get.width * 0.02,
                              ),
                              child: Row(
                                children: [
                                  Text(
                                    AppLocalizations.of(context)!
                                        .text_change_island,
                                    style:
                                        Theme.of(context).textTheme.headline3,
                                  ),
                                  FutureBuilder(
                                      future: _carregarIsland(),
                                      builder: (BuildContext context,
                                          AsyncSnapshot snapshot) {
                                        if (snapshot.data == null) {
                                          return const Text(" ");
                                        } else {
                                          return Text(
                                            ' (' + island + ')',
                                            style: Theme.of(context)
                                                .textTheme
                                                .headline3,
                                          );
                                        }
                                      }),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: Get.height * 0.01),
                    Container(
                      height: Get.height * 0.06,
                      child: GestureDetector(
                        onTap: () {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return const Popup_Moeda();
                              });
                        },
                        child: Row(
                          children: [
                            Container(
                              height: Get.height * 0.042,
                              width: Get.height * 0.042,
                              decoration: BoxDecoration(
                                color: Colors.lightGreen,
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(100),
                                ),
                                border: Border.all(color: Colors.lightGreen),
                              ),
                              child: Icon(
                                Icons.attach_money,
                                color: Colors.white,
                                size: Get.height * 0.025,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                left: Get.width * 0.02,
                              ),
                              child: Row(
                                children: [
                                  Text(
                                    AppLocalizations.of(context)!
                                        .text_select_currency,
                                    style:
                                        Theme.of(context).textTheme.headline3,
                                  ),
                                  FutureBuilder(
                                      future: _carregarMoney(),
                                      builder: (BuildContext context,
                                          AsyncSnapshot snapshot) {
                                        if (snapshot.data == null) {
                                          return const Text(" ");
                                        } else {
                                          return Text(
                                            ' (' + money + ')',
                                            style: Theme.of(context)
                                                .textTheme
                                                .headline3,
                                          );
                                        }
                                      }),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: Get.height * 0.01),
                    Container(
                      height: Get.height * 0.06,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Destination_Page(route: ""),
                            ),
                          );
                        },
                        child: Row(
                          children: [
                            Container(
                              height: Get.height * 0.042,
                              width: Get.height * 0.042,
                              decoration: BoxDecoration(
                                color: Colors.orangeAccent,
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(100),
                                ),
                                border: Border.all(color: Colors.orangeAccent),
                              ),
                              child: Icon(
                                Icons.location_on_outlined,
                                color: Colors.white,
                                size: Get.height * 0.025,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                left: Get.width * 0.02,
                              ),
                              child: Row(
                                children: [
                                  Text(
                                    AppLocalizations.of(context)!
                                        .text_delivery_location,
                                    style:
                                        Theme.of(context).textTheme.headline3,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: Get.height * 0.01),

                    Row(
                      children: <Widget>[
                        Expanded(
                          child: SizedBox(
                            width: Get.width * 0.1,
                            child: Divider(
                              height: 36,
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            left: Get.width * 0.05,
                            right: Get.width * 0.05,
                          ),
                          child: Text(
                            AppLocalizations.of(context)!.text_social_media,
                            style: Theme.of(context).textTheme.headline4,
                          ),
                        ),
                        Expanded(
                          child: SizedBox(
                            width: Get.width * 0.4,
                            child:  Divider(
                              height: 36,
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: Get.height * 0.01),
                    Container(
                      height: Get.height * 0.06,
                      child: GestureDetector(
                        onTap: () async {
                          var facebookUrl =
                              'https://www.facebook.com/shopmandabai/';
                          await launch(facebookUrl);
                        },
                        child: Row(
                          children: [
                            Container(
                              height: Get.height * 0.042,
                              width: Get.height * 0.042,
                              decoration: BoxDecoration(
                                color: Colors.blue,
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(100),
                                ),
                                border:
                                    Border.all(color: Colors.deepPurpleAccent),
                                image: DecorationImage(
                                  fit: BoxFit.fill,
                                  image: NetworkImage(AppImages.facebook_logo),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                left: Get.width * 0.02,
                              ),
                              child: Text(
                                'Facebook',
                                style: Theme.of(context).textTheme.headline3,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: Get.height * 0.01),
                    Container(
                      height: Get.height * 0.06,
                      child: GestureDetector(
                        onTap: () async {
                          var facebookUrl =
                              'https://www.instagram.com/mandabaishop/';
                          await launch(facebookUrl);
                        },
                        child: Row(
                          children: [
                            Container(
                              height: Get.height * 0.042,
                              width: Get.height * 0.042,
                              decoration: BoxDecoration(
                                color: Colors.deepPurpleAccent,
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(100),
                                ),
                                border:
                                    Border.all(color: Colors.deepPurpleAccent),
                                image: DecorationImage(
                                  fit: BoxFit.fill,
                                  image: NetworkImage(AppImages.instagram_logo),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                left: Get.width * 0.02,
                              ),
                              child: Text(
                                'Instagram',
                                style: Theme.of(context).textTheme.headline3,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: Get.height * 0.01),
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: SizedBox(
                            width: Get.width * 0.1,
                            child: Divider(
                              height: 36,
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            left: Get.width * 0.05,
                            right: Get.width * 0.05,
                          ),
                          child: Text(
                            AppLocalizations.of(context)!.text_information,
                            style: Theme.of(context).textTheme.headline4,
                          ),
                        ),
                        Expanded(
                          child: SizedBox(
                            width: Get.width * 0.4,
                            child:  Divider(
                              height: 36,
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: Get.height * 0.01),
                    Container(
                      height: Get.height * 0.06,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => InfoPage(),
                            ),
                          );
                        },
                        child: Row(
                          children: [
                            Container(
                              height: Get.height * 0.042,
                              width: Get.height * 0.042,
                              decoration: BoxDecoration(
                                color: Colors.deepPurpleAccent,
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(100),
                                ),
                                border:
                                    Border.all(color: Colors.deepPurpleAccent),
                              ),
                              child: Icon(
                                Icons.info,
                                color: Colors.white,
                                size: Get.height * 0.025,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                left: Get.width * 0.02,
                              ),
                              child: Text(
                                AppLocalizations.of(context)!
                                    .text_about_us_and_aplication,
                                style: Theme.of(context).textTheme.headline3,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: Get.height * 0.01),
                    Container(
                      height: Get.height * 0.06,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ContactPage(),
                            ),
                          );
                        },
                        child: Row(
                          children: [
                            Container(
                              height: Get.height * 0.042,
                              width: Get.height * 0.042,
                              decoration: BoxDecoration(
                                color: Colors.teal,
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(100),
                                ),
                                border: Border.all(color: Colors.teal),
                              ),
                              child: Icon(
                                Icons.phone,
                                color: Colors.white,
                                size: Get.height * 0.025,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                left: Get.width * 0.02,
                              ),
                              child: Text(
                                AppLocalizations.of(context)!.text_contact_us,
                                style: Theme.of(context).textTheme.headline3,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: Get.height * 0.01),
                    Container(
                      height: Get.height * 0.06,
                      child: GestureDetector(
                        onTap: () => _terminarSessao(),
                        child: Row(
                          children: [
                            Container(
                              height: Get.height * 0.042,
                              width: Get.height * 0.042,
                              decoration: BoxDecoration(
                                color: Colors.redAccent,
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(100),
                                ),
                                border: Border.all(color: Colors.redAccent),
                              ),
                              child: Icon(
                                Icons.logout,
                                color: Colors.white,
                                size: Get.height * 0.025,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                left: Get.width * 0.02,
                              ),
                              child: Text(
                                AppLocalizations.of(context)!.text_logout,
                                style: Theme.of(context).textTheme.headline3,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: Get.height * 0.03),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _terminarSessao() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var check = prefs.getString('id');
    if (check != 'null' || check != null) {
      prefs.remove('id');
    }
    Navigator.of(context)
        .pushNamedAndRemoveUntil('/login', (Route<dynamic> route) => false);
  }
}
