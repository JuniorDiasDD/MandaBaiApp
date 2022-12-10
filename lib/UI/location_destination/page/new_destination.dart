import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:manda_bai/Core/app_colors.dart';
import 'package:manda_bai/Model/location.dart';
import 'package:manda_bai/UI/home/pop_up/popup_message_internet.dart';
import 'package:manda_bai/UI/location_destination/components/popup_info.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:manda_bai/UI/widget/TextFormField.dart';
import 'package:manda_bai/UI/widget/button_ui.dart';
import 'package:manda_bai/UI/widget/dialogs.dart';
import 'package:manda_bai/constants/controllers.dart';

class NewDestination extends StatefulWidget {
  final Location? location;
  const NewDestination({Key? key, required this.location}) : super(key: key);

  @override
  State<NewDestination> createState() => _NewDestinationState();
}

class _NewDestinationState extends State<NewDestination> {
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
    if (widget.location != null) {
      locationController.location.value = widget.location!;
      locationController.inputNome.text = widget.location!.name!;
      locationController.inputCidade.text = widget.location!.city!;
      locationController.inputEndereco.text = widget.location!.endereco!;
      locationController.inputTel.text = widget.location!.phone!;
    }
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
        body: SingleChildScrollView(
          child: SizedBox(
            height: Get.height * 0.95,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 16.0, left: 8, right: 16),
                  child: Row(
                    children: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text(
                          '< ' +
                              AppLocalizations.of(context)!.title_new_destiny,
                          style: Theme.of(context).textTheme.headline3,
                        ),
                      ),
                      const Spacer(),
                      GestureDetector(
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return const PopupInfo();
                            },
                          );
                        },
                        child: Container(
                          width: Get.width * 0.1,
                          height: Get.width * 0.1,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            color: AppColors.grey50.withOpacity(0.8),
                          ),
                          child: const Padding(
                            padding: EdgeInsets.all(6.0),
                            child: Icon(
                              Icons.info_outline,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    left: Get.width * 0.05,
                    right: Get.width * 0.05,
                  ),
                  child: Form(
                    key: locationController.formKey,
                    child: Column(
                      children: [
                        SizedBox(height: Get.height * 0.05),
                        Align(
                          alignment: Alignment.topLeft,
                          child: Padding(
                            padding: EdgeInsets.only(
                              left: Get.width * 0.02,
                            ),
                            child: Text(
                              AppLocalizations.of(context)!.text_fill_the_field,
                              style: Theme.of(context).textTheme.headline4,
                            ),
                          ),
                        ),
                        SizedBox(height: Get.height * 0.01),
                        TextFormFieldCustom(
                          textController: locationController.inputNome,
                          hintText:
                              AppLocalizations.of(context)!.text_recipient_name,
                          requiredLabel:
                              AppLocalizations.of(context)!.validator_name,
                          keyboardType: TextInputType.name,
                        ),
                        SizedBox(height: Get.height * 0.01),
                        TextFormFieldCustom(
                          textController: locationController.inputCidade,
                          hintText:
                              AppLocalizations.of(context)!.textfield_city,
                          requiredLabel:
                              AppLocalizations.of(context)!.validator_city,
                          keyboardType: TextInputType.name,
                        ),
                        SizedBox(height: Get.height * 0.01),
                        TextFormFieldCustom(
                          textController: locationController.inputEndereco,
                          hintText: AppLocalizations.of(context)!.text_address,
                          requiredLabel: AppLocalizations.of(context)!
                              .validator_enter_address,
                          keyboardType: TextInputType.name,
                        ),
                        SizedBox(height: Get.height * 0.01),
                        SizedBox(
                          width: Get.width,
                          child: TextFormField(
                            controller: locationController.inputTel,
                            keyboardType: TextInputType.number,
                            style: Theme.of(context).textTheme.headline4,
                            decoration: InputDecoration(
                              labelText:
                                  AppLocalizations.of(context)!.textfield_phone,
                              labelStyle: Theme.of(context).textTheme.headline4,
                              filled: true,
                              fillColor: AppColors.grey50.withOpacity(0.5),
                              prefixIcon: Padding(
                                padding: const EdgeInsets.all(13.0),
                                child: Text(
                                  "+238",
                                  style: Theme.of(context).textTheme.headline4,
                                ), // icon is 48px widget.
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(20.0),
                                ),
                                borderSide: BorderSide(
                                    color:
                                        AppColors.black_claro.withOpacity(0.4),
                                    width: 0.0),
                              ),
                              focusedBorder: const OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20.0)),
                                  borderSide:
                                      BorderSide(color: AppColors.greenColor)),
                            ),
                            validator: (value) => value!.length == 7
                                ? null
                                : AppLocalizations.of(context)!
                                    .validator_number,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ButtonUI(
                    label: AppLocalizations.of(context)!.button_save,
                    action: () async {
                      openLoadingStateDialog(context);
                      var result = null;
                      if (widget.location != null) {
                        result = await locationController.editLocation();
                      } else {
                        result =
                            await locationController.validateAndSaveLocation();
                      }
                      Navigator.pop(context);
                      if (result.success) {
                        Navigator.pop(context);
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
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
