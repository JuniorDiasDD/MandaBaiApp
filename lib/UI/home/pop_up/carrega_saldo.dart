import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:manda_bai/Core/app_colors.dart';
import 'package:manda_bai/Core/app_fonts.dart';
import 'package:manda_bai/Core/app_images.dart';
import 'package:manda_bai/UI/home/pop_up/pop_up_message.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
class Carrega_Saldo extends StatefulWidget {
  const Carrega_Saldo({Key? key}) : super(key: key);

  @override
  _Carrega_SaldoState createState() => _Carrega_SaldoState();
}

class _Carrega_SaldoState extends State<Carrega_Saldo> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final input_number = TextEditingController();
  final input_montante = TextEditingController();
  Future<void> validateAndSave() async {
    final FormState? form = _formKey.currentState;
    if (form!.validate()) {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return Pop_up_Message(
                mensagem:
                    AppLocalizations.of(context)!.text_unavailable_service,
                icon: Icons.device_unknown_sharp,
                caminho: "erro");
          });
      print('Form is valid');
    } else {
      print('Form is invalid');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
        child: Container(
          width: Get.width,
          height: Get.height * 0.45,
          margin:
              EdgeInsets.only(left: Get.width * 0.12, right: Get.width * 0.12),
          decoration: BoxDecoration(
            color: Theme.of(context).scaffoldBackgroundColor,
            borderRadius: BorderRadius.circular(12),
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                        left: Get.width * 0.04,
                      ),
                      child: Image.network(
                        AppImages.cvmovel,
                        width: Get.width * 0.05,
                        height: Get.width * 0.05,
                      ),
                    ),
                    Text(
                      'Saldo CvMovel',
                      style: Theme.of(context).textTheme.headline1,
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
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(height: Get.height * 0.01),
                        Text(
                           AppLocalizations.of(context)!.textfield_phone_number,
                          style: Theme.of(context).textTheme.headline2,
                        ),
                        SizedBox(height: Get.height * 0.02),
                        SizedBox(
                          width: Get.width * 0.055,
                          child: TextFormField(
                            controller: input_number,
                            keyboardType: TextInputType.number,
                            obscureText: false,
                            style: Theme.of(context).textTheme.headline4,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Theme.of(context).backgroundColor,
                              border: OutlineInputBorder(
                                borderRadius:  BorderRadius.circular(15.0),
                                borderSide:  const BorderSide(),
                              ),
                              prefixIcon: Padding(
                                padding: const EdgeInsets.all(13.0),
                                child:   Text("+238",style:Theme.of(context).textTheme.headline4,),// icon is 48px widget.
                              ),
                              labelText: AppLocalizations.of(context)!.label_number
                            ),
                            validator: (value) =>
                                value!.length == 7 ? null : AppLocalizations.of(context)!.validator_number,
                          ),
                        ),
                        SizedBox(height: Get.height * 0.01),
                        Text(
                          AppLocalizations.of(context)!.textfield_amount,
                          style: Theme.of(context).textTheme.headline2,
                        ),
                        SizedBox(height: Get.height * 0.01),
                        SizedBox(
                          width: Get.width * 0.055,
                          child: TextFormField(
                            controller: input_montante,
                            keyboardType: TextInputType.number,
                            obscureText: false,
                            style: Theme.of(context).textTheme.headline4,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Theme.of(context).backgroundColor,
                              border: OutlineInputBorder(
                                borderRadius:  BorderRadius.circular(15.0),
                                borderSide:  const BorderSide(),
                              ),
                              prefixIcon: const Padding(
                                padding: EdgeInsets.all(0.0),
                                child: Icon(
                                  Icons.attach_money,
                                ), // icon is 48px widget.
                              ),
                              labelText: AppLocalizations.of(context)!.textfield_amount,
                            ),
                            validator: (value) =>
                                value!.isEmpty ? AppLocalizations.of(context)!.validator_amount : null,
                          ),
                        ),
                        SizedBox(height: Get.height * 0.03),
                        Container(
                          height: Get.height * 0.07,
                          width: Get.width,
                          decoration: BoxDecoration(
                            color: AppColors.greenColor,
                            borderRadius: const BorderRadius.all(
                              Radius.circular(15),
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Theme.of(context).cardColor,
                                blurRadius: 2.0,
                                spreadRadius: 0.0,
                                offset: const Offset(
                                    2.0, 2.0), 
                              ),
                            ],
                          ),
                          child: TextButton(
                            child: Text(
                              AppLocalizations.of(context)!.button_send,
                              style: TextStyle(
                                  fontFamily: AppFonts.poppinsRegularFont,
                                  fontSize: Get.width * 0.035,
                                  color: Colors.white),
                            ),
                            onPressed: validateAndSave,
                          ),
                        ),
                        SizedBox(height: Get.height * 0.02),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
