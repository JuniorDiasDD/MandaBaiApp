import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:manda_bai/Core/app_images.dart';
import 'package:manda_bai/UI/home/pop_up/popup_message_internet.dart';
import 'package:manda_bai/UI/intro/widget/template_onboarding.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnboardingTreePage extends StatefulWidget {
  const OnboardingTreePage({Key? key}) : super(key: key);

  @override
  State<OnboardingTreePage> createState() => _OnboardingTreePageState();
}

class _OnboardingTreePageState extends State<OnboardingTreePage> {
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
    return TemplateOnboarding(
      image: AppImages.onboarding3,
      description: 'Fazi bu familia de bu terra feliz! ',
      title:AppLocalizations.of(context)!
          .family,
      actionButton: ()async{
        final SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('onboarding','true');
        Navigator.pushReplacementNamed(context, '/island');
      },
      actionButtonTop: ()async{
        final SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('onboarding','true');
        Navigator.pushNamed(context, '/login');
      },
      buttonTopLabel: AppLocalizations.of(context)!.login_registar,
      position: 3,


    );
  }
}
