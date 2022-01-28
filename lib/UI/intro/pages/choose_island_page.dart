
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:manda_bai/Core/app_images.dart';
import 'package:manda_bai/UI/home/pop_up/popup_message_internet.dart';
import 'package:manda_bai/UI/intro/components/colored_circle_component.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class ChooseIsland extends StatefulWidget {
  const ChooseIsland({Key? key}) : super(key: key);

  @override
  _ChooseIslandState createState() => _ChooseIslandState();
}

class _ChooseIslandState extends State<ChooseIsland> {
  ConnectivityResult _connectionStatus = ConnectivityResult.none;
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;
  int net=0;
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
        net=1;
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return PopupMessageInternet(
                  mensagem: AppLocalizations.of(context)!.message_erro_internet,
                  icon: Icons.signal_wifi_off);
            });
      } else {
    if(net!=0){
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
  String dropdownValue = 'Santiago';
  List<String> list_island = [
    'Santo Antão',
    'São Vicente',
    'São Nicolau',
    'Sal',
    'Boa Vista',
    'Maio',
    'Santiago',
    'Fogo',
    'Brava',
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
       
        children: [
          Align(
            alignment: Alignment.bottomLeft,
            child: ColoredCircleComponent(),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20.0, right: 20.0),
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.topRight,

                  child:Image.network(
                    AppImages.ilhas,
                    height: Get.height * 0.4,
                    width: Get.width * 0.99,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: Get.height * 0.1),
          Container(
            width: Get.width,
            height: Get.height * 0.06,
            margin: EdgeInsets.only(
              left: Get.width * 0.04,
              right: Get.width * 0.04,
            ),
            padding: EdgeInsets.only(
              left: Get.width * 0.04,
              right: Get.width * 0.04,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15.0),
              border: Border.all(
                  color: Theme.of(context).indicatorColor, style: BorderStyle.solid, width: 0.80),
            ),
            child: DropdownButton<String>(
              value: dropdownValue,
              icon: const Icon(
                Icons.arrow_drop_down,
              ),
              iconSize: Get.width * 0.05,
              elevation: 16,
              style: Theme.of(context).textTheme.headline4,
              borderRadius: BorderRadius.circular(15.0),
              underline: Container(
                height: 0,
                color: Colors.transparent,
              ),
              onChanged: (String? newValue) {
                setState(() {
                  dropdownValue = newValue!;
                });
              },
              items: list_island.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(
                    value,
                    style: Theme.of(context).textTheme.headline4,
                  ),
                );
              }).toList(),
            ),
          ),
          SizedBox(height: Get.height * 0.2),
        ],
      ),
      bottomNavigationBar: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Spacer(),
          Padding(
            padding: EdgeInsets.only(
              right: 15,
              bottom: 10,
            ),
            child: TextButton(
              onPressed: () {
                _navigacao();
              },
              child: Text(
                AppLocalizations.of(context)!.textbutton_next+ ">",
                style: Theme.of(context).textTheme.headline5,
              ),
            ),
          ),
        ],
      ),
    );
  }

  _navigacao() async {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('onboarding', 'true');
    await prefs.setString('island', dropdownValue);
    Navigator.pushReplacementNamed(context, '/home');
  }
}
