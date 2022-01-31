import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:manda_bai/Controller/request.dart';
import 'package:manda_bai/Core/app_colors.dart';
import 'package:manda_bai/Core/app_fonts.dart';
import 'package:manda_bai/Model/location.dart';
import 'package:manda_bai/UI/home/pop_up/popup_message_internet.dart';
import 'package:manda_bai/UI/location_destination/components/popup_info.dart';
import 'package:manda_bai/UI/location_destination/page/destination_page.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class NewDestination extends StatefulWidget {
  String route;
  Location? location;
  NewDestination({Key? key, required this.route, required this.location})
      : super(key: key);

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
      input_nome.text = widget.location!.name;
      input_cidade.text = widget.location!.city;
      input_endereco.text = widget.location!.endereco;
      input_tel.text = widget.location!.phone;
    }

  }

  @override
  void dispose() {
    _connectivitySubscription.cancel();
    super.dispose();
  }
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final input_nome = TextEditingController();
  final input_cidade = TextEditingController();
  final input_endereco = TextEditingController();
  final input_tel = TextEditingController();

  String dropdownValue = 'Santiago';
  List<String> list_island = [
    'Santo Antão',
    'São Vicente',
    'São Nicolau',
    'Sal',
    'Boa Vista',
    'Maio',
    'Santiago',
    'Fogo',
    'Brava',
  ];
  Future<void> validateAndSave() async {
    final FormState? form = _formKey.currentState;
    if (form!.validate()) {
      Location novo = Location(
          id: 1,
          name: input_nome.text,
          city: input_cidade.text,
          endereco: input_endereco.text,
          island: dropdownValue,
          phone: input_tel.text,
          email: "");
      if (widget.location != null) {
        await ServiceRequest.removeLocation(widget.location!.id);
      }
      bool check = await ServiceRequest.addLocation(novo);
      if (check == true) {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => Destination_Page(route: widget.route)));
      }
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              color: Theme.of(context).primaryColor,
              width: double.infinity,
              child: Padding(
                padding: EdgeInsets.only(
                  top: Get.height * 0.045,
                ),
                child: Padding(
                  padding: const EdgeInsets.only(right:8.0),
                  child: Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      Destination_Page(route: widget.route)));
                        },
                        icon: const Icon(
                          Icons.arrow_back,
                          color:Colors.white,
                        ),

                      ),
                      const Spacer(),
                      Text(
                        AppLocalizations.of(context)!.title_new_destiny,
                        style: Theme.of(context).textTheme.headline3!.copyWith(color:Colors.white,),
                      ),
                      const Spacer(),
                      IconButton(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return const PopupInfo();
                            },
                          );
                        },
                        icon: const Icon(
                          Icons.info_outline,
                          color:Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            Padding(
              padding: EdgeInsets.only(
                left: Get.width * 0.05,
                right: Get.width * 0.05,
              ),
              child: Form(
                key: _formKey,
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
                    SizedBox(
                      width: Get.width,
                      child: TextFormField(
                        controller: input_nome,
                        style: Theme.of(context).textTheme.headline4,
                        decoration: InputDecoration(
                          labelText:
                              AppLocalizations.of(context)!.text_recipient_name,
                          labelStyle: Theme.of(context).textTheme.headline4,
                          filled: true,
                          fillColor: Theme.of(context).backgroundColor,
                          border:  OutlineInputBorder(
                            borderRadius:  BorderRadius.circular(15.0),
                            borderSide:
                                 const BorderSide(color: Colors.red, width: 2.0),
                          ),
                        ),
                        validator: (value) => value!.isEmpty
                            ? AppLocalizations.of(context)!.validator_name
                            : null,
                      ),
                    ),
                    SizedBox(height: Get.height * 0.01),
                    Container(
                      width: Get.width,
                      height: Get.height * 0.06,
                      padding: EdgeInsets.only(
                        left: Get.width * 0.04,
                        right: Get.width * 0.04,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15.0),
                        border: Border.all(
                            color: Theme.of(context).indicatorColor,
                            style: BorderStyle.solid,
                            width: 0.80),
                      ),
                      child: DropdownButton<String>(
                        value: dropdownValue,
                        icon: const Icon(
                          Icons.arrow_drop_down,
                        ),
                        iconSize: Get.width * 0.05,
                        elevation: 16,
                        style: Theme.of(context).textTheme.headline4,
                        borderRadius: BorderRadius.circular(15.0),
                        underline: Container(
                          height: 0,
                          color: Colors.transparent,
                        ),
                        onChanged: (String? newValue) {
                          setState(() {
                            dropdownValue = newValue!;
                          });
                        },
                        items: list_island
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(
                              value,
                              style: Theme.of(context).textTheme.headline4,
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                    SizedBox(height: Get.height * 0.01),
                    SizedBox(
                      width: Get.width,
                      child: TextFormField(
                        controller: input_cidade,
                        style: Theme.of(context).textTheme.headline4,
                        decoration: InputDecoration(
                          labelText:
                              AppLocalizations.of(context)!.textfield_city,
                          labelStyle: Theme.of(context).textTheme.headline4,
                          filled: true,
                          fillColor: Theme.of(context).backgroundColor,
                          border: OutlineInputBorder(
                            borderRadius:  BorderRadius.circular(15.0),
                            borderSide: const BorderSide(),
                          ),
                        ),
                        validator: (value) => value!.isEmpty
                            ? AppLocalizations.of(context)!.validator_city
                            : null,
                      ),
                    ),
                    SizedBox(height: Get.height * 0.01),
                    SizedBox(
                      width: Get.width,
                      child: TextFormField(
                        controller: input_endereco,
                        style: Theme.of(context).textTheme.headline4,
                        decoration: InputDecoration(
                          labelText: AppLocalizations.of(context)!.text_address,
                          labelStyle: Theme.of(context).textTheme.headline4,
                          filled: true,
                          fillColor: Theme.of(context).backgroundColor,
                          border: OutlineInputBorder(
                            borderRadius:  BorderRadius.circular(15.0),
                            borderSide: const BorderSide(),
                          ),
                        ),
                        validator: (value) => value!.isEmpty
                            ? AppLocalizations.of(context)!
                                .validator_enter_address
                            : null,
                      ),
                    ),
                    SizedBox(height: Get.height * 0.01),
                    SizedBox(
                      width: Get.width,
                      child: TextFormField(
                        controller: input_tel,
                        keyboardType: TextInputType.number,
                        style: Theme.of(context).textTheme.headline4,
                        decoration: InputDecoration(
                          labelText:
                              AppLocalizations.of(context)!.textfield_phone,
                          labelStyle: Theme.of(context).textTheme.headline4,
                          filled: true,
                          fillColor: Theme.of(context).backgroundColor,
                          prefixIcon: Padding(
                            padding: const EdgeInsets.all(13.0),
                            child: Text(
                              "+238",
                              style: Theme.of(context).textTheme.headline4,
                            ), // icon is 48px widget.
                          ),
                          border: OutlineInputBorder(
                            borderRadius:  BorderRadius.circular(15.0),
                            borderSide: const BorderSide(
                              color: Colors.red,
                            ),
                          ),
                        ),
                        validator: (value) => value!.length == 7
                            ? null
                            : AppLocalizations.of(context)!.validator_number,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Row(
        children: [
          const Spacer(),
          Padding(
            padding: const EdgeInsets.only(
              right: 15,
              bottom: 10,
            ),
            child: Container(
              height: Get.height * 0.05,
              width: Get.width * 0.4,
              decoration: BoxDecoration(
                color: AppColors.greenColor,
                borderRadius:const BorderRadius.all(
                  Radius.circular(35),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Theme.of(context).cardColor,
                    blurRadius: 2.0,
                    spreadRadius: 0.0,
                    offset: const Offset(2.0, 2.0), // changes position of shadow
                  ),
                ],
              ),
              child: TextButton(
                  child: Text(
                    AppLocalizations.of(context)!.button_save,
                    style: TextStyle(
                        fontFamily: AppFonts.poppinsRegularFont,
                        fontSize: Get.width * 0.035,
                        color: Colors.white),
                  ),
                  onPressed: () {
                    validateAndSave();
                  }),
            ),
          ),
        ],
      ),
    );
  }
}
