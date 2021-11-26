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
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  int val = 1;
  bool isCheckedPromocao = false;
  final input_codigo = TextEditingController();
  final input_cartao = TextEditingController();
  final input_ccv = TextEditingController();
  final input_data_expiracao = TextEditingController();
  Future<void> validateAndSave() async {
    final FormState? form = _formKey.currentState;

    if (form!.validate()) {
      print('Form is valid');
    } else {
      print('Form is invalid');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding:
            EdgeInsets.only(left: Get.width * 0.04, right: Get.width * 0.04),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
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
                                    color:Theme.of(context).scaffoldBackgroundColor,
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: SingleChildScrollView(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Container(
                                              width: Get.width * 0.08,
                                            ),
                                            Text(
                                              'Instruções',
                                              style: TextStyle(
                                                  fontFamily:
                                                      AppFonts.poppinsBoldFont,
                                                  fontSize: Get.width * 0.04),
                                            ),
                                            IconButton(
                                              icon: Icon(Icons.close),
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                            ),
                                          ],
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(
                                            left: Get.width * 0.04,
                                            right: Get.width * 0.04,
                                          ),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.stretch,
                                            children: [
                                              SizedBox(height: Get.height * 0.01),
                                              Text(
                                                'Pagamento',
                                                style: TextStyle(
                                                    fontFamily: AppFonts
                                                        .poppinsBoldFont,
                                                    fontSize:
                                                        Get.width * 0.036),
                                              ),
                                              SizedBox(
                                                  height: Get.height * 0.01),
                                              Text(
                                                'Caso tiver um Cuppon de Desconto, clica na caixinha "Tenho um desconto", a seguir, introduza o código do desconto.',
                                                style: TextStyle(
                                                    fontFamily: AppFonts
                                                        .poppinsRegularFont,
                                                    fontSize: Get.width * 0.03),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                      },
                      icon: const Icon(
                        Icons.info,
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
                  children: [
                    Checkbox(
                      checkColor: Colors.white,
                      activeColor: Colors.green,
                      value: isCheckedPromocao,
                      onChanged: (bool? value) {
                        setState(() {
                          isCheckedPromocao = value!;
                        });
                      },
                    ),
                    Text(
                      "Tenho um desconto",
                      style: TextStyle(
                        fontFamily: AppFonts.poppinsRegularFont,
                        fontSize: Get.width * 0.035,
                      ),
                    ),
                  ],
                ),
                Container(
                  child: isCheckedPromocao == true
                      ? Column(
                          children: [
                            Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                "Codigo de Desconto",
                                style: TextStyle(
                                  fontFamily: AppFonts.poppinsRegularFont,
                                  fontSize: Get.width * 0.035,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: Get.height * 0.005,
                            ),
                            TextFormField(
                              controller: input_codigo,
                              style: TextStyle(
                                fontFamily: AppFonts.poppinsRegularFont,
                              ),
                              decoration: InputDecoration(
                                filled: false,
                                fillColor: Colors.white,
                                border: OutlineInputBorder(
                                  borderRadius: new BorderRadius.circular(35.0),
                                  borderSide: new BorderSide(),
                                ),
                              ),
                              validator: (value) => value!.isEmpty
                                  ? 'Insira o codigo de desconto'
                                  : null,
                            ),
                            SizedBox(
                              height: Get.height * 0.01,
                            ),
                          ],
                        )
                      : Container(),
                ),
                  Container(
                  height: Get.height * 0.3,
                  child: ListView(
                    padding: EdgeInsets.all(0.0),
                    children: [
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
                              WebsafeSvg.network(AppImages.pay_pal),
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
                              WebsafeSvg.network(AppImages.ideal),
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              WebsafeSvg.network(AppImages.kbc),
                              Padding(
                                padding: const EdgeInsets.only(left: 10.0),
                                child: Text(
                                  "KBC/CBC Payment Button",
                                  style: TextStyle(
                                    fontFamily: AppFonts.poppinsBoldFont,
                                  ),
                                ),
                              )
                            ],
                          ),
                          Radio(
                            value: 4,
                            groupValue: val,
                            onChanged: (value) {
                              setState(() {
                                val = 4;
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
                              WebsafeSvg.network(AppImages.giropay),
                              Padding(
                                padding: const EdgeInsets.only(left: 10.0),
                                child: Text(
                                  "Giropay",
                                  style: TextStyle(
                                    fontFamily: AppFonts.poppinsBoldFont,
                                  ),
                                ),
                              )
                            ],
                          ),
                          Radio(
                            value: 5,
                            groupValue: val,
                            onChanged: (value) {
                              setState(() {
                                val = 5;
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
                              WebsafeSvg.network(AppImages.sofort),
                              Padding(
                                padding: const EdgeInsets.only(left: 10.0),
                                child: Text(
                                  "SOFORT Banking",
                                  style: TextStyle(
                                    fontFamily: AppFonts.poppinsBoldFont,
                                  ),
                                ),
                              )
                            ],
                          ),
                          Radio(
                            value: 6,
                            groupValue: val,
                            onChanged: (value) {
                              setState(() {
                                val = 6;
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
                              WebsafeSvg.network(AppImages.belfius),
                              Padding(
                                padding: const EdgeInsets.only(left: 10.0),
                                child: Text(
                                  "Belfius Direct Net",
                                  style: TextStyle(
                                    fontFamily: AppFonts.poppinsBoldFont,
                                  ),
                                ),
                              )
                            ],
                          ),
                          Radio(
                            value: 7,
                            groupValue: val,
                            onChanged: (value) {
                              setState(() {
                                val = 7;
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
                              WebsafeSvg.network(AppImages.bancontact),
                              Padding(
                                padding: const EdgeInsets.only(left: 10.0),
                                child: Text(
                                  "Bancontact",
                                  style: TextStyle(
                                    fontFamily: AppFonts.poppinsBoldFont,
                                  ),
                                ),
                              )
                            ],
                          ),
                          Radio(
                            value: 8,
                            groupValue: val,
                            onChanged: (value) {
                              setState(() {
                                val = 8;
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
                              WebsafeSvg.network(AppImages.przelewy),
                              Padding(
                                padding: const EdgeInsets.only(left: 10.0),
                                child: Text(
                                  "Przelewy24",
                                  style: TextStyle(
                                    fontFamily: AppFonts.poppinsBoldFont,
                                  ),
                                ),
                              )
                            ],
                          ),
                          Radio(
                            value: 9,
                            groupValue: val,
                            onChanged: (value) {
                              setState(() {
                                val = 9;
                              });
                            },
                            activeColor: Colors.green,
                          ),
                        ],
                      ),
                    ],
                  ),
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
                TextFormField(
                  controller: input_cartao,
                  keyboardType: TextInputType.number,
                  style: TextStyle(
                    fontFamily: AppFonts.poppinsRegularFont,
                  ),
                  decoration: InputDecoration(
                    filled: false,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: new BorderRadius.circular(35.0),
                      borderSide: new BorderSide(),
                    ),
                  ),
                  validator: (value) =>
                      value!.isEmpty ? 'Número do cartão' : null,
                ),
                SizedBox(height: Get.height * 0.01),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Expiração",
                          style: TextStyle(
                            fontFamily: AppFonts.poppinsRegularFont,
                            fontSize: Get.width * 0.035,
                          ),
                        ),
                        SizedBox(height: Get.height * 0.01),
                        Container(
                          width: Get.width * 0.3,
                          child: TextFormField(
                            controller: input_data_expiracao,
                             keyboardType: TextInputType.number,
                            style: TextStyle(
                              fontFamily: AppFonts.poppinsRegularFont,
                            ),
                            decoration: InputDecoration(
                              filled: false,
                              fillColor: Colors.white,
                              border: OutlineInputBorder(
                                borderRadius: new BorderRadius.circular(35.0),
                                borderSide: new BorderSide(),
                              ),
                            ),
                            validator: (value) =>
                                value!.isEmpty ? 'Número do data' : null,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "CVV2",
                          style: TextStyle(
                            fontFamily: AppFonts.poppinsRegularFont,
                            fontSize: Get.width * 0.035,
                          ),
                        ),
                        SizedBox(height: Get.height * 0.01),
                        Container(
                          width: Get.width * 0.3,
                          child: TextFormField(
                             keyboardType: TextInputType.number,
                            controller: input_ccv,
                            style: TextStyle(
                              fontFamily: AppFonts.poppinsRegularFont,
                            ),
                            decoration: InputDecoration(
                              filled: false,
                              fillColor: Colors.white,
                              border: OutlineInputBorder(
                                borderRadius: new BorderRadius.circular(35.0),
                                borderSide: new BorderSide(),
                              ),
                            ),
                            validator: (value) =>
                                value!.isEmpty ? 'insira ccv' : null,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: Get.height * 0.02),
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
                    onPressed: validateAndSave,
                    shape: RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(30.0),
                    ),
                  ),
                ),
                SizedBox(height: Get.height * 0.02),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
