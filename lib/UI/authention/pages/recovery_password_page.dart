import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:manda_bai/Controller/request.dart';
import 'package:manda_bai/Core/app_colors.dart';
import 'package:manda_bai/Core/app_images.dart';
import 'package:manda_bai/UI/authention/pages/validate_code_page.dart';
import 'package:manda_bai/UI/home/pop_up/pop_up_message.dart';
import 'package:manda_bai/UI/home/pop_up/popup_message_internet.dart';
import 'package:manda_bai/UI/intro/components/colored_circle_component.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final input_email = TextEditingController();
  bool loading = false;
  Future<void> validateAndSave() async {
    final FormState? form = _formKey.currentState;
    if (form!.validate()) {
      setState(() {
        loading = true;
      });
      var check = await ServiceRequest.resetPassword(input_email.text);
      if (check) {
        setState(() {
          loading = false;
        });
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ValidateCode(email: input_email.text),
          ),
        );
      } else {
        setState(() {
          loading = false;
        });
        return showDialog(
            context: context,
            builder: (BuildContext context) {
              return Pop_up_Message(
                  mensagem: AppLocalizations.of(context)!
                      .message_erro_email_set_password,
                  icon: Icons.error,
                  caminho: "erro");
            });
      }
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
                Stack(
                  children: [
                    Align(
                      alignment: Alignment.bottomLeft,
                      child: ColoredCircleComponent(),
                    ),
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
                    key: _formKey,
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(top: 33.0),
                          child: Text(
                            AppLocalizations.of(context)!.text_forgot_password,
                            style: Theme.of(context).textTheme.headline1,
                          ),
                        ),
                        SizedBox(height: Get.height * 0.02),
                        Text(
                          AppLocalizations.of(context)!.text_reset_password,
                          style: Theme.of(context).textTheme.headline2,
                        ),
                        SizedBox(height: Get.height * 0.02),
                        SizedBox(height: Get.height * 0.01),
                        TextFormField(
                          obscureText: false,
                          keyboardType: TextInputType.emailAddress,
                          controller: input_email,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  width: 1, color: AppColors.greenColor),
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            labelText: "Email",
                            labelStyle: Theme.of(context)
                                .textTheme
                                .headline4!
                                .copyWith(fontSize: Get.width * 0.03),
                          ),
                          validator: (value) => EmailValidator.validate(value!)
                              ? null
                              : AppLocalizations.of(context)!.validator_email,
                        ),
                        SizedBox(
                          height: Get.height * 0.05,
                        ),
                        TextButton(
                          onPressed: () => validateAndSave(),
                          child: Container(
                            height: Get.height * 0.07,
                            width: Get.width,
                            padding: EdgeInsets.only(
                              left: Get.width * 0.05,
                              right: Get.height * 0.05,
                            ),
                            color: AppColors.greenColor,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            child:
                                Text(AppLocalizations.of(context)!.button_send,
                                    style: TextStyle(
                                      color: Colors.white,
                                    )),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            child: loading
                ? Container(
                    color: Colors.black54,
                    height: Get.height,
                    child: Center(
                      child: Image.network(
                        AppImages.loading,
                        width: Get.width * 0.2,
                        height: Get.height * 0.2,
                        alignment: Alignment.center,
                      ),
                    ),
                  )
                : null,
          ),
        ],
      ),
    );
  }
}
