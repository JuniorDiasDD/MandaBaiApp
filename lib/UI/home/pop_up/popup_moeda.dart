import 'package:flutter/material.dart';
import 'package:flutter_session/flutter_session.dart';
import 'package:get/get.dart';
import 'package:manda_bai/Core/app_colors.dart';
import 'package:manda_bai/Core/app_fonts.dart';
import 'package:manda_bai/UI/home/pages/home_page.dart';

class Popup_Moeda extends StatefulWidget {
  const Popup_Moeda({Key? key}) : super(key: key);

  @override
  _Popup_MoedaState createState() => _Popup_MoedaState();
}

class _Popup_MoedaState extends State<Popup_Moeda> {
  String _isRadioSelected = "";
  Future _carregarMoney() async {
    if (_isRadioSelected == "") {
      _isRadioSelected = await FlutterSession().get('money');
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
          height: Get.height * 0.35,
          margin:
              EdgeInsets.only(left: Get.width * 0.12, right: Get.width * 0.12),
          decoration: BoxDecoration(
            color: Theme.of(context).scaffoldBackgroundColor,
            borderRadius: BorderRadius.circular(12),
          ),
          child: FutureBuilder(
              future: _carregarMoney(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.data == null) {
                  return Text("");
                } else {
                  return Padding(
                    padding: EdgeInsets.only(
                      left: Get.width * 0.04,
                      right: Get.width * 0.04,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                            top: Get.height * 0.02,
                          ),
                          child: Text(
                            'Selecione a Moeda:',
                            textAlign: TextAlign.start,
                            style: Theme.of(context).textTheme.headline2,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Euro",
                              style: Theme.of(context).textTheme.headline4,
                            ),
                            Radio(
                              value: "EUR",
                              groupValue: _isRadioSelected,
                              onChanged: (value) {
                                setState(() {
                                  _isRadioSelected = "EUR";
                                });
                              },
                              activeColor: Colors.green,
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Escudos",
                              style: Theme.of(context).textTheme.headline4,
                            ),
                            Radio(
                              value: "ECV",
                              groupValue: _isRadioSelected,
                              onChanged: (value) {
                                setState(() {
                                  _isRadioSelected = "ECV";
                                });
                              },
                              activeColor: Colors.green,
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Dólar",
                              style: Theme.of(context).textTheme.headline4,
                            ),
                            Radio(
                              value: "USD",
                              groupValue: _isRadioSelected,
                              onChanged: (value) {
                                setState(() {
                                  _isRadioSelected = "USD";
                                });
                              },
                              activeColor: Colors.green,
                            ),
                          ],
                        ),
                        SizedBox(height: Get.height * 0.03),
                        Align(
                          alignment: Alignment.center,
                          child: Container(
                            height: Get.height * 0.07,
                            width: Get.width * 0.3,
                            decoration: const BoxDecoration(
                              color: AppColors.greenColor,
                              borderRadius: BorderRadius.all(
                                Radius.circular(35),
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey,
                                  blurRadius: 2.0,
                                  spreadRadius: 0.0,
                                  offset: Offset(2.0, 2.0),
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
                                  await session.set('money', _isRadioSelected);
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
