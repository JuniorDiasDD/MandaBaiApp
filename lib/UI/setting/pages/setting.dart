import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:manda_bai/Controller/static_config.dart';
import 'package:manda_bai/Core/app_colors.dart';
import 'package:manda_bai/UI/home/pop_up/popup_message_internet.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:manda_bai/UI/setting/componente/buttonOption.dart';
import 'package:manda_bai/UI/setting/componente/headerTitle.dart';
import 'package:manda_bai/UI/widget/dialog_custom.dart';
import 'package:manda_bai/constants/controllers.dart';
import 'package:url_launcher/url_launcher.dart';

class Setting extends StatefulWidget {
  const Setting({Key? key}) : super(key: key);

  @override
  State<Setting> createState() => _SettingState();
}

class _SettingState extends State<Setting> {
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
    return WillPopScope(
      onWillPop: () {
        return Future(() => false);
      },
      child: SafeArea(
        child: Scaffold(
            backgroundColor: Theme.of(context).dialogBackgroundColor,
            body: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: (){
                      Navigator.pushNamed(context, '/contact');
                    },
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Container(
                          width: Get.width * 0.3,
                          height: Get.height * 0.04,
                          decoration: BoxDecoration(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(20)),
                            color: Theme.of(context).primaryColor,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(
                                Icons.help,
                                color: AppColors.white,
                              ),
                              const SizedBox(
                                width: 16,
                              ),
                              Text(
                                  AppLocalizations.of(context)!.label_help,
                                style: Theme.of(context)
                                    .textTheme
                                    .headline3!
                                    .copyWith(
                                      color: AppColors.white,
                                    ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 32.0, bottom: 16),
                    child: Text(
                      user.name == null ? AppLocalizations.of(context)!.label_greeting : AppLocalizations.of(context)!.label_greeting+" " + user.name!,
                      style: Theme.of(context)
                          .textTheme
                          .headline3!
                          .copyWith(fontSize: 20),
                    ),
                  ),
                  Container(
                    width: Get.width,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30)),
                      color: Theme.of(context).scaffoldBackgroundColor,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 16.0, right: 16, bottom: 8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 32,
                          ),
                           HeaderTitle(
                            title: AppLocalizations.of(context)!
                                .label_account,
                            description:
                            AppLocalizations.of(context)!
                                .label_account_info,
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(25)),
                              color: Theme.of(context).dialogBackgroundColor,
                            ),
                            child: Column(
                              children: [
                                ButtonOption(
                                  textButton:  AppLocalizations.of(context)!.text_edit_profile,
                                  action: () async {
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
                                      Navigator.pushNamed(
                                          context, '/editProfile');
                                    }
                                  },
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 16.0, right: 16.0),
                                  child: Divider(
                                    height: 0,
                                    color: Theme.of(context).dividerColor,
                                  ),
                                ),
                                ButtonOption(
                                  textButton: AppLocalizations.of(context)!.theme_dark ,
                                  action: () {},
                                  theme: true,
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                           HeaderTitle(
                              title: AppLocalizations.of(context)!
                                  .label_settings,
                              description:
                              AppLocalizations.of(context)!
                                  .label_settings_info,),
                          const SizedBox(
                            height: 8,
                          ),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(25)),
                              color: Theme.of(context).dialogBackgroundColor,
                            ),
                            child: Column(
                              children: [
                                ButtonOption(
                                  textButton: AppLocalizations.of(context)!
                                      .text_select_currency,
                                  action: () {
                                    Navigator.pushNamed(
                                        context, '/settingMoney');
                                  },
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 16.0, right: 16.0),
                                  child: Divider(
                                    height: 0,
                                    color: Theme.of(context).dividerColor,
                                  ),
                                ),
                                ButtonOption(
                                  textButton:  AppLocalizations.of(context)!
                                      .text_delivery_location,
                                  action: () async {
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
                                      await locationController.carregarLocation();
                                      Navigator.pushNamed(
                                          context, '/SettingDestination');
                                    }
                                  },
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                           HeaderTitle(
                              title: AppLocalizations.of(context)!
                                  .label_rede,
                              description:
                              AppLocalizations.of(context)!
                                  .label_rede_info,),
                          const SizedBox(
                            height: 8,
                          ),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(25)),
                              color: Theme.of(context).dialogBackgroundColor,
                            ),
                            child: Column(
                              children: [
                                ButtonOption(
                                  textButton: "Facebook",
                                  action: () async {
                                    var facebookUrl =
                                        'https://www.facebook.com/shopmandabai/';
                                    await launch(facebookUrl);
                                  }
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 16.0, right: 16.0),
                                  child: Divider(
                                    height: 0,
                                    color: Theme.of(context).dividerColor,
                                  ),
                                ),
                                ButtonOption(
                                  textButton: "Instagram",
                                  action: () async {
                                    var facebookUrl =
                                        'https://www.instagram.com/mandabaishop/';
                                    await launch(facebookUrl);
                                  },
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(25)),
                              color: Theme.of(context).dialogBackgroundColor,
                            ),
                            child: Column(
                              children: [
                                ButtonOption(
                                  textButton: AppLocalizations.of(context)!
                                      .text_about_us_and_aplication,
                                  action: () {
                                    Navigator.pushNamed(
                                      context,
                                     '/infoApp'
                                    );
                                  },
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 16.0, right: 16.0),
                                  child: Divider(
                                    height: 0,
                                    color: Theme.of(context).dividerColor,
                                  ),
                                ),
                                ButtonOption(
                                  textButton:AppLocalizations.of(context)!.text_logout,
                                  action: () async {
                                    var result =
                                        await authenticationController.logout();

                                    if (result.success) {
                                      Navigator.of(context)
                                          .pushNamedAndRemoveUntil('/home',
                                              (Route<dynamic> route) => false);
                                    } else {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(
                                        content: Text(
                                          result.errorMessage!,
                                          style: Theme.of(context)
                                              .textTheme
                                              .labelSmall,
                                        ),
                                        backgroundColor:
                                            Theme.of(context).errorColor,
                                      ));
                                    }
                                  },
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            )),
      ),
    );
  }
}
