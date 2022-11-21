import 'package:flutter/material.dart';

class ButtonOption extends StatelessWidget {
  final String textButton;
  final VoidCallback action;
  const ButtonOption({Key? key, required this.textButton, required this.action})
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
            Text(
              ">",
              style: Theme.of(context).textTheme.headline4,
            )
          ],
        ),
      ),
    );
  }
}
