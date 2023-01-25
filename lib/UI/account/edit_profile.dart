import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:manda_bai/UI/home/pop_up/popup_message_internet.dart';
import 'package:manda_bai/UI/widget/TextFormField.dart';
import 'package:manda_bai/UI/widget/button_ui.dart';
import 'package:manda_bai/UI/widget/dialogs.dart';
import 'package:manda_bai/constants/controllers.dart';

class EditPorfilePage extends StatefulWidget {
  const EditPorfilePage({Key? key}) : super(key: key);

  @override
  _EditPorfilePageState createState() => _EditPorfilePageState();
}

class _EditPorfilePageState extends State<EditPorfilePage> {
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
    authenticationController.input_email.text =  authenticationController.user.value.email!;
    authenticationController.input_telefone.text =  authenticationController.user.value.telefone!;
    authenticationController.input_nome.text =  authenticationController.user.value.name!;
    authenticationController.input_nickname.text =  authenticationController.user.value.nickname!;
    authenticationController.input_country.text =  authenticationController.user.value.country!;
    authenticationController.input_city.text =  authenticationController.user.value.city!;
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
          key: authenticationController.formKey,
          child: SingleChildScrollView(
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
                                AppLocalizations.of(context)!.text_edit_profile,
                            style: Theme.of(context).textTheme.headline3,
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                        TextButton(onPressed: (){
                          authenticationController.clearInputsChangePassword();
                          Navigator.pushNamed(context, '/editPassword');
                        }, child: Text('Alterar Password',
                          style: Theme.of(context).textTheme.headline3,),),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Container(
                      padding: const EdgeInsets.all(16.0),
                      decoration: BoxDecoration(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(100)),
                        color: Theme.of(context).primaryColor,
                      ),
                      child: Icon(
                        Icons.person_outline_outlined,
                        size: Get.height * 0.06,
                        color: Colors.grey[300],
                      ),
                    ),
                    const SizedBox(height: 32),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          TextFormFieldCustom(
                            textController: authenticationController.input_nome,
                            hintText:
                                AppLocalizations.of(context)!.textfield_name,
                            requiredLabel:
                                AppLocalizations.of(context)!.validator_name,
                            icon: Icons.person,
                          ),
                          const SizedBox(height: 16),
                          TextFormFieldCustom(
                            textController:
                                authenticationController.input_nickname,
                            hintText:
                                AppLocalizations.of(context)!.textfield_nickname,
                            requiredLabel:
                                AppLocalizations.of(context)!.validator_nickname,
                            icon: Icons.person,
                          ),
                          const SizedBox(height: 16),
                          TextFormFieldCustom(
                            textController: authenticationController.input_email,
                            hintText: 'Email',
                            requiredLabel:
                                AppLocalizations.of(context)!.validator_email,
                            icon: Icons.email,
                            checkEmail: true,
                            keyboardType: TextInputType.emailAddress,
                          ),
                          const SizedBox(height: 16),
                          TextFormFieldCustom(
                            textController: authenticationController.input_city,
                            hintText:
                                AppLocalizations.of(context)!.textfield_city,
                            requiredLabel:
                                AppLocalizations.of(context)!.validator_city,
                            icon: Icons.location_city,
                          ),
                          const SizedBox(height: 16),
                          TextFormFieldCustom(
                            textController:
                                authenticationController.input_country,
                            hintText:
                                AppLocalizations.of(context)!.textfield_country,
                            requiredLabel:
                                AppLocalizations.of(context)!.validator_country,
                            icon: Icons.location_pin,
                          ),
                          const SizedBox(height: 16),
                          TextFormFieldCustom(
                            textController:
                                authenticationController.input_telefone,
                            hintText:
                                AppLocalizations.of(context)!.textfield_phone,
                            requiredLabel:
                                AppLocalizations.of(context)!.validator_number,
                            keyboardType: TextInputType.number,
                            icon: Icons.phone,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    ButtonUI(
                      label: AppLocalizations.of(context)!.button_update,
                      action: () async {
                        openLoadingLongStateDialog(context);
                        var result = await authenticationController
                            .validateEditProfile(context);
                        Navigator.pop(context);
                        if (result.success) {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text(
                              AppLocalizations.of(context)!.message_success_update,
                              style: Theme.of(context).textTheme.labelSmall,
                            ),
                            backgroundColor: Theme.of(context).primaryColor,
                          ));
                          Navigator.pushReplacementNamed(context, '/setting');
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
          ),
        ),
      ),
    );
  }

  /* selectImage() async {
    final ImagePicker picker = ImagePicker();
    try {
      XFile? file = await picker.pickImage(source: ImageSource.gallery);
      if (file != null) {
        final SharedPreferences prefs = await SharedPreferences.getInstance();
        final bytes = File(file.path).readAsBytesSync();
        String base64Image = base64Encode(bytes);
        prefs.setString("image", base64Image);
        setState(() {
          atualizar_image = true;
          comprovante = file;
        });
      }
    } catch (e) {
      print(e);
    }
  }*/
}
