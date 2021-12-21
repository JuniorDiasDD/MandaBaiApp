import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Termos_de_Uso_Privacy_Policy extends StatelessWidget {
  const Termos_de_Uso_Privacy_Policy({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding:
            EdgeInsets.only(left: Get.width * 0.04, right: Get.width * 0.04),
        child: SingleChildScrollView(
          child: Column(children: [
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
                  AppLocalizations.of(context)!.title_termos_of_use_and_privacy_police,
                  style: Theme.of(context).textTheme.headline1,
                ),
                Container(
                  width: Get.width * 0.03,
                ),
              ],
            ),
            SizedBox(height: Get.height * 0.04),
            Padding(
              padding: EdgeInsets.only(
                  left: Get.width * 0.01, right: Get.width * 0.01),
              child: Text(
                'ddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd',
              ),
            )
          ],
          ),
        ),
      ),
    );
  }
}
