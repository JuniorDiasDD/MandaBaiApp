import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:manda_bai/UI/home/pop_up/popup_message_internet.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:manda_bai/UI/widget/button_ui.dart';
import 'package:manda_bai/UI/widget/custom_text_field.dart';
import 'package:manda_bai/UI/widget/dialogs.dart';
import 'package:manda_bai/constants/controllers.dart';

class RecoveryPassword extends StatefulWidget {
  const RecoveryPassword({Key? key}) : super(key: key);

  @override
  _RecoveryPasswordState createState() => _RecoveryPasswordState();
}

class _RecoveryPasswordState extends State<RecoveryPassword> {
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
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Stack(
                  children: [

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(top: 33.0),
                          child: TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          child: Text(
                            "< "+AppLocalizations.of(context)!.text_forgot_password,
                            style: Theme.of(context).textTheme.headline1,
                          ),
                          ),
                        ),
                        const Spacer(),
                      ],
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(
                    left: Get.width * 0.05,
                    right: Get.height * 0.05,
                  ),
                  child: Form(
                    key: authenticationController.formKey,
                    child: Column(
                      children: [

                        SizedBox(height: Get.height * 0.02),
                        Text(
                          AppLocalizations.of(context)!.text_reset_password,
                          style: Theme.of(context).textTheme.headline2,
                        ),

                        const SizedBox(height: 32),
                        CustomTextField(
                          textController: authenticationController.input_email,
                          hintText: 'Email',
                          requiredLabel:
                          AppLocalizations.of(context)!.validator_email,
                          icon: Icons.email,
                          keyboardType: TextInputType.emailAddress,
                        ),

                      const  SizedBox(
                          height: 16,
                        ),
                        ButtonUI(
                          label:
                          AppLocalizations.of(context)!.button_send,
                          action: () async {
                            openLoadingStateDialog(context);
                            var result=await authenticationController.sendEmail(context);
                            Navigator.pop(context);
                            if (result.success) {
                              Navigator.pushNamed(
                                  context, '/validateCodePassword');
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: Text(
                                  result.errorMessage!,
                                  style: Theme.of(context).textTheme.labelSmall,
                                ),
                                backgroundColor: Theme.of(context).errorColor,
                              ));
                            }
                          },
                        ),

                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

        ],
      ),
    );
  }
}
