import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:manda_bai/Core/app_colors.dart';
import 'package:manda_bai/Core/app_fonts.dart';
import 'package:manda_bai/UI/home/pages/checkout_page_step_2.dart';

class CheckoutPage extends StatefulWidget {
  const CheckoutPage({Key? key}) : super(key: key);

  @override
  _CheckoutPageState createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
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
                  "Faturação e Envio",
                  style: TextStyle(
                      fontFamily: AppFonts.poppinsBoldFont,
                      fontSize: Get.width * 0.045),
                ),
              ),
              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  "Dados Pessoais",
                  style: TextStyle(
                    fontFamily: AppFonts.poppinsRegularFont,
                    fontSize: Get.width * 0.035,
                  ),
                ),
              ),
              SizedBox(height: Get.height * 0.02),
              Container(
                height: Get.height * 0.055,
                width: Get.width,
                child: TextField(
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(horizontal: 20),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(35),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(width: 1, color: Colors.black54),
                      borderRadius: BorderRadius.circular(35),
                    ),
                    labelText: 'Nome',
                    labelStyle: TextStyle(
                      color: Colors.black87,
                    ),
                  ),
                ),
              ),
              SizedBox(height: Get.height * 0.01),
              Container(
                height: Get.height * 0.055,
                width: Get.width,
                child: TextField(
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(horizontal: 20),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(35),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(width: 1, color: Colors.black54),
                      borderRadius: BorderRadius.circular(35),
                    ),
                    labelText: 'Pais',
                    labelStyle: TextStyle(
                      color: Colors.black87,
                    ),
                  ),
                ),
              ),
              SizedBox(height: Get.height * 0.01),
              Container(
                height: Get.height * 0.055,
                width: Get.width,
                child: TextField(
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(horizontal: 20),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(35),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(width: 1, color: Colors.black54),
                      borderRadius: BorderRadius.circular(35),
                    ),
                    labelText: 'Endereço',
                    labelStyle: TextStyle(
                      color: Colors.black87,
                    ),
                  ),
                ),
              ),
              SizedBox(height: Get.height * 0.01),
              Container(
                height: Get.height * 0.055,
                width: Get.width,
                child: TextField(
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(horizontal: 20),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(35),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(width: 1, color: Colors.black54),
                      borderRadius: BorderRadius.circular(35),
                    ),
                    labelText: 'Cidade',
                    labelStyle: TextStyle(
                      color: Colors.black87,
                    ),
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
                    labelText: 'Telemovel/Telefone',
                    labelStyle: TextStyle(
                      color: Colors.black87,
                    ),
                  ),
                ),
              ),
              SizedBox(height: Get.height * 0.01),
              Container(
                height: Get.height * 0.055,
                width: Get.width,
                child: TextField(
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(horizontal: 20),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(35),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(width: 1, color: Colors.black54),
                      borderRadius: BorderRadius.circular(35),
                    ),
                    labelText: 'Email',
                    labelStyle: TextStyle(
                      color: Colors.black87,
                    ),
                  ),
                ),
              ),
              SizedBox(height: Get.height * 0.28),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(" "),
          Padding(
            padding: EdgeInsets.only(
              right: 15,
              bottom: 10,
            ),
            child: TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CheckoutPageStep2(),
                  ),
                );
              },
              child: Text(
                "Seguinte >",
                style: TextStyle(
                    fontFamily: AppFonts.poppinsRegularFont,
                    color: AppColors.greenColor),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
