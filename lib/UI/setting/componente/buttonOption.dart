import 'package:flutter/material.dart';
import 'package:manda_bai/constants/controllers.dart';
import 'package:switcher_button/switcher_button.dart';

class ButtonOption extends StatelessWidget {
  final String textButton;
  final VoidCallback action;
  final bool theme;
  const ButtonOption(
      {Key? key,
      required this.textButton,
      required this.action,
      this.theme = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: action,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              textButton,
              style: Theme.of(context).textTheme.headline4,
            ),
            SizedBox(
              child: theme
                  ? SwitcherButton(
                      value: fullControllerController.prefersDarkMode.value,
                      offColor: Theme.of(context).scaffoldBackgroundColor,
                      onColor: Theme.of(context).primaryColor,
                      onChange: (newValue) async {
                       await fullControllerController.setPrefersDark(newValue);
                      },
                      size: 56,
                    )
                  : Text(
                      ">",
                      style: Theme.of(context).textTheme.headline4,
                    ),
            )
          ],
        ),
      ),
    );
  }
}
