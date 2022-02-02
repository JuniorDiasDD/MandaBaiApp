import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:manda_bai/Core/app_images.dart';
import 'package:manda_bai/UI/about/components/item_developer.dart';
import 'package:manda_bai/UI/about/pages/about_app.dart';
import 'package:manda_bai/UI/home/pop_up/popup_message_internet.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class InfoPage extends StatefulWidget {
  const InfoPage({Key? key}) : super(key: key);

  @override
  State<InfoPage> createState() => _InfoPageState();
}

class _InfoPageState extends State<InfoPage> {
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


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Container(
              color:Theme.of(context).primaryColor,
              width: double.infinity,
              child: Row(
                children: [
                  Container(
                    child: IconButton(
                      // padding: EdgeInsets.all(0.0),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(
                        Icons.arrow_back,
                        color:Colors.white,
                      ),
                      alignment: Alignment.centerRight,
                    ),
                  ),
                  Text(
                    AppLocalizations.of(context)!.info_app_title,
                    style: Theme.of(context).textTheme.headline3!.copyWith(color:Colors.white,),
                  ),
                  const Spacer(),
                ],
              ),
            ),

            SizedBox(height: Get.height * 0.02),
            Padding(
              padding: EdgeInsets.only(
                left: Get.width * 0.04,
                right: Get.width * 0.04,
              ),
              child: SizedBox(
                height: Get.height*0.85,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Image.asset(
                        AppImages.appLogoIcon,
                        width: Get.width * 0.5,
                        height: Get.height * 0.1,
                        alignment: Alignment.center,
                      ),
                      Text(
                        "MandaBai",
                        style: Theme.of(context).textTheme.headline1,
                      ),
                      Text(
                        "V.1.0.0",
                        style: Theme.of(context).textTheme.headline5,
                      ),
                      SizedBox(height: Get.height * 0.01),
                      Text(
                        AppLocalizations.of(context)!.info_app_description,
                        style: Theme.of(context).textTheme.headline4,
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: Get.height * 0.02),
                      Divider(),
                      SizedBox(height: Get.height * 0.02),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            AppLocalizations.of(context)!
                                .info_app_published_title,
                            style: Theme.of(context).textTheme.headline1,
                          ),
                          Text(
                            AppLocalizations.of(context)!
                                .info_app_published_description,
                            style: Theme.of(context).textTheme.headline4,
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(height: Get.height * 0.01),
                          Text(
                            AppLocalizations.of(context)!
                                .info_app_developer_title,
                            style: Theme.of(context).textTheme.headline1,
                          ),
                          SizedBox(height: Get.height * 0.01),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              ItemDeveloper(
                                  image:
                                  "https://www.mandabai.com/wp-content/uploads/2022/01/fotoPassPorte6.jpg",
                                  name: "Júnior Dias Silva",
                                  cargo: AppLocalizations.of(context)!
                                      .info_app_func_eng),
                              ItemDeveloper(
                                  image:
                                  "https://www.mandabai.com/wp-content/uploads/2022/01/avatar_rossana.jpg",
                                  name: "Rossana Mendes de Pina",
                                  cargo: AppLocalizations.of(context)!
                                      .info_app_func_desn),
                              ItemDeveloper(
                                  image:
                                  "https://www.mandabai.com/wp-content/uploads/2022/01/avatar_erickson.jpg",
                                  name: "Erickson Carvalho Vaz",
                                  cargo: AppLocalizations.of(context)!
                                      .info_app_func_eng),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: Get.height * 0.02),
                      Divider(),
                      SizedBox(height: Get.height * 0.02),
                      Text(
                        AppLocalizations.of(context)!.info_app_license_title,
                        style: Theme.of(context).textTheme.headline1,
                      ),
                      SizedBox(height: Get.height * 0.01),
                      Text(
                        AppLocalizations.of(context)!.info_app_license_decription,
                        style: Theme.of(context).textTheme.headline4,
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: Get.height * 0.01),
                      Row(
                        children: <Widget>[
                          Expanded(
                            child: new Container(
                              width: Get.width * 0.1,
                              child: Divider(
                                color: Theme.of(context).cardColor,
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
                              AppLocalizations.of(context)!
                                  .text_about_application,
                              style: Theme.of(context).textTheme.headline4,
                            ),
                          ),
                          Expanded(
                            child: Container(
                              width: Get.width * 0.4,
                              child: Divider(
                                color: Theme.of(context).cardColor,
                                height: 36,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: Get.height * 0.01),
                      Padding(
                        padding: EdgeInsets.only(
                            left: Get.width * 0.01, right: Get.width * 0.01),
                        child: Container(
                          height: Get.height * 0.06,
                          decoration: BoxDecoration(
                            color: Theme.of(context).cardColor,
                            borderRadius: BorderRadius.all(Radius.circular(15)),
                            border: Border.all(
                              color: Colors.black38,
                            ),
                          ),
                          child: TextButton(
                            child: Row(
                              //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Icon(
                                  Icons.description,
                                  color: Theme.of(context).indicatorColor,
                                  size: Get.height * 0.025,
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                    left: Get.width * 0.02,
                                  ),
                                  child: Text(
                                    AppLocalizations.of(context)!
                                        .textbutton_termos_of_use,
                                    style: Theme.of(context).textTheme.headline4,
                                  ),
                                ),
                              ],
                            ),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      Privacy_Policy(info: 1,),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                      SizedBox(height: Get.height * 0.01),
                      Padding(
                        padding: EdgeInsets.only(
                            left: Get.width * 0.01, right: Get.width * 0.01),
                        child: Container(
                          height: Get.height * 0.06,
                          decoration: BoxDecoration(
                            color: Theme.of(context).cardColor,
                            borderRadius: BorderRadius.all(
                              Radius.circular(15),
                            ),
                            border: Border.all(
                              color: Colors.black38,
                            ),
                          ),
                          child: TextButton(
                            child: Row(
                              children: [
                                Icon(
                                  Icons.security,
                                  color: Theme.of(context).indicatorColor,
                                  size: Get.height * 0.025,
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                    left: Get.width * 0.02,
                                  ),
                                  child: Text(
                                    AppLocalizations.of(context)!
                                        .textbutton_privacy_police,
                                    style: Theme.of(context).textTheme.headline4,
                                  ),
                                ),
                              ],
                            ),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      Privacy_Policy(info: 0,),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                      SizedBox(height: Get.height * 0.01),

                      Padding(
                        padding: EdgeInsets.only(
                            left: Get.width * 0.01, right: Get.width * 0.01),
                        child: Container(
                          height: Get.height * 0.06,
                          width: Get.width,
                          decoration: BoxDecoration(
                            color: Theme.of(context).cardColor,
                            borderRadius: BorderRadius.all(Radius.circular(15)),
                            border: Border.all(
                              color: Colors.black38,
                            ),
                          ),
                          alignment: Alignment.topLeft,
                          child: TextButton(
                            child: Padding(
                              padding: EdgeInsets.only(
                                left: Get.width * 0.02,
                              ),
                              child: Text(
                                AppLocalizations.of(context)!
                                    .textbutton_published_by+' MandaBai',
                                style: Theme.of(context).textTheme.headline4,
                              ),
                            ),
                            onPressed: () => Navigator.pushNamed(context, '/infoApp'),
                          ),
                        ),
                      ),
                      SizedBox(height: Get.height * 0.02),
                    ],
                  ),
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }
}


