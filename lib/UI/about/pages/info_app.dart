import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';
import 'package:manda_bai/Core/app_colors.dart';
import 'package:manda_bai/Core/app_images.dart';
import 'package:manda_bai/Model/employee.dart';
import 'package:manda_bai/UI/about/components/item_bio.dart';
import 'package:manda_bai/UI/about/components/item_developer.dart';
import 'package:manda_bai/UI/about/components/item_mandatario.dart';
import 'package:manda_bai/UI/home/pop_up/popup_message_internet.dart';
import 'package:readmore/readmore.dart';

import 'about_app.dart';

class InfoApp extends StatefulWidget {
  const InfoApp({Key? key}) : super(key: key);

  @override
  State<InfoApp> createState() => _InfoAppState();
}

class _InfoAppState extends State<InfoApp> {
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
  List<Employee> list_employee = [];
  List<Employee> list_employee_Mandatarios = [];
  Future _carregar(context) async {
    if(list_employee.isEmpty){
      list_employee.add(Employee(
        name: 'Carlos Pereira',
        cargo: AppLocalizations.of(context)!.text_role_carlos,
        image:
        'https://www.mandabai.com/wp-content/uploads/elementor/thumbs/img-16-pbkbaaof0qxdaun3rdjj72eggo8xuf1tzefuxajdjk.jpg',
        description: AppLocalizations.of(context)!.text_description_carlos,
        tel: '+31639838997',
        email: 'pereirac2207@gmail.com',
      ));
      list_employee.add(Employee(
        name: 'Eveline Tavares',
        cargo: AppLocalizations.of(context)!.text_role_eveline,
        image:
        'https://www.mandabai.com/wp-content/uploads/elementor/thumbs/Design-sem-nome-4-pbwjcdm6kbjiw14u4pb8kvevyan7bq0lqfaqzjbqds.jpg',
        description: AppLocalizations.of(context)!.text_description_eveline,
        tel: '+2389724140',
        email: 'eveline.mandabai@gmail.com',
      ));
    }

    return list_employee;
  }

  Future _carregarMandatarios(context) async {
    if(list_employee_Mandatarios.isEmpty){
      list_employee_Mandatarios.add(Employee(
          name: 'Celly Fontes',
          cargo: AppLocalizations.of(context)!.text_role_antonio,
          image:
          'https://santiago.mandabai.com/wp-content/uploads/2022/01/Design-sem-nome-37.jpg',
          description: AppLocalizations.of(context)!.text_description_antonio,
          tel: '+774 3812002 ',
          email: 'bellisimacosmeticsusa@gmail.com'));
      list_employee_Mandatarios.add(Employee(
          name: 'António Coelho Monteiro',
          cargo: AppLocalizations.of(context)!.text_role_antonio,
          image:
          'https://santiago.mandabai.com/wp-content/uploads/2022/01/Design-sem-nome-35.jpg',
          description: AppLocalizations.of(context)!.text_description_antonio,
          tel: '+1 3057786138',
          email: 'acmonteiro48@gmail.com'));
      list_employee_Mandatarios.add(Employee(
          name: 'Francisco de Pina',
          cargo: AppLocalizations.of(context)!.text_role_estevao,
          image:
          'https://santiago.mandabai.com/wp-content/uploads/2022/01/Design-sem-nome-36.jpg',
          description: AppLocalizations.of(context)!.text_description_estevao,
          tel: '+351913098511\n+351938880906',
          email: 'francisco.r.depina@gmail.com'));
    }

    return list_employee_Mandatarios;
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
        body: Column(
          children: [
            Container(
              color:Theme.of(context).primaryColor,
              width: double.infinity,
              child: Row(

                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(
                      Icons.arrow_back,
                      color:Colors.white,
                    ),
                    alignment: Alignment.centerRight,
                  ),
                  Text(
                    AppLocalizations.of(context)!.title_about_us,
                    style: Theme.of(context).textTheme.headline3!.copyWith(color:Colors.white,),
                  ),
                  const Spacer(),
                ],
              ),
            ),

            SizedBox(height: Get.height * 0.03),
            Padding(
              padding: EdgeInsets.only(
                  left: Get.width * 0.04, right: Get.width * 0.04),
              child: SizedBox(
                height: Get.height*0.87,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          AppLocalizations.of(context)!.text_mandabai,
                          style: Theme.of(context).textTheme.headline1,
                        ),
                      ),
                      SizedBox(height: Get.height * 0.02),
                      ReadMoreText(
                        AppLocalizations.of(context)!.text_description_mandabai,
                        trimLines: 8,
                        colorClickableText: AppColors.greenColor,
                        trimMode: TrimMode.Line,
                        trimCollapsedText:
                        AppLocalizations.of(context)!.readmoretext_see_more,
                        trimExpandedText:
                        AppLocalizations.of(context)!.readmoretext_close,
                        style: Theme.of(context).textTheme.headline4,
                        moreStyle: Theme.of(context).textTheme.headline6,
                      ),
                      SizedBox(height: Get.height * 0.04),
                      Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          AppLocalizations.of(context)!.subtitle_company_members,
                          style: Theme.of(context).textTheme.headline2,
                        ),
                      ),
                      const SizedBox(height: 10),
                      FutureBuilder(
                        future: _carregar(context),
                        builder: (BuildContext context, AsyncSnapshot snapshot) {
                          switch (snapshot.connectionState) {
                            case ConnectionState.waiting:
                              return Container(
                                height: Get.height * 0.2,
                                width: Get.width,
                                child: Center(
                                  child: Image.network(
                                    AppImages.loading,
                                    width: Get.width * 0.2,
                                    height: Get.height * 0.2,
                                    alignment: Alignment.center,
                                  ),
                                ),
                              );
                            default:
                              if (snapshot.data == null) {
                                return Container();
                              } else {
                                return Container(
                                  height: Get.height * 0.35,
                                  child: ListView.builder(
                                    padding: EdgeInsets.all(0.0),
                                    scrollDirection: Axis.vertical,
                                    itemCount: list_employee.length,
                                    itemBuilder: (BuildContext context, index) {
                                      var list = list_employee[index];
                                      return Item_Bio(employee: list);
                                    },
                                  ),
                                );
                              }
                          }
                        },
                      ),
                      const SizedBox(height: 20),
                      Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          AppLocalizations.of(context)!
                              .subtitle_representative_members,
                          style: Theme.of(context).textTheme.headline2,
                        ),
                      ),
                      const SizedBox(height: 10),
                      FutureBuilder(
                        future: _carregarMandatarios(context),
                        builder: (BuildContext context, AsyncSnapshot snapshot) {
                          switch (snapshot.connectionState) {
                            case ConnectionState.waiting:
                              return Container(
                                height: Get.height * 0.2,
                                width: Get.width,
                                child: Center(
                                  child: Image.network(
                                    AppImages.loading,
                                    width: Get.width * 0.2,
                                    height: Get.height * 0.2,
                                    alignment: Alignment.center,
                                  ),
                                ),
                              );
                            default:
                              if (snapshot.data == null) {
                                return Container();
                              } else {
                                return Container(
                                  height: Get.height * 0.35,
                                  child: ListView.builder(
                                    padding: EdgeInsets.all(0.0),
                                    scrollDirection: Axis.vertical,
                                    itemCount: list_employee_Mandatarios.length,
                                    itemBuilder: (BuildContext context, index) {
                                      var list = list_employee_Mandatarios[index];
                                      return ItemMandatario(employee: list);
                                    },
                                  ),
                                );
                              }
                          }
                        },
                      ),
                      SizedBox(height: Get.height * 0.04),
                      Container(
                        margin: EdgeInsets.only(
                          left: Get.width * 0.01,
                          right: Get.width * 0.01,
                          top: Get.height * 0.02,
                        ),
                        decoration: BoxDecoration(
                          color: Theme.of(context).cardColor,
                          borderRadius: const BorderRadius.all(
                            Radius.circular(15),
                          ),
                          border: Border.all(
                              color: Colors.black12, width: Get.width * 0.001),
                        ),
                        child: ExpansionTile(
                          backgroundColor: Theme.of(context).cardColor,
                          iconColor: AppColors.greenColor,
                          title: Text(
                            AppLocalizations.of(context)!.subtitle_mission,
                            style: Theme.of(context).textTheme.headline5,
                          ),
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.all(15.0),
                              child: Text(
                                AppLocalizations.of(context)!
                                    .text_description_mission,
                                textAlign: TextAlign.start,
                                style: Theme.of(context).textTheme.headline4,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(
                          left: Get.width * 0.01,
                          right: Get.width * 0.01,
                          top: Get.height * 0.02,
                        ),
                        decoration: BoxDecoration(
                          color: Theme.of(context).cardColor,
                          borderRadius: const BorderRadius.all(
                            Radius.circular(15),
                          ),
                          border: Border.all(
                              color: Colors.black12, width: Get.width * 0.001),
                        ),
                        child: ExpansionTile(
                          backgroundColor: Theme.of(context).cardColor,
                          iconColor: AppColors.greenColor,
                          title: Text(
                            AppLocalizations.of(context)!.subtitle_vision,
                            style: Theme.of(context).textTheme.headline5,
                          ),
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.all(15.0),
                              child: Text(
                                AppLocalizations.of(context)!
                                    .text_description_vision,
                                textAlign: TextAlign.start,
                                style: Theme.of(context).textTheme.headline4,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(
                          left: Get.width * 0.01,
                          right: Get.width * 0.01,
                          top: Get.height * 0.02,
                        ),
                        decoration: BoxDecoration(
                          color: Theme.of(context).cardColor,
                          borderRadius: BorderRadius.all(
                            Radius.circular(15),
                          ),
                          border: Border.all(
                              color: Colors.black12, width: Get.width * 0.001),
                        ),
                        child: ExpansionTile(
                          backgroundColor: Theme.of(context).cardColor,
                          iconColor: AppColors.greenColor,
                          title: Text(
                            AppLocalizations.of(context)!.subtitle_values,
                            style: Theme.of(context).textTheme.headline5,
                          ),
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.all(15.0),
                              child: Text(
                                  AppLocalizations.of(context)!
                                      .text_description_values,
                                  textAlign: TextAlign.start,
                                  style: Theme.of(context).textTheme.headline4),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: Get.height * 0.03),

                    ],
                  ),
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }
}
