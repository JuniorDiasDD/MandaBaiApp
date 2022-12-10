import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:manda_bai/UI/widget/base_page.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:manda_bai/UI/widget/button_ui.dart';
import 'package:manda_bai/constants/controllers.dart';

class SettingMoney extends StatefulWidget {
  const SettingMoney({Key? key}) : super(key: key);

  @override
  State<SettingMoney> createState() => _SettingMoneyState();
}

class _SettingMoneyState extends State<SettingMoney> {
  @override
  void initState() {
    super.initState();
    fullControllerController.isSelectedMoney =
        fullControllerController.initialMoney;
  }

  @override
  Widget build(BuildContext context) {
    return BasePage(
      title: AppLocalizations.of(context)!.text_select_currency,
      body: Obx(
        () => Padding(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox(
            height: Get.height * 0.85,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Euro",
                      style: Theme.of(context).textTheme.headline4,
                    ),
                    Radio(
                      value: "EUR",
                      groupValue:
                          fullControllerController.isSelectedMoney.value,
                      onChanged: (value) {
                        fullControllerController.isSelectedMoney.value = "EUR";
                      },
                      activeColor: Colors.green,
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Escudos",
                      style: Theme.of(context).textTheme.headline4,
                    ),
                    Radio(
                      value: "ECV",
                      groupValue:
                          fullControllerController.isSelectedMoney.value,
                      onChanged: (value) {
                        fullControllerController.isSelectedMoney.value = "ECV";
                      },
                      activeColor: Colors.green,
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Dólar",
                      style: Theme.of(context).textTheme.headline4,
                    ),
                    Radio(
                      value: "USD",
                      groupValue:
                          fullControllerController.isSelectedMoney.value,
                      onChanged: (value) {
                        fullControllerController.isSelectedMoney.value = "USD";
                      },
                      activeColor: Colors.green,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      footer: ButtonUI(
          label: AppLocalizations.of(context)!.button_save,
          action: () async {
            var result = await fullControllerController.updateMoney();
            if (result.success) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text(
                  AppLocalizations.of(context)!.message_success_update,
                  style: Theme.of(context).textTheme.labelSmall,
                ),
                backgroundColor: Colors.green,
              ));
            } else {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text(
                  AppLocalizations.of(context)!.message_update_failed,
                  style: Theme.of(context).textTheme.labelSmall,
                ),
                backgroundColor: Theme.of(context).errorColor,
              ));
            }
          }),
    );
  }
}
