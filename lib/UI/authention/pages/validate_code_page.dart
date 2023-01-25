import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:manda_bai/UI/home/pop_up/popup_message_internet.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:manda_bai/UI/widget/dialogs.dart';
import 'package:manda_bai/constants/controllers.dart';

class ValidateCode extends StatefulWidget {
  const ValidateCode({Key? key}) : super(key: key);

  @override
  _ValidateCodeState createState() => _ValidateCodeState();
}

class _ValidateCodeState extends State<ValidateCode> {
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
    authenticationController.startTimer();
  }

  @override
  void dispose() {
    _connectivitySubscription.cancel();
    authenticationController.timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
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
                        child: IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: const Icon(
                            Icons.arrow_back,
                            color: Colors.black,
                          ),
                          alignment: Alignment.topLeft,
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
                  key: authenticationController.formKeyValidateCode,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 33.0),
                        child: Text(
                          AppLocalizations.of(context)!.title_validate_code,
                          style: Theme.of(context).textTheme.headline1,
                        ),
                      ),
                      SizedBox(height: Get.height * 0.02),
                      Text(
                        AppLocalizations.of(context)!
                                .descriction_validate_code +
                            ": " +
                            authenticationController.input_email.text,
                        style: Theme.of(context).textTheme.headline4,
                      ),
                      SizedBox(height: Get.height * 0.01),
                      TextButton(
                        onPressed: () async {
                          if (authenticationController.segundo.value == 0 &&
                              authenticationController.minuto.value == 0) {
                            openLoadingStateDialog(context);
                            var result = await authenticationController
                                .newPassword(context);
                            Navigator.pop(context);
                            if (result.success) {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                content: Text(
                                  'Codigo Enviado',
                                  style: Theme.of(context).textTheme.labelSmall,
                                ),
                                backgroundColor: Colors.green,
                              ));

                              Navigator.pushNamed(context, '/setPasswordPage');
                            } else {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                content: Text(
                                  result.errorMessage!,
                                  style: Theme.of(context).textTheme.labelSmall,
                                ),
                                backgroundColor: Theme.of(context).errorColor,
                              ));
                            }
                          }
                        },
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            AppLocalizations.of(context)!.reenviar_code,
                            style: authenticationController.minuto.value == 0 &&
                                    authenticationController.segundo.value == 0
                                ? Theme.of(context).textTheme.headline5
                                : Theme.of(context).textTheme.headline4,
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          const Icon(
                            Icons.access_time,
                            color: Colors.grey,
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Obx(
                            () => Text(
                              authenticationController.minuto.value.toString() +
                                  ":" +
                                  authenticationController.segundo.value
                                      .toString(),
                              style: Theme.of(context).textTheme.headline4,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: Get.height * 0.02),
                      SizedBox(height: Get.height * 0.01),
                      Padding(
                        padding: EdgeInsets.only(
                          left: Get.width * 0.2,
                          right: Get.width * 0.2,
                        ),
                        child: TextFormField(
                          obscureText: false,
                          controller: authenticationController.resetCode,
                          style: Theme.of(context)
                              .textTheme
                              .headline4!
                              .copyWith(fontSize: Get.height * 0.04),
                          keyboardType: TextInputType.number,
                          textAlign: TextAlign.center,
                          maxLength: 4,
                          validator: (value) => value!.isEmpty
                              ? AppLocalizations.of(context)!
                                  .validator_validate_code
                              : null,
                          onChanged: (value) async {
                            if (value.length == 4) {
                              openLoadingStateDialog(context);
                              var result = await authenticationController
                                  .validateCodePassword(context);
                              Navigator.pop(context);

                              if (result.success) {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(SnackBar(
                                  content: Text(
                                    AppLocalizations.of(context)!
                                        .description_new_password,
                                    style:
                                        Theme.of(context).textTheme.labelSmall,
                                  ),
                                  backgroundColor: Colors.green,
                                ));

                                Navigator.pushNamed(
                                    context, '/setPasswordPage');
                              } else {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(SnackBar(
                                  content: Text(
                                    result.errorMessage!,
                                    style:
                                        Theme.of(context).textTheme.labelSmall,
                                  ),
                                  backgroundColor: Theme.of(context).errorColor,
                                ));
                              }
                            }
                          },
                        ),
                      ),
                      SizedBox(
                        height: Get.height * 0.05,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ]),
    );
  }
}
