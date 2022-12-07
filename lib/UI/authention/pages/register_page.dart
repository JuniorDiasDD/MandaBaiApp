import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:manda_bai/Core/app_colors.dart';
import 'package:manda_bai/Core/app_images.dart';
import 'package:manda_bai/UI/home/pop_up/pop_up_message.dart';
import 'package:manda_bai/UI/home/pop_up/popup_message_internet.dart';
import 'package:manda_bai/UI/intro/components/colored_circle_component.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:manda_bai/UI/widget/TextFormField.dart';
import 'package:manda_bai/UI/widget/button_ui.dart';
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


  String mensage_password = " ";
  Color cor_password = Colors.transparent;



  _validar_password() {
    if (authenticationController.input_senha.text.length < 7) {
      setState(() {
        mensage_password = AppLocalizations.of(context)!.message_password_weak;
        cor_password = Colors.red;
      });
    } else if (RegExp(r'\d+\w*\d+').hasMatch(authenticationController.input_senha.text) &&
        !authenticationController.input_senha.text.contains(RegExp(r'[A-Z]'))) {
      setState(() {
        mensage_password =
            AppLocalizations.of(context)!.message_password_reasonable;
        cor_password = Colors.yellowAccent;
      });
    } else if (authenticationController.input_senha.text.contains(RegExp(r'[A-Z]'))) {
      setState(() {
        mensage_password =
            AppLocalizations.of(context)!.message_password_strong;
        cor_password = Colors.green;
      });
    }
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
               /* Stack(
                  children: [
                    Align(
                      alignment: Alignment.bottomLeft,
                      child: ColoredCircleComponent(),
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      margin: const EdgeInsets.only(top: 33.0),
                      width: Get.width,
                      child: TextButton(child:Text('< '+AppLocalizations.of(context)!.button_register,
                        style: Theme.of(context).textTheme.headline3,),onPressed: ()=> Navigator.pop(context),)
                    ),
                  ],
                ),*/
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
                              child: TextFormFieldCustom(
                                  textController: authenticationController.input_nome,
                                  hintText: AppLocalizations.of(context)!
                                      .textfield_name,
                                  requiredLabel: AppLocalizations.of(context)!
                                      .validator_name),
                            ),
                            SizedBox(
                              width: Get.width * 0.43,
                              child: TextFormFieldCustom(
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
                              child: TextFormFieldCustom(
                                  textController: authenticationController.input_country,
                                  hintText: AppLocalizations.of(context)!
                                      .textfield_country,
                                  requiredLabel: AppLocalizations.of(context)!
                                      .validator_country),
                            ),
                            SizedBox(
                              width: Get.width * 0.43,
                              child: TextFormFieldCustom(
                                  textController: authenticationController.input_city,
                                  hintText: AppLocalizations.of(context)!
                                      .textfield_city,
                                  requiredLabel: AppLocalizations.of(context)!
                                      .validator_city),
                            ),
                          ],
                        ),
                        SizedBox(height: Get.height * 0.01),
                        TextFormFieldCustom(
                          textController: authenticationController.input_email,
                          hintText: 'Email',
                          requiredLabel:
                              AppLocalizations.of(context)!.validator_email,
                          icon: Icons.email,
                          checkEmail: true,
                          keyboardType: TextInputType.emailAddress,
                        ),
                        SizedBox(height: Get.height * 0.01),
                        TextFormFieldCustom(
                          textController: authenticationController.input_telefone,
                          hintText:
                              AppLocalizations.of(context)!.textfield_phone,
                          requiredLabel:
                              AppLocalizations.of(context)!.validator_number,
                          keyboardType: TextInputType.number,
                          icon: Icons.phone,
                        ),
                        SizedBox(height: Get.height * 0.01),
                        TextFormFieldCustom(
                          textController: authenticationController.input_username,
                          hintText:
                              AppLocalizations.of(context)!.textfield_user,
                          requiredLabel:
                              AppLocalizations.of(context)!.validator_user,
                          keyboardType: TextInputType.name,
                          icon: Icons.person,
                        ),
                        SizedBox(height: Get.height * 0.01),
                        Obx(
                          ()=>TextFormField(
                            controller: authenticationController.input_senha,
                            obscureText: authenticationController.statePassword.value,
                            style: Theme.of(context).textTheme.headline4,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: AppColors.grey50.withOpacity(0.5),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(20.0),
                                ),
                                borderSide: BorderSide(
                                    color: AppColors.black_claro.withOpacity(0.4),
                                    width: 0.0),
                              ),
                              prefixIcon: const Padding(
                                padding: EdgeInsets.all(0.0),
                                child: Icon(
                                  Icons.lock,
                                  color: Colors.grey,
                                ), // icon is 48px widget.
                              ),
                              suffixIcon: IconButton(
                                onPressed: () {
                                  setState(() {
                                    authenticationController.statePassword.value = !authenticationController.statePassword.value;
                                  });
                                },
                                icon: Icon(
                                  authenticationController.statePassword.value
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                ),
                              ),
                              labelText: AppLocalizations.of(context)!
                                  .textfield_password,
                              labelStyle: Theme.of(context).textTheme.headline4,
                            ),
                            validator: (value) => value!.isEmpty
                                ? AppLocalizations.of(context)!.validator_password
                                : null,
                            onChanged: (value) => _validar_password(),
                          ),
                        ),
                        SizedBox(height: Get.height * 0.005),
                        Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            mensage_password,
                            style: Theme.of(context)
                                .textTheme
                                .headline4!
                                .copyWith(color: cor_password),
                          ),
                        ),
                        SizedBox(
                          height: Get.height * 0.02,
                        ),
                        ButtonUI(
                          label: AppLocalizations.of(context)!.button_register,
                          action: () async {
                            bool check=  await authenticationController.validateAndSave();
                            if (check == true) {
                              authenticationController.loading.value=false;
                               showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return Pop_up_Message(
                                        mensagem:
                                        AppLocalizations.of(context)!.message_success_register,
                                        icon: Icons.check,
                                        caminho: "registo");
                                  });
                            } else {
                              authenticationController.loading.value=false;
                               showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return Pop_up_Message(
                                        mensagem:
                                        AppLocalizations.of(context)!.message_error_register,
                                        icon: Icons.error,
                                        caminho: "erro");
                                  });
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
          Obx(
            ()=> SizedBox(
              child: authenticationController.loading.value
                  ? Container(
                      color: Colors.black54,
                      height: Get.height,
                      child: Center(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.network(
                              AppImages.loading,
                              width: Get.width * 0.2,
                              height: Get.height * 0.2,
                              alignment: Alignment.center,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              AppLocalizations.of(context)!.loading_time,
                              textAlign: TextAlign.center,
                              style: Theme.of(context)
                                  .textTheme
                                  .headline3!
                                  .copyWith(color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                    )
                  : null,
            ),
          ),
        ],
      ),
    );
  }
}
