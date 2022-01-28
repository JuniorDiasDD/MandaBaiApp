import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:manda_bai/UI/home/pop_up/popup_message_internet.dart';

class Privacy_Policy extends StatefulWidget {

  int info;

 Privacy_Policy({Key? key, required this.info}) : super(key: key);

  @override
  State<Privacy_Policy> createState() => _Privacy_PolicyState();
}

class _Privacy_PolicyState extends State<Privacy_Policy> {
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
    return Scaffold(
      body: Padding(
        padding:
            EdgeInsets.only(left: Get.width * 0.04, right: Get.width * 0.04),
        child: SingleChildScrollView(
          child: Column(children: [
            SizedBox(height: Get.height * 0.08),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  child: IconButton(
                    // padding: EdgeInsets.all(0.0),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(
                      Icons.arrow_back,
                    ),
                    alignment: Alignment.centerRight,
                  ),
                ),

                Text(
                  widget.info==0?AppLocalizations.of(context)!
                      .title_privacy_police:AppLocalizations.of(context)!
                      .title_terms_of_use,
                  style: Theme.of(context).textTheme.headline1,
                ),
                Container(
                  width: Get.width * 0.03,
                ),
              ],
            ),
            SizedBox(height: Get.height * 0.03),
            Padding(
              padding:  EdgeInsets.only(
                left: Get.width * 0.01, right: Get.width * 0.01,),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      widget.info==0?AppLocalizations.of(context)!
                          .subtitle_privacy_police:AppLocalizations.of(context)!
                          .subtitle_terms_of_use,
                        style: Theme.of(context).textTheme.headline2,
                    ),
                  ),
                  SizedBox(height: Get.height * 0.01),
                   Html(
                    data: widget.info == 0
                        ? AppLocalizations.of(context)!
                        .text_privacy_police:AppLocalizations.of(context)!
                        .text_terms_of_use,
                       //  style: TextStyle(Theme.of(context).textTheme.headline1),
                  ),
                ],
              ),
            )
          ],
          ),
        ),
      ),
    );
  }
}
