import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_session/flutter_session.dart';
import 'package:get/get.dart';
import 'package:manda_bai/Controller/request.dart';
import 'package:manda_bai/Controller/static_config.dart';
import 'package:manda_bai/Core/app_colors.dart';
import 'package:manda_bai/Core/app_fonts.dart';
import 'package:manda_bai/Core/app_images.dart';
import 'package:manda_bai/Model/location.dart';
import 'package:manda_bai/UI/location_destination/components/item_location.dart';
import 'package:manda_bai/UI/location_destination/page/new_destination.dart';
import 'package:readmore/readmore.dart';
import 'checkout_page_step_3.dart';

class CheckoutPageStep2 extends StatefulWidget {
  const CheckoutPageStep2({Key? key}) : super(key: key);

  @override
  _CheckoutPageStep2State createState() => _CheckoutPageStep2State();
}

class _CheckoutPageStep2State extends State<CheckoutPageStep2> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final input_info = TextEditingController();
  Future<void> validateAndSave() async {
    final FormState? form = _formKey.currentState;
    if (form!.validate()) {
      print('Form is valid');
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => CheckoutPageStep3(),
        ),
      );
    } else {
      print('Form is invalid');
    }
  }

  List<Location> list_location = [];
  Future _carregarLocation() async {
    if (list_location.isEmpty) {
      list_location = await ServiceRequest.loadLocation();

      if (list_location.isEmpty) {
        return null;
      }
    }
    return list_location;
  }

  String island = "";
  Future _carregarIsland() async {
    island = await FlutterSession().get('island');
    return island;
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
                            return Scaffold(
                              backgroundColor: Colors.transparent,
                              body: Center(
                                child: Container(
                                  width: Get.width,
                                  height: Get.height * 0.6,
                                  margin: EdgeInsets.only(left: 20, right: 20),
                                  decoration: BoxDecoration(
                                    color: Theme.of(context)
                                        .scaffoldBackgroundColor,
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
                                        Padding(
                                          padding: EdgeInsets.only(
                                            left: Get.width * 0.05,
                                            right: Get.width * 0.05,
                                          ),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.stretch,
                                            children: [
                                              SizedBox(
                                                  height: Get.height * 0.01),
                                              Text(
                                                'Informações do Formulário',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .headline2,
                                              ),
                                              SizedBox(
                                                  height: Get.height * 0.01),
                                              Text(
                                                'Neste formulário, deverá completar com os dados da pessoa receptora da encomenda (produtos).',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .headline4,
                                              ),
                                              SizedBox(
                                                  height: Get.height * 0.01),
                                              Text(
                                                '1º "Nome"',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .headline2,
                                              ),
                                              Text(
                                                ' Escreva o Nome da Pessoa que irá receber a encomenda;',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .headline4,
                                              ),
                                              SizedBox(
                                                  height: Get.height * 0.01),
                                              Text(
                                                '2º "Cidade"',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .headline2,
                                              ),
                                              Text(
                                                'Escreva a Cidade onde reside essa Pessoa acima referida;',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .headline4,
                                              ),
                                              SizedBox(
                                                  height: Get.height * 0.01),
                                              Text(
                                                '3º "Endereço"',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .headline2,
                                              ),
                                              Text(
                                                'Escreva o Endereço onde deverá ser entregue a encomenda;',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .headline4,
                                              ),
                                              SizedBox(
                                                  height: Get.height * 0.01),
                                              Text(
                                                '4º "Telemovel/Telefone"',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .headline2,
                                              ),
                                              Text(
                                                'Introduza o Contacto do receptor para podermos lhe contactar.',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .headline4,
                                              ),
                                              SizedBox(
                                                  height: Get.height * 0.02),
                                              Text(
                                                'Informação Adicional',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .headline2,
                                              ),
                                              SizedBox(
                                                  height: Get.height * 0.01),
                                              Text(
                                                'Neste campo, poderá adicionar qualquer informação extra que deseja informar a Empresa. Exemplo: a data que deseja a ser entregue.',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .headline4,
                                              ),
                                              SizedBox(
                                                height: Get.height * 0.02,
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
                SizedBox(height: Get.height * 0.02),
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "Faturação e Envio",
                    style: Theme.of(context).textTheme.headline1,
                  ),
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      ReadMoreText(
                        ver_dados_pessoais,
                        trimLines: 2,
                        colorClickableText: AppColors.greenColor,
                        trimMode: TrimMode.Line,
                        trimCollapsedText: 'Ver os dados',
                        trimExpandedText: 'Fechar',
                        style: Theme.of(context).textTheme.headline4,
                        moreStyle: TextStyle(
                          fontSize: 14,
                          fontFamily: AppFonts.poppinsRegularFont,
                          color: AppColors.greenColor,
                        ),
                      ),
                      SizedBox(height: Get.height * 0.01),
                      Text(
                        "Dados do Destinário",
                        style: Theme.of(context).textTheme.headline1,
                      ),
                      SizedBox(height: Get.height * 0.01),
                      Row(
                        children: [
                          Text(
                            "Ilha: ",
                            style: Theme.of(context).textTheme.headline2,
                          ),
                          FutureBuilder(
                              future: _carregarIsland(),
                              builder: (BuildContext context,
                                  AsyncSnapshot snapshot) {
                                if (snapshot.data == null) {
                                  return const Text(" ");
                                } else {
                                  return Text(
                                    island,
                                    style:
                                        Theme.of(context).textTheme.headline2,
                                  );
                                }
                              }),
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  height: Get.height * 0.35,
                  child: FutureBuilder(
                    future: _carregarLocation(),
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      switch (snapshot.connectionState) {
                        case ConnectionState.waiting:
                          return Container(
                            height: Get.height * 0.2,
                            width: Get.width,
                            child: Center(
                              child: Image.asset(
                                AppImages.loading,
                                width: Get.width * 0.2,
                                height: Get.height * 0.2,
                                alignment: Alignment.center,
                              ),
                            ),
                          );
                        default:
                          if (snapshot.data == null) {
                            return TextButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            NewDestination(route: "checkout")));
                              },
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Sem localizações de entrega...",
                                    style:
                                        Theme.of(context).textTheme.headline3,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "Por Favor insera o destino de entrega",
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline3,
                                      ),
                                      Icon(
                                        Icons.add,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            );
                          } else {
                            return Container(
                              height: Get.height * 0.35,
                              child: Column(
                                children: [
                                  Align(
                                    alignment: Alignment.topRight,
                                    child: TextButton(
                                      onPressed: (){
                                         Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            NewDestination(route: "checkout")));
                                      },
                                      child:Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Text(
                                          "Adicionar outro endereço",
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline4,
                                        ),
                                        Icon(
                                          Icons.add,
                                        ),
                                      ],
                                    ),
                                    ),
                                  ),
                                  Container(
                                     height: Get.height * 0.28,
                                    child: ListView.builder(
                                      padding: EdgeInsets.only(
                                        top: 0.0,
                                        bottom: Get.height * 0.03,
                                      ),
                                      scrollDirection: Axis.vertical,
                                      itemCount: list_location.length,
                                      itemBuilder: (BuildContext context, index) {
                                        var list = list_location[index];
                                        return ItemLocation(
                                            location: list, route: "checkout");
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }
                        // }
                      }
                    },
                  ),
                ),
                SizedBox(height: Get.height * 0.02),
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "Informação Adicional",
                    style: Theme.of(context).textTheme.headline2,
                  ),
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "Notas da encomenda (opcional)",
                    style: Theme.of(context).textTheme.headline4,
                  ),
                ),
                SizedBox(height: Get.height * 0.01),
                Container(
                  height: Get.height * 0.2,
                  width: Get.width,
                  child: TextField(
                    maxLines: 10,
                    controller: input_info,
                    keyboardType: TextInputType.text,
                    style: Theme.of(context).textTheme.headline4,
                    decoration: InputDecoration(
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(width: 2, color: Colors.black54),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(width: 2, color: Colors.black54),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      hintText: 'escrever...',
                      labelStyle: Theme.of(context).textTheme.headline4,
                    ),
                  ),
                ),
                SizedBox(height: Get.height * 0.03),
              ],
            ),
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
              onPressed: validateAndSave,
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
