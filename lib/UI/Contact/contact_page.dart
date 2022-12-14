import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:manda_bai/Core/app_colors.dart';
import 'package:manda_bai/Core/app_fonts.dart';
import 'package:manda_bai/Core/app_images.dart';
import 'package:manda_bai/UI/home/pop_up/popup_message_internet.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
class ContactPage extends StatefulWidget {
  const ContactPage({Key? key}) : super(key: key);

  @override
  _ContactPageState createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
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
  Future<void> openwhatsapp() async {
    var whatsapp = "+2389149439";
    var whatsappURl_android = "whatsapp://send?phone=" + whatsapp;
     await launch(whatsappURl_android);
    if (await canLaunch(whatsappURl_android)) {
      await launch(whatsappURl_android);
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: new Text("whatsapp no installed")));
    }
  }

  Future<void> abrirGmail() async {
    final Uri params = Uri(
      scheme: 'mailto',
      path: 'mandabai2020@gmail.com',
      query: 'subject=Preciso de Ajuda&body=Ola, Em que posso te ajudar? ',
    );
    String url = params.toString();
   // if (await canLaunch(url)) {
      await launch(url);
   /* } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: new Text("Gmail no installed")));
    }*/
  }

  Future<void> abrirMessenger() async {
    var url = 'http://m.me/shopmandabai';
     await launch(url);
  /*  if (await canLaunch(url)) {
      await launch(url);
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: new Text("Messenger no installed")));
    }*/
  }

  abrirViber() async {
    var number = '+2389724140';
    var viberUrl = 'viber://send?phone=' + number;

    await launch(viberUrl);
    /* if (await canLaunch(viberUrl)) {
    await launch(viberUrl);
  } else {
    ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: new Text("viber no installed")));
  }*/
  }

  final input_nome = TextEditingController();
  final input_email = TextEditingController();
  final input_assunto = TextEditingController();
  final input_mensagem = TextEditingController();
  final input_info = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                color:Theme.of(context).primaryColor,
                width: double.infinity,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      child: IconButton(
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
                      AppLocalizations.of(context)!.text_talk_to_us,
                      style: Theme.of(context).textTheme.headline3!.copyWith(color:Colors.white,),
                    ),
                    Container(
                      width: Get.width * 0.08,
                    ),
                  ],
                ),
              ),

              SizedBox(height: Get.height * 0.06),
              Padding(
                padding: EdgeInsets.only(
                    left: Get.width * 0.03, right: Get.width * 0.03),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                     AppLocalizations.of(context)!.text_description_contact, style: Theme.of(context).textTheme.headline3,
                    ),
                    SizedBox(height: Get.height * 0.018),
                    Text(
                    AppLocalizations.of(context)!.text_description2_contact,
                      style: Theme.of(context)
                          .textTheme
                          .headline5!
                          .copyWith(fontSize: Get.width * 0.05),
                    ),
                  ],
                ),
              ),
              SizedBox(height: Get.height * 0.05),
              Column(
                children: [
                  Container(
                    height: Get.height * 0.07,
                    width: Get.width * 0.7,
                    decoration: BoxDecoration(
                      color: AppColors.greenColor,
                      borderRadius:const BorderRadius.all(
                        Radius.circular(15),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Theme.of(context).cardColor,
                          blurRadius: 2.0,
                          spreadRadius: 0.0,
                          offset: Offset(2.0, 2.0), // changes position of shadow
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: TextButton(
                        onPressed: () {
                          abrirGmail();
                        },
                        child: Row(
                          children: [
                            Flexible(
                              flex: 1,
                              child: Image.network(
                                AppImages.gmail_logo,
                                height: Get.height * 0.08,
                                width: Get.width * 0.08,
                              ),
                            ),
                            Flexible(
                              flex: 3,
                              child: Align(
                                alignment: Alignment.center,
                                child: Text(
                                 AppLocalizations.of(context)!.button_chat_email,
                                  style: TextStyle(
                                      fontFamily: AppFonts.poppinsBoldFont,
                                      fontSize: Get.width * 0.035,
                                      color: Colors.white),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: Get.height * 0.02),
                  Container(
                    height: Get.height * 0.07,
                    width: Get.width * 0.7,
                    decoration: BoxDecoration(
                      color: AppColors.greenColor,
                      borderRadius: const BorderRadius.all(
                        Radius.circular(15),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Theme.of(context).cardColor,
                          blurRadius: 4.0,
                          spreadRadius: 0.0,
                          offset: Offset(2.0, 2.0), // changes position of shadow
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: TextButton(
                        onPressed: () {
                          openwhatsapp();
                        },
                        child: Row(
                          children: [
                            Flexible(
                              flex: 1,
                              child: Image.asset(
                                AppImages.whatsapp_logo,
                                height: Get.height * 0.08,
                                width: Get.width * 0.08,
                              ),
                            ),
                            Flexible(
                              flex: 4,
                              child: Align(
                                alignment: Alignment.center,
                                child: Text(
                                AppLocalizations.of(context)!.button_chat_whatsapp,
                                  style: TextStyle(
                                      fontFamily: AppFonts.poppinsBoldFont,
                                      fontSize: Get.width * 0.035,
                                      color: Colors.white),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: Get.height * 0.02),
                  Container(
                    height: Get.height * 0.07,
                    width: Get.width * 0.7,
                    decoration: BoxDecoration(
                      color: AppColors.greenColor,
                      borderRadius: const BorderRadius.all(
                        Radius.circular(15),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Theme.of(context).cardColor,
                          blurRadius: 4.0,
                          spreadRadius: 0.0,
                          offset:const Offset(2.0, 2.0), // changes position of shadow
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: TextButton(
                        onPressed: () {
                          abrirMessenger();
                        },
                        child: Row(
                          children: [
                            Flexible(
                              flex: 1,
                              child: Image.network(
                                AppImages.messenger_logo,
                                height: Get.height * 0.08,
                                width: Get.width * 0.08,
                              ),
                            ),
                            Flexible(
                              flex: 4,
                              child: Align(
                                alignment: Alignment.center,
                                child: Text(
                                  AppLocalizations.of(context)!.button_chat_messenger,
                                  style: TextStyle(
                                      fontFamily: AppFonts.poppinsBoldFont,
                                      fontSize: Get.width * 0.035,
                                      color: Colors.white),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
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
