import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';
import 'package:manda_bai/Core/app_colors.dart';
import 'package:manda_bai/UI/about/components/item_bio.dart';
import 'package:manda_bai/UI/about/components/item_mandatario.dart';
import 'package:manda_bai/UI/home/pop_up/popup_message_internet.dart';
import 'package:manda_bai/UI/widget/base_page.dart';
import 'package:manda_bai/constants/controllers.dart';
import 'package:readmore/readmore.dart';

class InfoMandaBai extends StatefulWidget {
  const InfoMandaBai({Key? key}) : super(key: key);

  @override
  State<InfoMandaBai> createState() => _InfoAppState();
}

class _InfoAppState extends State<InfoMandaBai> {
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
    mandaBaiController.carregarEmployee(context);
    return SafeArea(
      child: BasePage(
        title:    AppLocalizations.of(context)!.title_about_us,
        body: SizedBox(
          height: Get.height*0.87,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    AppLocalizations.of(context)!.text_mandabai,
                    style: Theme.of(context).textTheme.headline1,
                  ),
                ),
                SizedBox(height: Get.height * 0.02),
                ReadMoreText(
                  AppLocalizations.of(context)!.text_description_mandabai,
                  trimLines: 8,
                  colorClickableText: AppColors.greenColor,
                  trimMode: TrimMode.Line,
                  trimCollapsedText:
                  AppLocalizations.of(context)!.readmoretext_see_more,
                  trimExpandedText:
                  AppLocalizations.of(context)!.readmoretext_close,
                  style: Theme.of(context).textTheme.headline4,
                  moreStyle: Theme.of(context).textTheme.headline6,
                ),
                SizedBox(height: Get.height * 0.04),
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    AppLocalizations.of(context)!.subtitle_company_members,
                    style: Theme.of(context).textTheme.headline2,
                  ),
                ),


               Wrap(
                 children: mandaBaiController.listEmployee.map((element) =>  ItemBio(employee: element),).toList(),
               ),
                const SizedBox(height: 20),
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    AppLocalizations.of(context)!
                        .subtitle_representative_members,
                    style: Theme.of(context).textTheme.headline2,
                  ),
                ),
                const SizedBox(height: 10),
                Wrap(
                  children: mandaBaiController.listEmployeeMandatarios.map((element) => ItemMandatario(employee: element),).toList(),
                ),

                SizedBox(height: Get.height * 0.04),
                Container(
                  margin: EdgeInsets.only(
                    left: Get.width * 0.01,
                    right: Get.width * 0.01,
                    top: Get.height * 0.02,
                  ),
                  decoration: BoxDecoration(
                    color: Theme.of(context).cardColor,
                    borderRadius: const BorderRadius.all(
                      Radius.circular(15),
                    ),
                    border: Border.all(
                        color: Colors.black12, width: Get.width * 0.001),
                  ),
                  child: ExpansionTile(
                    backgroundColor: Theme.of(context).cardColor,
                    iconColor: AppColors.greenColor,
                    title: Text(
                      AppLocalizations.of(context)!.subtitle_mission,
                      style: Theme.of(context).textTheme.headline5,
                    ),
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.all(15.0),
                        child: Text(
                          AppLocalizations.of(context)!
                              .text_description_mission,
                          textAlign: TextAlign.start,
                          style: Theme.of(context).textTheme.headline4,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(
                    left: Get.width * 0.01,
                    right: Get.width * 0.01,
                    top: Get.height * 0.02,
                  ),
                  decoration: BoxDecoration(
                    color: Theme.of(context).cardColor,
                    borderRadius: const BorderRadius.all(
                      Radius.circular(15),
                    ),
                    border: Border.all(
                        color: Colors.black12, width: Get.width * 0.001),
                  ),
                  child: ExpansionTile(
                    backgroundColor: Theme.of(context).cardColor,
                    iconColor: AppColors.greenColor,
                    title: Text(
                      AppLocalizations.of(context)!.subtitle_vision,
                      style: Theme.of(context).textTheme.headline5,
                    ),
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.all(15.0),
                        child: Text(
                          AppLocalizations.of(context)!
                              .text_description_vision,
                          textAlign: TextAlign.start,
                          style: Theme.of(context).textTheme.headline4,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(
                    left: Get.width * 0.01,
                    right: Get.width * 0.01,
                    top: Get.height * 0.02,
                  ),
                  decoration: BoxDecoration(
                    color: Theme.of(context).cardColor,
                    borderRadius: BorderRadius.all(
                      Radius.circular(15),
                    ),
                    border: Border.all(
                        color: Colors.black12, width: Get.width * 0.001),
                  ),
                  child: ExpansionTile(
                    backgroundColor: Theme.of(context).cardColor,
                    iconColor: AppColors.greenColor,
                    title: Text(
                      AppLocalizations.of(context)!.subtitle_values,
                      style: Theme.of(context).textTheme.headline5,
                    ),
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.all(15.0),
                        child: Text(
                            AppLocalizations.of(context)!
                                .text_description_values,
                            textAlign: TextAlign.start,
                            style: Theme.of(context).textTheme.headline4),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: Get.height * 0.03),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
