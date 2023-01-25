import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:manda_bai/UI/widget/button_ui.dart';
import 'package:manda_bai/constants/controllers.dart';

class DialogCustom extends StatefulWidget {
  final String textButton;
  final VoidCallback action;
  final bool error;
  const DialogCustom(
      {Key? key,
      required this.textButton,
      required this.action,
      this.error = true})
      : super(key: key);
  @override
  _DialogCustomState createState() => _DialogCustomState();
}

class _DialogCustomState extends State<DialogCustom> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
        child: Container(
          width: Get.width,
          margin:
              EdgeInsets.only(left: Get.width * 0.15, right: Get.width * 0.15),
          decoration: BoxDecoration(
            color: Theme.of(context).scaffoldBackgroundColor,
            borderRadius: BorderRadius.circular(12),
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ],
                ),
                Icon(
                  widget.error ? Icons.warning_amber : Icons.check,
                  color: widget.error ? Colors.red : Colors.green,
                  size: 90,
                ),
                const SizedBox(
                  height: 8,
                ),
                Text(
                  AppLocalizations.of(context)!.button_login,
                  style: Theme.of(context).textTheme.headline1,
                ),
                const SizedBox(
                  height: 8,
                ),
                Text(
                  AppLocalizations.of(context)!.message_login+fullControllerController.island.value,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headline4,
                ),
                SizedBox(height: Get.height * 0.01),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child:
                      SizedBox(
                          height: 40,
                          child: ButtonUI(label: widget.textButton, action: widget.action)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
