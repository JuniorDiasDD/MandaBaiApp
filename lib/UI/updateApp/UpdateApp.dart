import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:manda_bai/UI/widget/button_ui.dart';
import 'package:manda_bai/constants/controllers.dart';

class UpdateApp extends StatefulWidget {
  const UpdateApp({Key? key}) : super(key: key);

  @override
  State<UpdateApp> createState() => _UpdateAppState();
}

class _UpdateAppState extends State<UpdateApp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Spacer(),
          Icon(
            Icons.update,
            size: 150,
            color: Colors.green,
          ),
          Text(
            AppLocalizations.of(context)!.title_update_app,
            style: Theme.of(context).textTheme.headline1,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              AppLocalizations.of(context)!.description_update_app,
              style: Theme.of(context).textTheme.headline4,
              textAlign: TextAlign.center,
            ),
          ),
         const Spacer(),
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: ButtonUI(
              label: AppLocalizations.of(context)!.button_update,
              action: () {
                fullControllerController.sendStore();
              },
            ),
          ),
        ],
      ),
    );
  }
}
