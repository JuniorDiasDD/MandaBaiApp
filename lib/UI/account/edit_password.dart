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

class EditPasswordPage extends StatefulWidget {
  const EditPasswordPage({Key? key}) : super(key: key);

  @override
  _EditPasswordPageState createState() => _EditPasswordPageState();
}

class _EditPasswordPageState extends State<EditPasswordPage> {
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
    return SafeArea(
      child: Scaffold(
        body: Form(
          key: authenticationController.formKeyEditPassword,
          child: SizedBox(
            height: Get.height,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 8,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                        child: Text(
                          '< ' +
                              AppLocalizations.of(context)!.text_edit_password,
                          style: Theme
                              .of(context)
                              .textTheme
                              .headline3,
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        CustomTextFieldObscure(
                          requiredLabel: AppLocalizations.of(context)!
                              .validator_empty_field,
                          hintText: AppLocalizations.of(context)!
                              .label_current_password,
                          textController: authenticationController
                              .input_senhaCurrent,
                        ),
                        const SizedBox(height: 16),
                        CustomTextFieldObscure(
                          requiredLabel: AppLocalizations.of(context)!
                              .validator_empty_field,
                          hintText: AppLocalizations.of(context)!
                              .title_new_password,
                          textController: authenticationController.input_senha,
                        ),
                        const SizedBox(height: 16),
                        CustomTextFieldObscure(
                          requiredLabel: AppLocalizations.of(context)!
                              .validator_empty_field,
                          hintText: AppLocalizations.of(context)!
                              .label_confirm_password,
                          textController: authenticationController
                              .input_senhaConf,
                        ),

                      ],
                    ),
                  ),
                  const Spacer(),
                  ButtonUI(
                    label: AppLocalizations.of(context)!.button_update,
                    action: () async {
                      openLoadingStateDialog(context);
                      var result = await authenticationController
                          .validateEditPassword(context);
                      Navigator.pop(context);
                      if (result.success) {
                        Navigator.pop(context);
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text(
                            result.errorMessage!,
                            style: Theme
                                .of(context)
                                .textTheme
                                .labelSmall,
                          ),
                          backgroundColor: Theme
                              .of(context)
                              .errorColor,
                        ));
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
