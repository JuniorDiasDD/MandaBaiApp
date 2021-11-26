import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:manda_bai/Controller/static_config.dart';
import 'package:manda_bai/Core/app_colors.dart';
import 'package:manda_bai/Core/app_fonts.dart';
import 'package:manda_bai/UI/about/components/item_bio.dart';
import 'package:readmore/readmore.dart';

class InfoPage extends StatelessWidget {
  const InfoPage({Key? key}) : super(key: key);

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

                      ),
                      alignment: Alignment.centerRight,
                    ),
                  ),
                  Text(
                    'Sobre Nós',
                    style: TextStyle(
                        fontFamily: AppFonts.poppinsBoldFont,
                        fontSize: Get.width * 0.05),
                  ),
                  Container(
                    width: Get.width * 0.08,
                  ),
                ],
              ),
              SizedBox(height: Get.height * 0.02),
              Padding(
                padding: EdgeInsets.only(
                    left: Get.width * 0.01, right: Get.width * 0.01),
                child: Column(
                  children: [
                    Text(
                      'MandaBai, somos mais que uma Empresa!',
                      style: TextStyle(
                          fontFamily: AppFonts.poppinsBoldFont,
                          color: AppColors.greenColor,
                          fontSize: Get.width * 0.05),
                    ),
                    SizedBox(height: Get.height * 0.02),
                    ReadMoreText(
                      description_mandabai,
                      trimLines: 2,
                      colorClickableText: AppColors.greenColor,
                      trimMode: TrimMode.Line,
                      trimCollapsedText: 'Ver mais',
                      trimExpandedText: 'Fechar',
                      style: const TextStyle(
                          fontSize: 14,
                          fontFamily: AppFonts.poppinsRegularFont,
                          ),
                      moreStyle: const TextStyle(
                          fontSize: 14,
                          fontFamily: AppFonts.poppinsRegularFont,
                          color: AppColors.greenColor),
                    ),
                    SizedBox(height: Get.height * 0.04),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        'Constituição da Empresa',
                        style: TextStyle(
                            fontFamily: AppFonts.poppinsBoldFont,

                            fontSize: Get.width * 0.045),
                      ),
                    ),
                    Container(
                        width: Get.width,
                        height: Get.height * 0.3,
                        child: ListView(
                          padding: EdgeInsets.all(0.0),
                          children: [Item_Bio()],
                        )),
                    SizedBox(height: Get.height * 0.04),
                    Container(
                      margin: EdgeInsets.only(
                        left: Get.width * 0.01,
                        right: Get.width * 0.01,
                        top: Get.height * 0.02,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(
                          Radius.circular(Get.width * 0.04),
                        ),
                        border: Border.all(color: Colors.black12, width: 1.0),
                      ),
                      child: ExpansionTile(
                        backgroundColor: Colors.white,
                        title: Text(
                          "Missão",
                          style: TextStyle(
                              fontFamily: AppFonts.poppinsBoldFont,
                              color: AppColors.greenColor,
                              fontSize: Get.width * 0.04),
                        ),
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(
                                left: Get.width * 0.06,
                                right: Get.width * 0.06),
                            child: Text(
                              description_missao,
                              textAlign: TextAlign.justify,
                              style: TextStyle(
                                  fontFamily: AppFonts.poppinsRegularFont,
                                  color: Colors.black,
                                  fontSize: Get.width * 0.03),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(
                        left: Get.width * 0.01,
                        right: Get.width * 0.01,
                        top: Get.height * 0.02,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(
                          Radius.circular(Get.width * 0.04),
                        ),
                        border: Border.all(color: Colors.black12, width: 1.0),
                      ),
                      child: ExpansionTile(
                        backgroundColor: Colors.white,
                        title: Text(
                          "Visão",
                          style: TextStyle(
                              fontFamily: AppFonts.poppinsBoldFont,
                              color: AppColors.greenColor,
                              fontSize: Get.width * 0.04),
                        ),
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(
                                left: Get.width * 0.06,
                                right: Get.width * 0.06),
                            child: Text(
                              description_visao,
                              textAlign: TextAlign.justify,
                              style: TextStyle(
                                  fontFamily: AppFonts.poppinsRegularFont,
                                  color: Colors.black,
                                  fontSize: Get.width * 0.03),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(
                        left: Get.width * 0.01,
                        right: Get.width * 0.01,
                        top: Get.height * 0.02,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(
                          Radius.circular(Get.width * 0.04),
                        ),
                        border: Border.all(color: Colors.black12, width: 1.0),
                      ),
                      child: ExpansionTile(
                        backgroundColor: Colors.white,
                        title: Text(
                          "Valores",
                          style: TextStyle(
                              fontFamily: AppFonts.poppinsBoldFont,
                              color: AppColors.greenColor,
                              fontSize: Get.width * 0.04),
                        ),
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(
                                left: Get.width * 0.06,
                                right: Get.width * 0.06),
                            child: Text(
                              description_valores,
                              textAlign: TextAlign.justify,
                              style: TextStyle(
                                  fontFamily: AppFonts.poppinsRegularFont,
                                  color: Colors.black,
                                  fontSize: Get.width * 0.03),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: Get.height * 0.03),
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: new Container(
                            width: Get.width * 0.1,
                            child: Divider(
                              color: Colors.black,
                              height: 36,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            left: Get.width * 0.05,
                            right: Get.width * 0.05,
                          ),
                          child: Text("Sobre Aplicação"),
                        ),
                        Expanded(
                          child: Container(
                            width: Get.width * 0.4,
                            child: const Divider(
                              color: Colors.black,
                              height: 36,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: Get.height * 0.01),
                    Padding(
                      padding: EdgeInsets.only(
                          left: Get.width * 0.01, right: Get.width * 0.01),
                      child: Container(
                        height: Get.height * 0.06,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(
                            Radius.circular(8),
                          ),
                          border: Border.all(
                            color: Colors.black38,
                          ),
                        ),
                        child: TextButton(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(
                                  left: Get.width * 0.02,
                                ),
                                child: Text(
                                  'Publicado por',
                                  style: TextStyle(
                                    fontFamily: AppFonts.poppinsRegularFont,
                                    color: Colors.black,
                                    fontSize: Get.height * 0.018,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                  right: Get.width * 0.02,
                                ),
                                child: Text(
                                  'MandaBai  >',
                                  style: TextStyle(
                                    fontFamily: AppFonts.poppinsRegularFont,
                                    color: Colors.black,
                                    fontSize: Get.height * 0.018,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          onPressed: () {},
                        ),
                      ),
                    ),
                    SizedBox(height: Get.height * 0.02),
                    Padding(
                      padding: EdgeInsets.only(
                          left: Get.width * 0.01, right: Get.width * 0.01),
                      child: Container(
                        height: Get.height * 0.06,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(
                            Radius.circular(8),
                          ),
                          border: Border.all(
                            color: Colors.black38,
                          ),
                        ),
                        child: TextButton(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(
                                  left: Get.width * 0.02,
                                ),
                                child: Text(
                                  'Desenvolvido por',
                                  style: TextStyle(
                                    fontFamily: AppFonts.poppinsRegularFont,
                                    color: Colors.black,
                                    fontSize: Get.height * 0.018,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                  right: Get.width * 0.02,
                                ),
                                child: Text(
                                  'MandaBai  >',
                                  style: TextStyle(
                                    fontFamily: AppFonts.poppinsRegularFont,
                                    color: Colors.black,
                                    fontSize: Get.height * 0.018,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          onPressed: () {},
                        ),
                      ),
                    ),
                    SizedBox(height: Get.height * 0.01),
                    Padding(
                      padding: EdgeInsets.only(
                          left: Get.width * 0.01, right: Get.width * 0.01),
                      child: Container(
                        height: Get.height * 0.06,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(
                            Radius.circular(8),
                          ),
                          border: Border.all(
                            color: Colors.black38,
                          ),
                        ),
                        child: TextButton(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(
                                  left: Get.width * 0.02,
                                ),
                                child: Text(
                                  'Termos de Uso',
                                  style: TextStyle(
                                    fontFamily: AppFonts.poppinsRegularFont,
                                    color: Colors.black,
                                    fontSize: Get.height * 0.018,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                  right: Get.width * 0.02,
                                ),
                                child: Text(
                                  ' >',
                                  style: TextStyle(
                                    fontFamily: AppFonts.poppinsRegularFont,
                                    color: Colors.black,
                                    fontSize: Get.height * 0.018,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          onPressed: () {},
                        ),
                      ),
                    ),
                    SizedBox(height: Get.height * 0.01),
                    Padding(
                      padding: EdgeInsets.only(
                          left: Get.width * 0.01, right: Get.width * 0.01),
                      child: Container(
                        height: Get.height * 0.06,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(
                            Radius.circular(8),
                          ),
                          border: Border.all(
                            color: Colors.black38,
                          ),
                        ),
                        child: TextButton(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(
                                  left: Get.width * 0.02,
                                ),
                                child: Text(
                                  'Políticas e Serviços',
                                  style: TextStyle(
                                    fontFamily: AppFonts.poppinsRegularFont,
                                    color: Colors.black,
                                    fontSize: Get.height * 0.018,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                  right: Get.width * 0.02,
                                ),
                                child: Text(
                                  'MandaBai  >',
                                  style: TextStyle(
                                    fontFamily: AppFonts.poppinsRegularFont,
                                    color: Colors.black,
                                    fontSize: Get.height * 0.018,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          onPressed: () {},
                        ),
                      ),
                    ),
                    SizedBox(height: Get.height * 0.02),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
