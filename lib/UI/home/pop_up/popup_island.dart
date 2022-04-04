import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:manda_bai/Controller/request.dart';
import 'package:manda_bai/Core/app_colors.dart';
import 'package:manda_bai/Core/app_fonts.dart';
import 'package:manda_bai/Core/app_images.dart';
import 'package:manda_bai/UI/home/pages/home_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Popup_Island extends StatefulWidget {
  const Popup_Island({Key? key}) : super(key: key);

  @override
  _Popup_IslandState createState() => _Popup_IslandState();
}

class _Popup_IslandState extends State<Popup_Island> {
  String _isRadioSelected = "";
String island="";
  Future _carregarIsland() async {
    if (_isRadioSelected == "") {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      setState(() {
        island = prefs.getString('island')!;
        _isRadioSelected=island;
      });

    }
    return _isRadioSelected;
  }

  bool loading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          Center(
            child: Container(
              width: Get.width,
              height: Get.height * 0.65,
              margin: EdgeInsets.only(
                  left: Get.width * 0.15, right: Get.width * 0.15),
              decoration: BoxDecoration(
                color: Theme.of(context).scaffoldBackgroundColor,
                borderRadius: BorderRadius.circular(12),
              ),
              child: SingleChildScrollView(
                child: FutureBuilder(
                    future: _carregarIsland(),
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      if (snapshot.data == null) {
                        return Text("");
                      } else {
                        return Padding(
                          padding: EdgeInsets.only(
                            left: Get.width * 0.02,
                            right: Get.width * 0.02,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(
                                  left: Get.width * 0.03,
                                  right: Get.width * 0.03,
                                  top: Get.height * 0.02,
                                  bottom: Get.height * 0.02,
                                ),
                                child: Text(
                                  AppLocalizations.of(context)!
                                      .text_select_island,
                                  textAlign: TextAlign.start,
                                  style: Theme.of(context).textTheme.headline2,
                                ),
                              ),
                              Container(
                                height: Get.height * 0.5,
                                child: SingleChildScrollView(
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                      left: Get.width * 0.02,
                                      right: Get.width * 0.02,
                                    ),
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "Santo Antão",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .headline4,
                                            ),
                                            Radio(
                                              value: "Santo Antão",
                                              groupValue: _isRadioSelected,
                                              onChanged: (value) {
                                                setState(() {
                                                  _isRadioSelected =
                                                      "Santo Antão";
                                                });
                                              },
                                              activeColor: Colors.green,
                                            ),
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "São Vicente",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .headline4,
                                            ),
                                            Radio(
                                              value: "São Vicente",
                                              groupValue: _isRadioSelected,
                                              onChanged: (value) {
                                                setState(() {
                                                  _isRadioSelected =
                                                      "São Vicente";
                                                });
                                              },
                                              activeColor: Colors.green,
                                            ),
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "São Nicolau",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .headline4,
                                            ),
                                            Radio(
                                              value: "São Nicolau",
                                              groupValue: _isRadioSelected,
                                              onChanged: (value) {
                                                setState(() {
                                                  _isRadioSelected =
                                                      "São Nicolau";
                                                });
                                              },
                                              activeColor: Colors.green,
                                            ),
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "Sal",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .headline4,
                                            ),
                                            Radio(
                                              value: "Sal",
                                              groupValue: _isRadioSelected,
                                              onChanged: (value) {
                                                setState(() {
                                                  _isRadioSelected = "Sal";
                                                });
                                              },
                                              activeColor: Colors.green,
                                            ),
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "Boa Vista",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .headline4,
                                            ),
                                            Radio(
                                              value: "Boa Vista",
                                              groupValue: _isRadioSelected,
                                              onChanged: (value) {
                                                setState(() {
                                                  _isRadioSelected =
                                                      "Boa Vista";
                                                });
                                              },
                                              activeColor: Colors.green,
                                            ),
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "Maio",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .headline4,
                                            ),
                                            Radio(
                                              value: "Maio",
                                              groupValue: _isRadioSelected,
                                              onChanged: (value) {
                                                setState(() {
                                                  _isRadioSelected = "Maio";
                                                });
                                              },
                                              activeColor: Colors.green,
                                            ),
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "Santiago",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .headline4,
                                            ),
                                            Radio(
                                              value: "Santiago",
                                              groupValue: _isRadioSelected,
                                              onChanged: (value) {
                                                setState(() {
                                                  _isRadioSelected = "Santiago";
                                                });
                                              },
                                              activeColor: Colors.green,
                                            ),
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "Fogo",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .headline4,
                                            ),
                                            Radio(
                                              value: "Fogo",
                                              groupValue: _isRadioSelected,
                                              onChanged: (value) {
                                                setState(() {
                                                  _isRadioSelected = "Fogo";
                                                });
                                              },
                                              activeColor: Colors.green,
                                            ),
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "Brava",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .headline4,
                                            ),
                                            Radio(
                                              value: "Brava",
                                              groupValue: _isRadioSelected,
                                              onChanged: (value) {
                                                setState(() {
                                                  _isRadioSelected = "Brava";
                                                });
                                              },
                                              activeColor: Colors.green,
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  height: Get.height * 0.05,
                                  width: Get.width,
                                  decoration: BoxDecoration(
                                    color: AppColors.greenColor,
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(15),
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Theme.of(context).cardColor,
                                        blurRadius: 2.0,
                                        spreadRadius: 0.0,
                                        offset: Offset(2.0,
                                            2.0), // changes position of shadow
                                      ),
                                    ],
                                  ),
                                  child: TextButton(
                                      child: Text(
                                        'OK',
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline4!
                                            .copyWith(
                                              color: Colors.white,
                                            ),
                                      ),
                                      onPressed: () async {
                                        if(island!=_isRadioSelected){
                                          setState(() {
                                            loading = true;
                                          });
                                          final SharedPreferences prefs =
                                          await SharedPreferences
                                              .getInstance();
                                          await prefs.setString(
                                              'island', _isRadioSelected);
                                          await prefs.setString(
                                              'island_atualizar', "true");
                                          await ServiceRequest.loginFresh();
                                          setState(() {
                                            loading = false;
                                          });
                                          setState(() {
                                            Navigator.pushReplacement(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        HomePage(index: 4)));
                                          });
                                        }else{
                                          Navigator.pop(context);
                                        }

                                      }),
                                ),
                              ),
                            ],
                          ),
                        );
                      }
                    }),
              ),
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
