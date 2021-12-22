import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:manda_bai/Controller/cart_controller.dart';
import 'package:manda_bai/Controller/request.dart';
import 'package:manda_bai/Core/app_colors.dart';
import 'package:manda_bai/Core/app_fonts.dart';
import 'package:manda_bai/Core/app_images.dart';
import 'package:manda_bai/Model/location.dart';
import 'package:manda_bai/UI/cart/components/Popupinfo_checkout.dart';
import 'package:manda_bai/UI/home/pop_up/pop_up_message.dart';
import 'package:websafe_svg/websafe_svg.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CheckoutPageStep3 extends StatefulWidget {
  Location location;
  CheckoutPageStep3({Key? key, required this.location}) : super(key: key);

  @override
  _CheckoutPageStep3State createState() => _CheckoutPageStep3State();
}

class _CheckoutPageStep3State extends State<CheckoutPageStep3> {
  final CartPageController cartPageController = Get.find();
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
      cartPageController.loading = true;
      bool check = await ServiceRequest.createOrder(
          true,
          "processing",
          widget.location,
          cartPageController.list,
          cartPageController.total,
          cartPageController.note,
          isCheckedPromocao,
          input_codigo.text);
      if (check) {
        cartPageController.loading = false;
        return showDialog(
            context: context,
            builder: (BuildContext context) {
              return Pop_up_Message(
                  mensagem: AppLocalizations.of(context)!.message_success_order,
                  icon: Icons.check,
                  caminho: "encomenda");
            });
      } else {
        cartPageController.loading = false;
        return showDialog(
            context: context,
            builder: (BuildContext context) {
              return Pop_up_Message(
                  mensagem: AppLocalizations.of(context)!.message_error_order,
                  icon: Icons.error,
                  caminho: "erro");
            });
      }
      //  print('Form is valid');
    } else {
      print('Form is invalid');
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    cartPageController.loading = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Padding(
            padding: EdgeInsets.only(
                left: Get.width * 0.04, right: Get.width * 0.04),
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
                          style: Theme.of(context).textTheme.headline1,
                        ),
                        IconButton(
                          padding: const EdgeInsets.all(0.0),
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return PopupInfo_Checkout(
                                    title: AppLocalizations.of(context)!
                                        .title_instructions,
                                    subTitle: AppLocalizations.of(context)!
                                        .subtitle_payment,
                                    text: AppLocalizations.of(context)!
                                        .text_cuppon);
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
                        AppLocalizations.of(context)!.subtitle_payment,
                        style: Theme.of(context).textTheme.headline1,
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
                          AppLocalizations.of(context)!.text_discount,
                          style: Theme.of(context).textTheme.headline6,
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
                                    AppLocalizations.of(context)!
                                        .subtitle_code_discount,
                                    style:
                                        Theme.of(context).textTheme.headline2,
                                  ),
                                ),
                                SizedBox(
                                  height: Get.height * 0.005,
                                ),
                                TextFormField(
                                  controller: input_codigo,
                                  style: Theme.of(context).textTheme.headline4,
                                  decoration: InputDecoration(
                                    filled: true,
                                    fillColor:
                                        Theme.of(context).backgroundColor,
                                    border: OutlineInputBorder(
                                      borderRadius:
                                          new BorderRadius.circular(15.0),
                                      borderSide: new BorderSide(),
                                    ),
                                  ),
                                  validator: (value) => value!.isEmpty
                                      ? AppLocalizations.of(context)!
                                          .valitador_code_discount
                                      : null,
                                ),
                                SizedBox(
                                  height: Get.height * 0.01,
                                ),
                              ],
                            )
                          : Container(),
                    ),
                    SizedBox(
                      height: Get.height * 0.55,
                      child: ListView(
                        padding: EdgeInsets.all(0.0),
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  WebsafeSvg.asset(AppImages.credit_card),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 10.0),
                                    child: Text(
                                      "Credit Card",
                                      style:
                                          Theme.of(context).textTheme.headline4,
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  WebsafeSvg.network(AppImages.pay_pal),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 10.0),
                                    child: Text(
                                      "PayPal",
                                      style:
                                          Theme.of(context).textTheme.headline4,
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  WebsafeSvg.network(AppImages.ideal),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 10.0),
                                    child: Text(
                                      "iDEAL",
                                      style:
                                          Theme.of(context).textTheme.headline4,
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  WebsafeSvg.network(AppImages.kbc),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 10.0),
                                    child: Text(
                                      "KBC/CBC Payment Button",
                                      style:
                                          Theme.of(context).textTheme.headline4,
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  WebsafeSvg.network(AppImages.giropay),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 10.0),
                                    child: Text(
                                      "Giropay",
                                      style:
                                          Theme.of(context).textTheme.headline4,
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  WebsafeSvg.network(AppImages.sofort),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 10.0),
                                    child: Text(
                                      "SOFORT Banking",
                                      style:
                                          Theme.of(context).textTheme.headline4,
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  WebsafeSvg.network(AppImages.belfius),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 10.0),
                                    child: Text(
                                      "Belfius Direct Net",
                                      style:
                                          Theme.of(context).textTheme.headline4,
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  WebsafeSvg.network(AppImages.bancontact),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 10.0),
                                    child: Text(
                                      "Bancontact",
                                      style:
                                          Theme.of(context).textTheme.headline4,
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  WebsafeSvg.network(AppImages.przelewy),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 10.0),
                                    child: Text(
                                      "Przelewy24",
                                      style:
                                          Theme.of(context).textTheme.headline4,
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

                    /* Column(
                      children: [
                        SizedBox(height: Get.height * 0.01),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        AppLocalizations.of(context)!.subtitle_number_card,
                        style: Theme.of(context).textTheme.headline2,
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
                        filled: true,
                        fillColor: Theme.of(context).backgroundColor,
                        border: OutlineInputBorder(
                          borderRadius: new BorderRadius.circular(15.0),
                          borderSide: new BorderSide(),
                        ),
                      ),
                      validator: (value) => value!.isEmpty
                          ? AppLocalizations.of(context)!.valitador_number_card
                          : null,
                    ),
                    SizedBox(height: Get.height * 0.01),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              AppLocalizations.of(context)!.subtitle_expiration,
                              style: Theme.of(context).textTheme.headline2,
                            ),
                            SizedBox(height: Get.height * 0.01),
                            Container(
                              width: Get.width * 0.3,
                              child: TextFormField(
                                controller: input_data_expiracao,
                                keyboardType: TextInputType.number,
                                style: Theme.of(context).textTheme.headline4,
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Theme.of(context).backgroundColor,
                                  border: OutlineInputBorder(
                                    borderRadius:
                                        new BorderRadius.circular(15.0),
                                    borderSide: new BorderSide(),
                                  ),
                                ),
                                validator: (value) => value!.isEmpty
                                    ? AppLocalizations.of(context)!
                                        .valitador_number_data
                                    : null,
                              ),
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              AppLocalizations.of(context)!.subtitle_cvv2,
                              style: Theme.of(context).textTheme.headline2,
                            ),
                            SizedBox(height: Get.height * 0.01),
                            Container(
                              width: Get.width * 0.3,
                              child: TextFormField(
                                keyboardType: TextInputType.number,
                                controller: input_ccv,
                                style: Theme.of(context).textTheme.headline4,
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Theme.of(context).backgroundColor,
                                  border: OutlineInputBorder(
                                    borderRadius:
                                        new BorderRadius.circular(15.0),
                                    borderSide: new BorderSide(),
                                  ),
                                ),
                                validator: (value) => value!.isEmpty
                                    ? AppLocalizations.of(context)!
                                        .valitador_cvv2
                                    : null,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                   
                      ],
                    ),
                    */
                    SizedBox(height: Get.height * 0.02),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          AppLocalizations.of(context)!.text_total,
                          style: Theme.of(context).textTheme.headline5,
                        ),
                        Text(
                          cartPageController.total.toStringAsFixed(1),
                          style: Theme.of(context).textTheme.headline5,
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
                        child: Text(AppLocalizations.of(context)!.button_done),
                        // onPressed: validateAndSave,
                        onPressed: () => showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return Pop_up_Message(
                                  mensagem: AppLocalizations.of(context)!
                                      .text_unavailable_service,
                                  icon: Icons.device_unknown_sharp,
                                  caminho: "erro");
                            }),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                      ),
                    ),
                    SizedBox(height: Get.height * 0.02),
                  ],
                ),
              ),
            ),
          ),
          Obx(
            () => SizedBox(
              child: cartPageController.loading
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
          ),
        ],
      ),
    );
  }
}
