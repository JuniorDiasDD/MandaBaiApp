import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:manda_bai/Core/app_colors.dart';
import 'package:manda_bai/Core/app_fonts.dart';
import 'package:manda_bai/Core/app_images.dart';
import 'package:manda_bai/UI/home/pop_up/popup_message_internet.dart';
import 'package:manda_bai/UI/intro/pages/onboarding_page.dart';
import 'package:manda_bai/constants/controllers.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../data/config.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  ConnectivityResult _connectionStatus = ConnectivityResult.none;
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;
  int net = 0;

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
        setState(() {
          net = 1;
        });
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return PopupMessageInternet(
                  mensagem: AppLocalizations.of(context)!.message_erro_internet,
                  icon: Icons.signal_wifi_off);
            });
      } else {
        if (net == 1) {
          Navigator.pop(context);
        }
      /*  String versionStore = "";
        setState(() async {
          versionStore = await fullControllerController.getVersion();
          print("---" + versionStore);
        });*/
        //check version
        Future.delayed(Duration(seconds: 2)).then((_) async {
         String versionStore = await fullControllerController.getVersion();
          if (versionApp == versionStore) {
            final SharedPreferences prefs =
                await SharedPreferences.getInstance();
            var check = prefs.getString('onboarding');
            await fullControllerController.getInit();
            if (check.toString() == 'true' && check != null) {
              Navigator.pushReplacementNamed(context, '/home');
            } else {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => OnboardingPage()));
            }
          } else {
            Navigator.pushReplacementNamed(context, '/updateApp');
          }
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: Get.width,
            height: Get.height * 0.14,
            child: Image.asset(AppImages.appLogo),
          ),
        ],
      ),
      bottomNavigationBar: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.only(
              bottom: Get.height * 0.04,
            ),
            child: const Text(
              "Powered by MandaBai",
              style: TextStyle(
                  fontFamily: AppFonts.poppinsRegularFont,
                  color: AppColors.greenColor),
            ),
          ),
        ],
      ),
    );
  }
}
