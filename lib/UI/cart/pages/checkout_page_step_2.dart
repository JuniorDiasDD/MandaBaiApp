import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:manda_bai/Controller/static_config.dart';
import 'package:manda_bai/Core/app_colors.dart';
import 'package:manda_bai/Core/app_fonts.dart';
import 'package:readmore/readmore.dart';
import 'checkout_page_step_3.dart';

class CheckoutPageStep2 extends StatefulWidget {
  const CheckoutPageStep2({Key? key}) : super(key: key);

  @override
  _CheckoutPageStep2State createState() => _CheckoutPageStep2State();
}

class _CheckoutPageStep2State extends State<CheckoutPageStep2> {
  /*List<String> list_ilha = [
    'Santo Antão',
    'São Vicente',
    'São Nicolau',
    'Sal',
    'Boavista',
    'Maio',
    'Santiado',
    'Fogo',
    'Brava'
  ];
   String dropdownValue="Santo Antão";*/
  List<String> list_ilha = [
    'Santo Antão',
    'São Vicente',
    'São Nicolau',
    'Sal',
    'BoaVista',
    'Maio',
    'Santiago',
    'Fogo',
    'Brava'
  ];
  late String dropdownValue;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    dropdownValue = "Santiago";
  }

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
                                    Padding(
                                      padding: EdgeInsets.only(
                                        left: Get.width * 0.04,
                                        right: Get.width * 0.04,
                                      ),
                                      child: SingleChildScrollView(
                                        child: Column(
                                          children: [
                                            Text(
                                              'Neste campo, terás de completar os dados da pessoa que irá receber os produtos.',
                                              style: TextStyle(
                                                  fontFamily:
                                                      AppFonts.poppinsBoldFont,
                                                  fontSize: Get.width * 0.03),
                                            ),
                                            SizedBox(height: Get.height * 0.05),
                                            Text(
                                              'Neste campo, terás de completar os dados da pessoa que irá receber os produtos.',
                                              style: TextStyle(
                                                  fontFamily:
                                                  AppFonts.poppinsBoldFont,
                                                  fontSize: Get.width * 0.03),
                                            ),
                                          ],
                                        ),
                                      ),
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
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    ReadMoreText(
                      ver_dados_pessoais,
                      trimLines: 2,
                      colorClickableText: AppColors.greenColor,
                      trimMode: TrimMode.Line,
                      trimCollapsedText: 'Ver os dados',
                      trimExpandedText: 'Fechar',
                      style: TextStyle(
                          fontSize: 14,
                          fontFamily: AppFonts.poppinsRegularFont,
                          color: Colors.black),
                      moreStyle: TextStyle(
                        fontSize: 14,
                        fontFamily: AppFonts.poppinsRegularFont,
                        color: AppColors.greenColor,
                      ),
                    ),
                    SizedBox(height: Get.height * 0.01),
                    Text(
                      "Dados do Destinário",
                      style: TextStyle(
                        fontFamily: AppFonts.poppinsRegularFont,
                        fontSize: Get.width * 0.035,
                      ),
                    ),
                  ],
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
                width: Get.width,
                height: Get.height * 0.055,
                padding: EdgeInsets.only(
                  left: Get.width * 0.05,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(35.0),
                  border: Border.all(
                      color: Colors.black38,
                      style: BorderStyle.solid,
                      width: 0.80),
                ),
                child: DropdownButton<String>(
                  value: dropdownValue,
                  icon: const Icon(
                    Icons.arrow_drop_down,
                  ),
                  iconSize: Get.width * 0.05,
                  elevation: 16,
                  style: TextStyle(
                    color: Colors.black,
                  ),
                  borderRadius: BorderRadius.circular(15.0),
                  underline: Container(
                    height: 0,
                    color: Colors.transparent,
                  ),
                  onChanged: (String? newValue) {
                    setState(() {
                      dropdownValue = newValue!;
                    });
                  },
                  items:
                      list_ilha.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
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
              SizedBox(height: Get.height * 0.03),
              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  "Informação Adicional",
                  style: TextStyle(
                      fontFamily: AppFonts.poppinsBoldFont,
                      fontSize: Get.width * 0.045),
                ),
              ),
              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  "Notas da encomenda (opcional)",
                  style: TextStyle(
                    fontFamily: AppFonts.poppinsRegularFont,
                    fontSize: Get.width * 0.035,
                  ),
                ),
              ),
              SizedBox(height: Get.height * 0.01),
              Container(
                height: Get.height * 0.2,
                width: Get.width,
                child: TextField(
                  maxLines: 10,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(width: 1, color: Colors.black54),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    hintText: 'escrever...',
                    labelStyle: TextStyle(
                      color: Colors.black87,
                    ),
                  ),
                ),
              ),
              SizedBox(height: Get.height * 0.12),
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
                    builder: (context) => CheckoutPageStep3(),
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
