import 'package:flutter/material.dart';
import 'package:flutter_session/flutter_session.dart';
import 'package:get/get.dart';
import 'package:manda_bai/Core/app_colors.dart';
import 'package:manda_bai/Core/app_fonts.dart';

class Popup_Moeda extends StatefulWidget {
  const Popup_Moeda({Key? key}) : super(key: key);

  @override
  _Popup_MoedaState createState() => _Popup_MoedaState();
}

class _Popup_MoedaState extends State<Popup_Moeda> {
  String _isRadioSelected = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
        child: Container(
          width: Get.width,
          height: Get.height * 0.4,
          margin:
          EdgeInsets.only(left: Get.width * 0.12, right: Get.width * 0.12),
          decoration: BoxDecoration(
            color: Theme.of(context).scaffoldBackgroundColor,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(
                  left: Get.width * 0.03,
                  right: Get.width * 0.03,
                  top: Get.height * 0.02,
                ),
                child: Text(
                  'Selecione a Moeda:',
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    fontFamily: AppFonts.poppinsBoldFont,
                    fontSize: Get.width * 0.04,
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: Text(
                      "Santo Antão",
                      style: TextStyle(
                        fontFamily: AppFonts.poppinsRegularFont,
                      ),
                    ),
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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: Text(
                      "São Vicente",
                      style: TextStyle(
                        fontFamily: AppFonts.poppinsRegularFont,
                      ),
                    ),
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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: Text(
                      "São Nicolau",
                      style: TextStyle(
                        fontFamily: AppFonts.poppinsRegularFont,
                      ),
                    ),
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

              SizedBox(height: Get.height * 0.03),
              Align(
                alignment: Alignment.center,
                child: Container(
                  height: Get.height * 0.07,
                  width: Get.width * 0.3,
                  decoration: BoxDecoration(
                    color: AppColors.greenColor,
                    borderRadius: BorderRadius.all(
                      Radius.circular(35),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey,
                        blurRadius: 2.0,
                        spreadRadius: 0.0,
                        offset: Offset(2.0, 2.0), // changes position of shadow
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

                        Navigator.pop(context);
                      }),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
