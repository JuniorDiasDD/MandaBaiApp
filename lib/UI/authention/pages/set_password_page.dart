import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:manda_bai/UI/home/pop_up/popup_message_internet.dart';
import 'package:manda_bai/UI/widget/button_ui.dart';
import 'package:manda_bai/UI/widget/custom_text_field_obscure.dart';
import 'package:manda_bai/UI/widget/dialogs.dart';
import 'package:manda_bai/constants/controllers.dart';

class SetPasswordPage extends StatefulWidget {
  const SetPasswordPage({Key? key}) : super(key: key);

  @override
  _SetPasswordPageState createState() => _SetPasswordPageState();
}

class _SetPasswordPageState extends State<SetPasswordPage> {
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
                    key: authenticationController.formKeyEditPassword,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 33.0),
                          child: Text(
                            AppLocalizations.of(context)!.title_new_password,
                            style: Theme.of(context).textTheme.headline1,
                          ),
                        ),
                        SizedBox(height: Get.height * 0.02),
                        Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            AppLocalizations.of(context)!
                                .description_new_password,
                            style: Theme.of(context).textTheme.headline4,
                          ),
                        ),
                        SizedBox(height: Get.height * 0.02),
                        SizedBox(height: Get.height * 0.01),
                        CustomTextFieldObscure(
                          requiredLabel: AppLocalizations.of(context)!
                              .validator_empty_field,
                          hintText:
                              AppLocalizations.of(context)!.textfield_password,
                          textController: authenticationController.input_senha,
                        ),
                        SizedBox(height: Get.height * 0.01),
                        CustomTextFieldObscure(
                          requiredLabel: AppLocalizations.of(context)!
                              .validator_empty_field,
                          hintText: AppLocalizations.of(context)!
                              .label_confirm_password,
                          textController:
                              authenticationController.input_senhaConf,
                        ),
                        SizedBox(
                          height: Get.height * 0.05,
                        ),
                        ButtonUI(
                          label: AppLocalizations.of(context)!.button_send,
                          action: () async {
                            openLoadingStateDialog(context);
                            var result = await authenticationController
                                .createNewPassword(context);
                            Navigator.pop(context);
                            if (result.success) {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                content: Text(
                                  AppLocalizations.of(context)!
                                      .message_success_update,
                                  style: Theme.of(context).textTheme.labelSmall,
                                ),
                                backgroundColor: Colors.green,
                              ));
                              Navigator.pushNamedAndRemoveUntil(context,
                                  '/login', (Route<dynamic> route) => false);
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
