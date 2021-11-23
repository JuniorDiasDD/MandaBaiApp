import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:manda_bai/Core/app_colors.dart';
import 'package:manda_bai/Core/app_fonts.dart';
import 'package:manda_bai/Core/app_images.dart';
import 'package:websafe_svg/websafe_svg.dart';

class CheckoutPageStep3 extends StatefulWidget {
  const CheckoutPageStep3({Key? key}) : super(key: key);

  @override
  _CheckoutPageStep3State createState() => _CheckoutPageStep3State();
}

class _CheckoutPageStep3State extends State<CheckoutPageStep3> {
  int val = 1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding:
            EdgeInsets.only(left: Get.width * 0.04, right: Get.width * 0.04),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: Get.height * 0.08),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    child: IconButton(
                      // padding: EdgeInsets.all(0.0),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(
                        Icons.arrow_back,
                        color: Colors.black,
                      ),
                      alignment: Alignment.centerRight,
                    ),
                  ),
                  Text(
                    'Checkout',
                    style: TextStyle(
                        fontFamily: AppFonts.poppinsBoldFont,
                        fontSize: Get.width * 0.05),
                  ),
                  IconButton(
                    padding: const EdgeInsets.all(0.0),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return Scaffold(
                            backgroundColor: Colors.transparent,
                            body: Center(
                              child: Container(
                                width: Get.width,
                                height: Get.height * 0.3,
                                margin: EdgeInsets.only(left: 20, right: 20),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    IconButton(
                                      icon: Icon(Icons.close),
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    },
                    icon: const Icon(
                      Icons.info,
                      color: AppColors.greenColor,
                    ),
                    iconSize: Get.width * 0.05,
                    alignment: Alignment.centerRight,
                  ),
                ],
              ),
              SizedBox(height: Get.height * 0.05),
              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  "Pagamento",
                  style: TextStyle(
                      fontFamily: AppFonts.poppinsBoldFont,
                      fontSize: Get.width * 0.045),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      WebsafeSvg.asset(AppImages.credit_card),
                      Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: Text(
                          "Credit Card",
                          style: TextStyle(
                            fontFamily: AppFonts.poppinsBoldFont,
                          ),
                        ),
                      )
                    ],
                  ),
                  Radio(
                    value: 1,
                    groupValue: val,
                    onChanged: (value) {
                      setState(() {
                        val = 1;
                      });
                    },
                    activeColor: Colors.green,
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      WebsafeSvg.asset(AppImages.pay_pal),
                      Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: Text(
                          "PayPal",
                          style: TextStyle(
                            fontFamily: AppFonts.poppinsBoldFont,
                          ),
                        ),
                      )
                    ],
                  ),
                  Radio(
                    value: 2,
                    groupValue: val,
                    onChanged: (value) {
                      setState(() {
                        val = 2;
                      });
                    },
                    activeColor: Colors.green,
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      WebsafeSvg.asset(AppImages.ideal),
                      Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: Text(
                          "iDEAL",
                          style: TextStyle(
                            fontFamily: AppFonts.poppinsBoldFont,
                          ),
                        ),
                      )
                    ],
                  ),
                  Radio(
                    value: 3,
                    groupValue: val,
                    onChanged: (value) {
                      setState(() {
                        val = 3;
                      });
                    },
                    activeColor: Colors.green,
                  ),
                ],
              ),
              SizedBox(height: Get.height * 0.01),
              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  "Número de Cartão",
                  style: TextStyle(
                    fontFamily: AppFonts.poppinsRegularFont,
                    fontSize: Get.width * 0.035,
                  ),
                ),
              ),
              SizedBox(height: Get.height * 0.01),
              Container(
                height: Get.height * 0.055,
                width: Get.width,
                child: TextField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(horizontal: 20),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(35),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(width: 1, color: Colors.black54),
                      borderRadius: BorderRadius.circular(35),
                    ),
                  ),
                ),
              ),
              SizedBox(height: Get.height * 0.01),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          "Expiração",
                          style: TextStyle(
                            fontFamily: AppFonts.poppinsRegularFont,
                            fontSize: Get.width * 0.035,
                          ),
                        ),
                      ),
                      SizedBox(height: Get.height * 0.01),
                      Container(
                        height: Get.height * 0.055,
                        width: Get.width * 0.3,
                        child: TextField(
                          keyboardType: TextInputType.datetime,
                          decoration: InputDecoration(
                            contentPadding:
                                EdgeInsets.symmetric(horizontal: 20),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(35),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(width: 1, color: Colors.black54),
                              borderRadius: BorderRadius.circular(35),
                            ),
                            hintText: 'mm/aaa',
                          ),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          "CVV2",
                          style: TextStyle(
                            fontFamily: AppFonts.poppinsRegularFont,
                            fontSize: Get.width * 0.035,
                          ),
                        ),
                      ),
                      SizedBox(height: Get.height * 0.01),
                      Container(
                        height: Get.height * 0.055,
                        width: Get.width * 0.3,
                        child: TextField(
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            contentPadding:
                                EdgeInsets.symmetric(horizontal: 20),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(35),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(width: 1, color: Colors.black54),
                              borderRadius: BorderRadius.circular(35),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: Get.height * 0.1),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Total",
                    style: TextStyle(
                        fontFamily: AppFonts.poppinsBoldFont,
                        fontSize: Get.width * 0.045),
                  ),
                  Text(
                    "99",
                    style: TextStyle(
                        fontFamily: AppFonts.poppinsBoldFont,
                        color: AppColors.greenColor,
                        fontSize: Get.width * 0.045),
                  ),
                ],
              ),
              SizedBox(height: Get.height * 0.02),
              Container(
                height: Get.height * 0.05,
                width: Get.width,
                child: FlatButton(
                  padding: EdgeInsets.only(
                    left: Get.width * 0.05,
                    right: Get.height * 0.05,
                  ),
                  color: AppColors.greenColor,
                  textColor: Colors.white,
                  child: Text('Finalizar'),
                  onPressed: () {
                    /*  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CheckoutPage(),
                    ),
                  );*/
                  },
                  shape: RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(30.0),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
