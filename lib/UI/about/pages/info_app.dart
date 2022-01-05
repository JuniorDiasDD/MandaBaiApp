import 'package:flutter/material.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';
import 'package:manda_bai/Core/app_images.dart';
import 'package:manda_bai/Core/app_themes.dart';
import 'package:manda_bai/UI/about/components/item_developer.dart';

class InfoApp extends StatelessWidget {
  const InfoApp({Key? key}) : super(key: key);

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
                    AppLocalizations.of(context)!.title_terms_of_use,
                    style: Theme.of(context).textTheme.headline1,
                  ),
                  Container(
                    width: Get.width * 0.03,
                  ),
                ],
              ),
              SizedBox(height: Get.height * 0.03),
              Padding(
                padding: EdgeInsets.only(
                  left: Get.width * 0.01,
                  right: Get.width * 0.01,
                ),
                child: Column(
                  children: [
                    Image.asset(
                      AppImages.appLogoIcon,
                      width: Get.width * 0.5,
                      height: Get.height * 0.1,
                      alignment: Alignment.center,
                    ),
                    Text(
                      "MandaBai",
                      style: Theme.of(context).textTheme.headline1,
                    ),
                    Text(
                      "V.1.0.0",
                      style: Theme.of(context).textTheme.headline5,
                    ),
                    SizedBox(height: Get.height * 0.01),
                    Text(
                      "MandaBai descriçao",
                      style: Theme.of(context).textTheme.headline4,
                      textAlign: TextAlign.center,
                    ),
                    Divider(),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Publicado por",
                          style: Theme.of(context).textTheme.headline1,
                        ),
                        Text(
                          "Empresa MandaBai",
                          style: Theme.of(context).textTheme.headline4,
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: Get.height * 0.01),
                        Text(
                          "Pesquisa e Desenvolvimento por",
                          style: Theme.of(context).textTheme.headline1,
                        ),
                        SizedBox(height: Get.height * 0.01),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            ItemDeveloper(
                                image:
                                    "https://www.mandabai.com/wp-content/uploads/2022/01/fotoPassPorte6.jpg",
                                name: "Júnior Dias Silva",
                                cargo: "Engenheiro / Programador"),
                            ItemDeveloper(
                                image:
                                    "https://www.mandabai.com/wp-content/uploads/2022/01/avatar_rossana.jpg",
                                name: "Rossana Mendes",
                                cargo: "Designer"),
                            ItemDeveloper(
                                image:
                                    "https://www.mandabai.com/wp-content/uploads/2022/01/avatar_erickson.jpg",
                                name: "Erickson Carvalho Vaz",
                                cargo: "Engenheiro / Programador"),
                          ],
                        ),
                        Divider(),
                        Text(
                          "Licenças e Créditos",
                          style: Theme.of(context).textTheme.headline1,
                        ),
                        SizedBox(height: Get.height * 0.01),
                        Text(
                          "Esta aplicativo se encontra em desenvolvimento Nativo base em Flutter \n Este aplicativo utiliza Material App com base no SDK 3.0.0\n",
                          style: Theme.of(context).textTheme.headline4,
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
