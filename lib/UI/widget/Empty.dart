import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:manda_bai/Core/app_fonts.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Empty extends StatelessWidget {
  const Empty({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: Get.height * 0.2,
      width: Get.width,
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.public_off_outlined,
              color: Colors.grey,
              size: Get.height * 0.06,
            ),
            Text(
              AppLocalizations.of(context)!
                  .text_unavailable_service,
              style: TextStyle(
                fontFamily: AppFonts.poppinsBoldFont,
                fontSize: Get.width * 0.035,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
