import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:manda_bai/Core/app_colors.dart';
import 'package:manda_bai/Core/app_fonts.dart';
import 'package:manda_bai/Core/app_images.dart';
import 'package:manda_bai/UI/home/pop_up/popup_message_internet.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:manda_bai/UI/widget/TextFormField.dart';
import 'package:manda_bai/UI/widget/button_ui.dart';
import 'package:manda_bai/UI/widget/dialogs.dart';
import 'package:manda_bai/constants/controllers.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
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
    authenticationController.input_senhaLogin.clear();
    authenticationController.input_usernameLogin.clear();
  }

  @override
  void dispose() {
    _connectivitySubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(
              children: [
                Image.network(
                  "https://santiago.mandabai.com/wp-content/uploads/2022/11/santiagoBackground.jpeg",
                  fit: BoxFit.cover,
                  width: Get.width,
                  height: Get.height,
                  color: Colors.grey.withOpacity(1),
                  colorBlendMode: BlendMode.modulate,
                ),
                SizedBox(
                  height: Get.height * 0.9,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: Get.height * 0.02,
                      ),
                      Image.asset(
                        AppImages.appLogoIcon,
                        width: Get.width * 0.6,
                        height: Get.height * 0.15,
                      ),
                      const SizedBox(height: 16),

                      Padding(
                        padding: EdgeInsets.only(
                          left: Get.width * 0.05,
                          right: Get.width * 0.05,
                        ),
                        child: Form(
                          key: authenticationController.formKeyLogin,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                AppLocalizations.of(context)!
                                    .info_island_login+ fullControllerController.island.value,
                                style: Theme.of(context)
                                    .textTheme
                                    .headline4!
                                    .copyWith(
                                    fontStyle: FontStyle.italic,
                                    color: Colors.white,decoration: TextDecoration.underline),
                              ),
                              const SizedBox(height: 16),
                              TextFormFieldCustom(
                                textController: authenticationController
                                    .input_usernameLogin,
                                hintText: AppLocalizations.of(context)!
                                    .textfield_user,
                                requiredLabel: AppLocalizations.of(context)!
                                    .validator_user,
                                keyboardType: TextInputType.name,
                                icon: Icons.person,
                                login: true,
                              ),
                              const SizedBox(height: 8),
                              Obx(
                                () => TextFormField(
                                  controller:
                                      authenticationController.input_senhaLogin,
                                  obscureText: authenticationController
                                      .statePasswordLogin.value,
                                  style: Theme.of(context).textTheme.headline4!.copyWith(color:Colors.black),
                                  decoration: InputDecoration(
                                    filled: true,
                                    fillColor:
                                        AppColors.grey50.withOpacity(0.8),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: const BorderRadius.all(
                                        Radius.circular(20.0),
                                      ),
                                      borderSide: BorderSide(
                                          color: AppColors.black_claro
                                              .withOpacity(0.4),
                                          width: 0.0),
                                    ),
                                    focusedBorder: const OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(20.0)),
                                        borderSide: BorderSide(
                                            color: AppColors.greenColor)),
                                    prefixIcon: const Padding(
                                      padding: EdgeInsets.all(0.0),
                                      child: Icon(
                                        Icons.lock,
                                        color: Colors.black54,
                                      ), // icon is 48px widget.
                                    ),
                                    suffixIcon: IconButton(
                                      onPressed: () {
                                        setState(() {
                                          authenticationController
                                                  .statePasswordLogin.value =
                                              !authenticationController
                                                  .statePasswordLogin.value;
                                        });
                                      },
                                      icon: Icon(
                                        !authenticationController
                                                .statePasswordLogin.value
                                            ? Icons.visibility_off
                                            : Icons.visibility,
                                        color: Theme.of(context).primaryColor,
                                      ),
                                    ),
                                    labelText: AppLocalizations.of(context)!
                                        .textfield_password,
                                    labelStyle:
                                        Theme.of(context).textTheme.headline4!.copyWith(color: Colors.black),
                                  ),
                                  validator: (value) => value!.isEmpty
                                      ? AppLocalizations.of(context)!
                                          .validator_password
                                      : null,
                                ),
                              ),
                              Align(
                                alignment: Alignment.topLeft,
                                child: TextButton(
                                  style: TextButton.styleFrom(

                                    textStyle:
                                        TextStyle(fontSize: Get.width * 0.025),
                                  ),
                                  onPressed: () {
                                  authenticationController.clearInputsChange();
                                    Navigator.pushNamed(context, '/recoveryPassword');

                                  },
                                  child: Text(
                                    AppLocalizations.of(context)!
                                        .text_forgot_password,
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline4!
                                        .copyWith(
                                            fontStyle: FontStyle.italic,
                                            color: Colors.white),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 16),
                              ButtonUI(
                                label:
                                    AppLocalizations.of(context)!.button_login,
                                action: () async {
                                  openLoadingStateDialog(context);
                                  var result = await authenticationController
                                      .validateAndSaveLogin(context);
                                  Navigator.pop(context);
                                  if (result.success) {
                                    Navigator.pushReplacementNamed(
                                        context, '/home');
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
                              const SizedBox(height: 8),


                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            AppLocalizations.of(context)!.text_dont_have_an_account,
            style: Theme.of(context).textTheme.headline4,
          ),
          TextButton(
            style: TextButton.styleFrom(

              textStyle: TextStyle(fontSize: Get.width * 0.03),
            ),
            onPressed: () {
              authenticationController.loading.value = false;
              authenticationController.statePassword.value = false;
              authenticationController.clearInputsRegister();
              Navigator.pushNamed(context, '/register');
            },
            child: Text(
              AppLocalizations.of(context)!.button_sign_up_now,
              style: const TextStyle(
                decoration: TextDecoration.underline,
                fontStyle: FontStyle.italic,
                fontFamily: AppFonts.poppinsItalicFont,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
