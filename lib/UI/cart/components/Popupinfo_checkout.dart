import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class PopupInfo_Checkout extends StatelessWidget {
  const PopupInfo_Checkout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
        child: Container(
          width: Get.width,
          height: Get.height * 0.35,
          margin: const EdgeInsets.only(left: 20, right: 20),
          decoration: BoxDecoration(
            color: Theme.of(context).scaffoldBackgroundColor,
            borderRadius: BorderRadius.circular(12),
          ),
          child: SingleChildScrollView(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
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
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [

    Text(
      AppLocalizations.of(context)!.text_information,
    style: Theme.of(context).textTheme.headline2,
    ),
    SizedBox(height: Get.height * 0.01),
    Text(
        AppLocalizations.of(context)!.text_information_checkout,
    style: Theme.of(context).textTheme.headline4,
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
