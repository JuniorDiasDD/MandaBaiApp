import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:manda_bai/Controller/request.dart';
import 'package:manda_bai/Core/app_images.dart';
import 'package:manda_bai/Model/location.dart';
import 'package:manda_bai/UI/home/pop_up/popup_message_internet.dart';
import 'package:manda_bai/UI/location_destination/components/item_location.dart';
import 'package:manda_bai/UI/location_destination/page/new_destination.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:manda_bai/UI/widget/base_page.dart';
import 'package:manda_bai/constants/controllers.dart';

class DestinationPage extends StatefulWidget {
  const DestinationPage({Key? key}) : super(key: key);

  @override
  _Destination_PageState createState() => _Destination_PageState();
}

class _Destination_PageState extends State<DestinationPage> {
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
    return BasePage(
      title: AppLocalizations.of(context)!.text_delivery_location,
      actionHeader: TextButton(
        onPressed: () {
          locationController.cleanInptus();
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const NewDestination(location: null)));
        },
        child: Row(
          children: [
            Text(
              AppLocalizations.of(context)!.new_address,
              style: Theme.of(context).textTheme.headline2,
            ),
            const Icon(
              Icons.add,
            ),
          ],
        ),
      ),
      body: SizedBox(
        height: Get.height * 0.9,
        child: Obx(
          () => locationController.listLocation.isEmpty
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      AppLocalizations.of(context)!.text_no_locations,
                      style: Theme.of(context).textTheme.headline3,
                    ),
                    Text(
                      AppLocalizations.of(context)!.text_add_new_location,
                      style: Theme.of(context).textTheme.headline3,
                    ),
                  ],
                )
              : ListView.builder(
                  padding: EdgeInsets.only(
                    top: 0.0,
                    bottom: Get.height * 0.03,
                  ),
                  scrollDirection: Axis.vertical,
                  itemCount: locationController.listLocation.length,
                  itemBuilder: (BuildContext context, index) {
                    var element = locationController.listLocation[index];
                    return ItemLocation(location: element,select: false,);
                  },
                ),
        ),
      ),

    );
  }
}
