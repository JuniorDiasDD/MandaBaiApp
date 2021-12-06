import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:manda_bai/Core/app_colors.dart';
import 'package:manda_bai/Core/app_fonts.dart';
import 'package:manda_bai/UI/about/components/item_bio.dart';
import 'package:manda_bai/data/madaBaiData.dart';
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
                    style: Theme.of(context).textTheme.headline1,
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
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        'MandaBai, somos mais que uma Empresa!',

                          style: Theme.of(context).textTheme.headline1,
                      ),
                    ),
                    SizedBox(height: Get.height * 0.02),
                    ReadMoreText(
                      description_mandabai,
                      trimLines: 2,
                      colorClickableText: AppColors.greenColor,
                      trimMode: TrimMode.Line,
                      trimCollapsedText: 'Ver mais',
                      trimExpandedText: 'Fechar',
                      style:  Theme.of(context).textTheme.headline4,
                      moreStyle:
                          Theme.of(context).textTheme.headline6,

                    ),
                    SizedBox(height: Get.height * 0.04),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        'Constituição da Empresa',
                        style: Theme.of(context).textTheme.headline2,
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
                        color: Theme.of(context).cardColor,
                        borderRadius: BorderRadius.all(
                          Radius.circular(15),
                        ),
                        border: Border.all(color: Colors.black12, width: Get.width * 0.001),
                      ),
                      child: ExpansionTile(
                        backgroundColor:  Theme.of(context).cardColor,
                        iconColor: AppColors.greenColor,
                        title: Text(
                          "Missão",
                            style: Theme.of(context).textTheme.headline5,
                        ),
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.all(15.0),
                            child: Text(
                              description_missao,
                              textAlign: TextAlign.start,
                              style: Theme.of(context).textTheme.headline4,
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
                        color: Theme.of(context).cardColor,
                        borderRadius: BorderRadius.all(
                          Radius.circular(15),
                        ),
                        border: Border.all(color: Colors.black12, width: Get.width * 0.001),
                      ),
                      child: ExpansionTile(
                        backgroundColor:  Theme.of(context).cardColor,
                        iconColor: AppColors.greenColor,
                        title: Text(
                          "Visão",
                          style: Theme.of(context).textTheme.headline5,
                        ),
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.all(15.0),
                            child: Text(
                              description_visao,
                              textAlign: TextAlign.start,
                              style: Theme.of(context).textTheme.headline4,
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
                        color: Theme.of(context).cardColor,
                        borderRadius: BorderRadius.all(
                          Radius.circular(15),
                        ),
                        border: Border.all(color: Colors.black12, width: Get.width * 0.001),
                      ),
                      child: ExpansionTile(
                        backgroundColor: Theme.of(context).cardColor,
                        iconColor: AppColors.greenColor,
                        title: Text(
                          "Valores",
                          style: Theme.of(context).textTheme.headline5,
                        ),
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.all(15.0),
                            child: Text(
                              description_valores,
                              textAlign: TextAlign.start,
                                style: Theme.of(context).textTheme.headline4
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
                              color: Theme.of(context).cardColor,
                              height: 36,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            left: Get.width * 0.05,
                            right: Get.width * 0.05,
                          ),
                          child: Text("Sobre Aplicação",
                              style: Theme.of(context).textTheme.headline4,
                          ),
                        ),
                        Expanded(
                          child: Container(
                            width: Get.width * 0.4,
                            child: Divider(
                              color: Theme.of(context).cardColor,
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
                          color: Theme.of(context).cardColor,
                          borderRadius: BorderRadius.all(
                              Radius.circular(15)
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
                                    style: Theme.of(context).textTheme.headline4,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                  right: Get.width * 0.02,
                                ),
                                child: Text(
                                  'MandaBai  >',
                                    style: Theme.of(context).textTheme.headline4,
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
                          color: Theme.of(context).cardColor,
                          borderRadius: BorderRadius.all(
                              Radius.circular(15)
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
                                    style: Theme.of(context).textTheme.headline4,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                  right: Get.width * 0.02,
                                ),
                                child: Text(
                                  'MandaBai  >',
                                    style: Theme.of(context).textTheme.headline4,
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
                          color: Theme.of(context).cardColor,
                          borderRadius: BorderRadius.all(
                            Radius.circular(15),
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
                                    style: Theme.of(context).textTheme.headline4,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                  right: Get.width * 0.02,
                                ),
                                child: Text(
                                  ' >',
                                    style: Theme.of(context).textTheme.headline4,
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
                          color: Theme.of(context).cardColor,
                          borderRadius: BorderRadius.all(
                            Radius.circular(15),
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
                                    style: Theme.of(context).textTheme.headline4
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                  right: Get.width * 0.02,
                                ),
                                child: Text(
                                  'MandaBai  >',
                                    style: Theme.of(context).textTheme.headline4,
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
