import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:manda_bai/Controller/request.dart';
import 'package:manda_bai/Core/app_colors.dart';
import 'package:manda_bai/Core/app_images.dart';
import 'package:manda_bai/UI/home/pop_up/pop_up_message.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:manda_bai/UI/home/pop_up/popup_message_internet.dart';
import 'package:manda_bai/UI/intro/components/colored_circle_component.dart';

class SetPasswordPage extends StatefulWidget {
  String email, code;
   SetPasswordPage({Key? key,required this.email,required this.code}) : super(key: key);

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
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final input_password = TextEditingController();
  final input_password_conf = TextEditingController();
  bool loading = false;
  bool statePassword = true;
  bool statePasswordconf = true;
  bool checkPassword = true;
  Future<void> validateAndSave() async {
    final FormState? form = _formKey.currentState;
    if (form!.validate()) {
      if(input_password.text==input_password_conf.text){

        setState(() {
          loading = true;
          checkPassword = true;
        });
        var check = await ServiceRequest.setPassword(widget.email,widget.code,input_password.text);
        if(check){
          setState(() {
            loading = false;
          });
          return showDialog(
              context: context,
              builder: (BuildContext context) {
                return Pop_up_Message(
                    mensagem:
                    AppLocalizations.of(context)!.message_success_update,
                    icon: Icons.check,
                    caminho: "reset");
              });
        }else{
          setState(() {
            loading = false;
          });
          return showDialog(
              context: context,
              builder: (BuildContext context) {
                return Pop_up_Message(
                    mensagem:
                    AppLocalizations.of(context)!.message_update_failed,
                    icon: Icons.error,
                    caminho: "erro");
              });
        }
      }else{
        setState(() {
          checkPassword = false;
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
                            icon: const Icon(Icons.arrow_back,color: Colors.black,),
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
                            AppLocalizations.of(context)!.title_new_password,
                            style: Theme.of(context).textTheme.headline1,
                          ),
                        ),
                        SizedBox(height: Get.height * 0.02),
                        Align(
                          alignment:Alignment.topLeft,
                          child: Text(
                            AppLocalizations.of(context)!.description_new_password,
                            style: Theme.of(context).textTheme.headline4,
                          ),
                        ),
                        SizedBox(height: Get.height * 0.02),

                        SizedBox(height: Get.height * 0.01),
                        TextFormField(
                          controller: input_password,
                          obscureText: statePassword,
                          style: Theme.of(context).textTheme.headline4,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Theme.of(context).backgroundColor,
                            border: OutlineInputBorder(
                              borderRadius:
                              new BorderRadius.circular(15.0),
                              borderSide: new BorderSide(),
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
                                  statePassword = !statePassword;
                                });
                              },
                              icon: Icon(
                                statePassword
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                color: Colors.grey,
                              ),
                            ),
                            labelText: AppLocalizations.of(context)!
                                .textfield_password,
                            labelStyle:
                            Theme.of(context).textTheme.headline4,
                          ),
                          validator: (value) => value!.isEmpty
                              ? AppLocalizations.of(context)!
                              .validator_password
                              : null,
                        ),
                        SizedBox(height: Get.height * 0.01),
                        TextFormField(
                          controller: input_password_conf,
                          obscureText: statePasswordconf,
                          style: Theme.of(context).textTheme.headline4,
                          decoration: InputDecoration(
                            errorText: checkPassword == false
                                ? AppLocalizations.of(context)!
                                .message_error_text
                                : null,
                            filled: true,
                            fillColor: Theme.of(context).backgroundColor,
                            border: OutlineInputBorder(
                              borderRadius:
                              new BorderRadius.circular(15.0),
                              borderSide: new BorderSide(),
                            ),
                            prefixIcon: Padding(
                              padding: EdgeInsets.all(0.0),
                              child: Icon(
                                Icons.lock,
                                color: Colors.grey,
                              ), // icon is 48px widget.
                            ),
                            suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  statePasswordconf = !statePasswordconf;
                                });
                              },
                              icon: Icon(
                                statePasswordconf
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                color: Colors.grey,
                              ),
                            ),
                            labelText: AppLocalizations.of(context)!
                                .label_confirm_password,
                            labelStyle:
                            Theme.of(context).textTheme.headline4,
                          ),
                          validator: (value) => value!.isEmpty
                              ? AppLocalizations.of(context)!
                              .validator_empty_field
                              : null,
                        ),
                        SizedBox(
                          height: Get.height * 0.05,
                        ),
                        Container(
                          height: Get.height * 0.07,
                          width: Get.width,
                          child: FlatButton(
                            padding: EdgeInsets.only(
                              left: Get.width * 0.05,
                              right: Get.height * 0.05,
                            ),
                            color: AppColors.greenColor,
                            textColor: Colors.white,
                            child:  Text(AppLocalizations.of(context)!.button_update),
                            onPressed: () =>validateAndSave(),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            ),
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
