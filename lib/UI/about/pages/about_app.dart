import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Privacy_Policy extends StatelessWidget {

  int info;

 Privacy_Policy({Key? key, required this.info}) : super(key: key);

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
                  info==0?AppLocalizations.of(context)!
                      .title_privacy_police:AppLocalizations.of(context)!
                      .title_terms_of_use,
                  style: Theme.of(context).textTheme.headline1,
                ),
                Container(
                  width: Get.width * 0.03,
                ),
              ],
            ),
            SizedBox(height: Get.height * 0.03),
            Padding(
              padding:  EdgeInsets.only(
                left: Get.width * 0.01, right: Get.width * 0.01,),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      info==0?AppLocalizations.of(context)!
                          .subtitle_privacy_police:AppLocalizations.of(context)!
                          .subtitle_terms_of_use,
                        style: Theme.of(context).textTheme.headline2,
                    ),
                  ),
                  SizedBox(height: Get.height * 0.01),
                   Html(
                    data: info == 0
                        ? AppLocalizations.of(context)!
                        .text_privacy_police:AppLocalizations.of(context)!
                        .text_terms_of_use,
                       //  style: TextStyle(Theme.of(context).textTheme.headline1),
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
