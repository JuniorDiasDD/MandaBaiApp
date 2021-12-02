import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:manda_bai/Core/app_colors.dart';
import 'package:manda_bai/Core/app_fonts.dart';

class Destination_Page extends StatefulWidget {
  const Destination_Page({Key? key}) : super(key: key);

  @override
  _Destination_PageState createState() => _Destination_PageState();
}

class _Destination_PageState extends State<Destination_Page> {
  final input_nome = TextEditingController();
  final input_cidade = TextEditingController();
  final input_endereco = TextEditingController();
  final input_tel = TextEditingController();
  final input_info = TextEditingController();
  final input_ilha = TextEditingController();
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
                    'Locais de Entrega',
                    style: Theme.of(context).textTheme.headline1,
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
                                height: Get.height * 0.66,
                                margin: EdgeInsets.only(left: 20, right: 20),
                                decoration: BoxDecoration(
                                  color:
                                      Theme.of(context).scaffoldBackgroundColor,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: SingleChildScrollView(
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                      left: Get.width * 0.02,
                                      right: Get.width * 0.02,
                                    ),
                                    child: Center(

                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Container(
                                                width: Get.width * 0.08,
                                              ),
                                              Text(
                                                'Formulário',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .headline1,
                                              ),
                                              IconButton(
                                                icon: Icon(Icons.close),
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                },
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                              height: Get.height * 0.001),
                                          Align(
                                            alignment: Alignment.topLeft,
                                            child: Padding(
                                              padding:  EdgeInsets.only(left:Get.width * 0.02,),
                                              child: Text(
                                                'Prenche os seguintes campos:',
                                                style: Theme.of(context).textTheme.headline3,
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                              height: Get.height * 0.01),

                                          SizedBox(
                                            width: Get.width,
                                            child: TextFormField(
                                              controller: input_nome,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .headline4,
                                              decoration: InputDecoration(
                                                labelText: "Nome do destinatário",
                                                labelStyle: Theme.of(context)
                                                    .textTheme
                                                    .headline4,
                                                filled: true,
                                                fillColor: Theme.of(context)
                                                    .backgroundColor,
                                                border: OutlineInputBorder(
                                                  borderRadius:
                                                      new BorderRadius.circular(
                                                          35.0),
                                                  borderSide: new BorderSide(
                                                      color: Colors.red,
                                                      width: 2.0),
                                                ),
                                              ),
                                              validator: (value) => value!.isEmpty
                                                  ? 'Insira o nome'
                                                  : null,
                                            ),
                                          ),
                                          SizedBox(height: Get.height * 0.01),
                                          SizedBox(
                                            width: Get.width,
                                            child: TextFormField(
                                              controller: input_cidade,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .headline4,
                                              decoration: InputDecoration(
                                                labelText: "Cidade",
                                                labelStyle: Theme.of(context)
                                                    .textTheme
                                                    .headline4,
                                                filled: true,
                                                fillColor: Theme.of(context)
                                                    .backgroundColor,
                                                border: OutlineInputBorder(
                                                  borderRadius:
                                                      new BorderRadius.circular(
                                                          35.0),
                                                  borderSide: new BorderSide(),
                                                ),
                                              ),
                                              validator: (value) => value!.isEmpty
                                                  ? 'Insira a cidade'
                                                  : null,
                                            ),
                                          ),
                                          SizedBox(height: Get.height * 0.01),
                                          SizedBox(
                                            width: Get.width,
                                            child: TextFormField(
                                              controller: input_endereco,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .headline4,
                                              decoration: InputDecoration(
                                                labelText: "Endereço",
                                                labelStyle: Theme.of(context)
                                                    .textTheme
                                                    .headline4,
                                                filled: true,
                                                fillColor: Theme.of(context)
                                                    .backgroundColor,
                                                border: OutlineInputBorder(
                                                  borderRadius:
                                                      new BorderRadius.circular(
                                                          35.0),
                                                  borderSide: new BorderSide(),
                                                ),
                                              ),
                                              validator: (value) => value!.isEmpty
                                                  ? 'Insira o Endereço'
                                                  : null,
                                            ),
                                          ),
                                          SizedBox(height: Get.height * 0.01),
                                          SizedBox(
                                            width: Get.width,
                                            child: TextFormField(
                                              controller: input_tel,
                                              keyboardType: TextInputType.number,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .headline4,
                                              decoration: InputDecoration(
                                                labelText:
                                                    "Telefone ou Telemovel",
                                                labelStyle: Theme.of(context)
                                                    .textTheme
                                                    .headline4,
                                                filled: true,
                                                fillColor: Theme.of(context)
                                                    .backgroundColor,
                                                border: OutlineInputBorder(
                                                  borderRadius:
                                                      new BorderRadius.circular(
                                                          35.0),
                                                  borderSide: new BorderSide(
                                                    color: Colors.red,
                                                  ),
                                                ),
                                              ),
                                              validator: (value) => value!.isEmpty
                                                  ? 'Insira o número'
                                                  : null,
                                            ),
                                          ),
                                          SizedBox(height: Get.height * 0.04
                                          ),
                                          Align(
                                            alignment: Alignment.center,
                                            child: Container(
                                              height: Get.height * 0.07,
                                              width: Get.width * 0.4,
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
                                                    offset: Offset(
                                                        2.0, 2.0), // changes position of shadow
                                                  ),
                                                ],
                                              ),
                                              child: TextButton(
                                                child: Text(
                                                  'Guardar',
                                                  style: TextStyle(
                                                      fontFamily: AppFonts.poppinsRegularFont,
                                                      fontSize: Get.width * 0.035,
                                                      color: Colors.white),
                                                ),
                                                onPressed: () {},
                                              ),
                                            ),
                                          ),
                                          SizedBox(height: Get.height * 0.01),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    },
                    icon: const Icon(
                      Icons.add,
                    ),
                    iconSize: Get.width * 0.05,
                    alignment: Alignment.centerRight,
                  ),
                ],
              ),
              Container(),
            ],
          ),
        ),
      ),
    );
  }
}
