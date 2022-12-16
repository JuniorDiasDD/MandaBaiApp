import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:manda_bai/Core/app_images.dart';
import 'package:manda_bai/UI/home/pop_up/popup_message_internet.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:manda_bai/UI/widget/button_ui.dart';
import 'package:manda_bai/UI/widget/custom_text_field.dart';
import 'package:manda_bai/UI/widget/custom_text_field_obscure.dart';
import 'package:manda_bai/UI/widget/dialogs.dart';
import 'package:manda_bai/constants/controllers.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
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

                Container(
                    alignment: Alignment.centerLeft,
                    margin: const EdgeInsets.only(top: 33.0),
                    width: Get.width,
                    child: TextButton(child:Text('< '+AppLocalizations.of(context)!.button_register,
                      style: Theme.of(context).textTheme.headline3,),onPressed: ()=> Navigator.pop(context),)
                ),
                Image.asset(
                  AppImages.appLogoIcon,
                  width: Get.width * 0.6,
                  height: Get.height * 0.1,
                ),
                SizedBox(
                  height: Get.height * 0.03,
                ),
                Padding(
                  padding: EdgeInsets.only(
                    left: Get.width * 0.05,
                    right: Get.width * 0.05,
                  ),
                  child: Form(
                    key: authenticationController.formKey,
                    child: Column(
                      children: [
                        Text(
                          AppLocalizations.of(context)!.text_registre,
                          style: Theme.of(context).textTheme.headline2,
                        ),
                        SizedBox(
                          height: Get.height * 0.02,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: Get.width * 0.43,
                              child: CustomTextField(
                                  textController: authenticationController.input_nome,
                                  hintText: AppLocalizations.of(context)!
                                      .textfield_name,
                                  requiredLabel: AppLocalizations.of(context)!
                                      .validator_name),
                            ),
                            SizedBox(
                              width: Get.width * 0.43,
                              child: CustomTextField(
                                  textController: authenticationController.input_nickname,
                                  hintText: AppLocalizations.of(context)!
                                      .textfield_nickname,
                                  requiredLabel: AppLocalizations.of(context)!
                                      .validator_nickname),
                            ),
                          ],
                        ),
                        SizedBox(height: Get.height * 0.01),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: Get.width * 0.43,
                              child: CustomTextField(
                                  textController: authenticationController.input_country,
                                  hintText: AppLocalizations.of(context)!
                                      .textfield_country,
                                  requiredLabel: AppLocalizations.of(context)!
                                      .validator_country),
                            ),
                            SizedBox(
                              width: Get.width * 0.43,
                              child: CustomTextField(
                                  textController: authenticationController.input_city,
                                  hintText: AppLocalizations.of(context)!
                                      .textfield_city,
                                  requiredLabel: AppLocalizations.of(context)!
                                      .validator_city),
                            ),
                          ],
                        ),
                        SizedBox(height: Get.height * 0.01),
                        CustomTextField(
                          textController: authenticationController.input_email,
                          hintText: 'Email',
                          requiredLabel:
                              AppLocalizations.of(context)!.validator_email,
                          icon: Icons.email,
                          keyboardType: TextInputType.emailAddress,
                        ),
                        SizedBox(height: Get.height * 0.01),
                        CustomTextField(
                          textController: authenticationController.input_telefone,
                          hintText:
                              AppLocalizations.of(context)!.textfield_phone,
                          requiredLabel:
                              AppLocalizations.of(context)!.validator_number,
                          keyboardType: TextInputType.number,
                          icon: Icons.phone,
                        ),
                        SizedBox(height: Get.height * 0.01),
                        CustomTextField(
                          textController: authenticationController.input_username,
                          hintText:
                              AppLocalizations.of(context)!.textfield_user,
                          requiredLabel:
                              AppLocalizations.of(context)!.validator_user,
                          keyboardType: TextInputType.name,
                          icon: Icons.person,
                        ),
                        SizedBox(height: Get.height * 0.01),
                        CustomTextFieldObscure(
                          requiredLabel: AppLocalizations.of(context)!
                              .validator_password,
                          hintText: AppLocalizations.of(context)!
                              .textfield_password,
                          textController: authenticationController
                              .input_senha,
                        ),

                        SizedBox(height: Get.height * 0.005),
                        ButtonUI(
                          label: AppLocalizations.of(context)!.button_register,
                          action: () async {
                            openLoadingLongStateDialog(context);
                            var result=  await authenticationController.validateAndSave(context);
                            Navigator.pop(context);
                            if (result.success) {
                              Navigator.pushReplacementNamed(
                                  context, '/login');
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
                        SizedBox(height: Get.height * 0.02),
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
