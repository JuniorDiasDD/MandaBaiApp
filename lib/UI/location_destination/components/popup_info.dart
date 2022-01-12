import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class PopupInfo extends StatelessWidget {
  const PopupInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
        child: Container(
          width: Get.width,
          height: Get.height * 0.6,
          margin: const EdgeInsets.only(left: 20, right: 20),
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
                    Container(
                      width: Get.width * 0.08,
                    ),
                    Text(
                       AppLocalizations.of(context)!.title_instructions,
                      style: Theme.of(context).textTheme.headline1,
                    ),
                    IconButton(
                      icon: const Icon(Icons.close),
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
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      SizedBox(height: Get.height * 0.01),
                      Text(
                       AppLocalizations.of(context)!.text_information_form,
                        style: Theme.of(context).textTheme.headline2,
                      ),
                      SizedBox(height: Get.height * 0.01),
                      Text(
                         AppLocalizations.of(context)!.text_description_form,
                        style: Theme.of(context).textTheme.headline4,
                      ),
                      SizedBox(height: Get.height * 0.01),
                      Text(
                        '1º "'+ AppLocalizations.of(context)!.textfield_name+'"',
                        style: Theme.of(context).textTheme.headline2,
                      ),
                      Text(
                         AppLocalizations.of(context)!.text_person_name,
                        style: Theme.of(context).textTheme.headline4,
                      ),
                      SizedBox(height: Get.height * 0.01),
                      Text(
                        '2º "'+ AppLocalizations.of(context)!.textfield_city+'"',
                        style: Theme.of(context).textTheme.headline2,
                      ),
                      Text(
                         AppLocalizations.of(context)!.text_city_name,
                        style: Theme.of(context).textTheme.headline4,
                      ),
                      SizedBox(height: Get.height * 0.01),
                      Text(
                        '3º "'+ AppLocalizations.of(context)!.text_address+'"',
                        style: Theme.of(context).textTheme.headline2,
                      ),
                      Text(
                         AppLocalizations.of(context)!.text_adress_name,
                        style: Theme.of(context).textTheme.headline4,
                      ),
                      SizedBox(height: Get.height * 0.01),
                      Text(
                        '4º "'+ AppLocalizations.of(context)!.labeltext_phone_or_mobile+'"',
                        style: Theme.of(context).textTheme.headline2,
                      ),
                      Text(
                         AppLocalizations.of(context)!.text_enter_contact,
                        style: Theme.of(context).textTheme.headline4,
                      ),
                      SizedBox(height: Get.height * 0.02),
                      Text(
                         AppLocalizations.of(context)!.subtitle_add_information,
                        style: Theme.of(context).textTheme.headline2,
                      ),
                      SizedBox(height: Get.height * 0.01),
                      Text(
                        AppLocalizations.of(context)!.text_add_information,
                        style: Theme.of(context).textTheme.headline4,
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
  }
}
