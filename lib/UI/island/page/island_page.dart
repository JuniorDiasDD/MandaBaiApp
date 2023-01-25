import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:manda_bai/Core/app_images.dart';
import 'package:manda_bai/UI/home/pop_up/popup_message_internet.dart';
import 'package:manda_bai/UI/island/widget/cardIsland.dart';
import 'package:manda_bai/UI/widget/dialogs.dart';
import 'package:manda_bai/constants/controllers.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class IslandPage extends StatefulWidget {
  const IslandPage({Key? key}) : super(key: key);

  @override
  State<IslandPage> createState() => _IslandPageState();
}

class _IslandPageState extends State<IslandPage> {
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
    return  WillPopScope(
      onWillPop: () {
        return Future(() => false);
      },
      child: Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        body: Column(
          children: [
            const Spacer(),
            Text('ESCOLHA A MORABEZA',
                style: Theme.of(context)
                    .textTheme
                    .headline1!
                    .copyWith(color: Colors.white)),
            const SizedBox(
              height: 32,
            ),
            SizedBox(
              width: Get.width,
              child: Center(
                child: Wrap(
                  children: [
                    CardIsland(
                      image: AppImages.santiagoIsland,
                      label: 'Santiago',
                      action: () async {
                        fullControllerController.island.value = 'Santiago';
                        openLoadingIslandStateDialog(context);
                        await fullControllerController.getloadDataHome();
                        Navigator.pop(context);
                        Navigator.pushNamed(context, '/home');
                      },
                    ),
                    CardIsland(
                      image: AppImages.salIsland,
                      label: 'Sal',
                      action: () async {
                        fullControllerController.island.value = 'Sal';
                        openLoadingIslandStateDialog(context);
                        await fullControllerController.getloadDataHome();
                        Navigator.pop(context);
                        Navigator.pushNamed(context, '/home');
                      },
                    ),
                    CardIsland(
                      image: AppImages.maioIsland,
                      label: 'Maio',
                      action: () async {
                        fullControllerController.island.value = 'Maio';
                        openLoadingIslandStateDialog(context);
                        await fullControllerController.getloadDataHome();
                        Navigator.pop(context);
                        Navigator.pushNamed(context, '/home');
                      },
                    ),
                    CardIsland(
                      image: AppImages.saoVicenteIsland,
                      label: 'São Vicente',
                      action: () async {
                        fullControllerController.island.value = 'São Vicente';
                        openLoadingIslandStateDialog(context);
                        await fullControllerController.getloadDataHome();
                        Navigator.pop(context);
                        Navigator.pushNamed(context, '/home');
                      },
                    ),
                    CardIsland(
                      image: AppImages.saoNicolauIsland,
                      label: 'São Nicolau',
                      action: () async {
                        fullControllerController.island.value = 'São Nicolau';
                        openLoadingIslandStateDialog(context);
                        await fullControllerController.getloadDataHome();
                        Navigator.pop(context);
                        Navigator.pushNamed(context, '/home');
                      },
                    ),
                    CardIsland(
                      image: AppImages.santoAntaoIsland,
                      label: 'Santo Antão',
                      action: () async {
                        fullControllerController.island.value = 'Santo Antão';
                        openLoadingIslandStateDialog(context);
                        await fullControllerController.getloadDataHome();
                        Navigator.pop(context);
                        Navigator.pushNamed(context, '/home');
                      },
                    ),
                    CardIsland(
                      image: AppImages.fogoIsland,
                      label: 'Fogo',
                      action: () async {
                        fullControllerController.island.value = 'Fogo';
                        openLoadingIslandStateDialog(context);
                        await fullControllerController.getloadDataHome();
                        Navigator.pop(context);
                        Navigator.pushNamed(context, '/home');
                      },
                    ),
                    CardIsland(
                      image: AppImages.boaVistaIsland,
                      label: 'BoaVista',
                      action: () async {
                        fullControllerController.island.value = 'BoaVista';
                        openLoadingIslandStateDialog(context);
                        await fullControllerController.getloadDataHome();
                        Navigator.pop(context);
                        Navigator.pushNamed(context, '/home');
                      },
                    ),
                    CardIsland(
                      image: AppImages.bravaIsland,
                      label: 'Brava',
                      action: () async {
                        fullControllerController.island.value = 'Brava';
                        openLoadingIslandStateDialog(context);
                        await fullControllerController.getloadDataHome();
                        Navigator.pop(context);
                        Navigator.pushNamed(context, '/home');
                      },
                    ),
                  ],
                ),
              ),
            ),
            const Spacer(),
            Container(
              width: Get.width,
              height: Get.height * 0.15,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(fullControllerController.prefersDarkMode.value
                      ? AppImages.backgroundBlackIsland
                      : AppImages.backgroundIsland),
                  fit: BoxFit.cover,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    const Icon(
                      Icons.message_outlined,
                    ),
                    const SizedBox(
                      width: 16,
                    ),
                    SizedBox(
                      width: Get.width * 0.6,
                      child: Text(
                          'Escolha em qual das ilhas desejas fazer as suas compras',
                          style: Theme.of(context).textTheme.headline4),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
