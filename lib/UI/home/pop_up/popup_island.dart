import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_session/flutter_session.dart';
import 'package:get/get.dart';
import 'package:manda_bai/Core/app_colors.dart';
import 'package:manda_bai/Core/app_fonts.dart';
import 'package:manda_bai/UI/home/pages/home_page.dart';

class Popup_Island extends StatefulWidget {
  const Popup_Island({Key? key}) : super(key: key);

  @override
  _Popup_IslandState createState() => _Popup_IslandState();
}

class _Popup_IslandState extends State<Popup_Island> {
  String _isRadioSelected = "";

  Future _carregarIsland() async {
    if (_isRadioSelected == "") {
      _isRadioSelected = await FlutterSession().get('island');
    }
    return _isRadioSelected;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
        child: Container(
          width: Get.width,
          height: Get.height * 0.55,
          margin:
              EdgeInsets.only(left: Get.width * 0.12, right: Get.width * 0.12),
          decoration: BoxDecoration(
            color: Theme.of(context).scaffoldBackgroundColor,
            borderRadius: BorderRadius.circular(12),
          ),
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
                            'Selecione a Ilha pretendida:',
                            textAlign: TextAlign.start,
                            style: Theme.of(context).textTheme.headline2,
                          ),
                        ),
                        Container(
                          height: Get.height * 0.35,
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
                                            _isRadioSelected = "Santo Antão";
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
                                            _isRadioSelected = "São Vicente";
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
                                            _isRadioSelected = "São Nicolau";
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
                                            _isRadioSelected = "Boa Vista";
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
                        SizedBox(height: Get.height * 0.03),
                        Align(
                          alignment: Alignment.center,
                          child: Container(
                            height: Get.height * 0.07,
                            width: Get.width * 0.3,
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
                                  offset: Offset(
                                      2.0, 2.0), // changes position of shadow
                                ),
                              ],
                            ),
                            child: TextButton(
                                child: Text(
                                  'OK',
                                  style: TextStyle(
                                      fontFamily: AppFonts.poppinsBoldFont,
                                      fontSize: Get.width * 0.035,
                                      color: Colors.white),
                                ),
                                onPressed: () async {
                                  var session = FlutterSession();

                                  await session.set('island', _isRadioSelected);
                                  await session.set('island_atualizar', "true");
                                  setState(() {
                                    Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                HomePage(index: 3)));
                                  });
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
    );
  }
}
