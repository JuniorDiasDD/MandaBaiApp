
import 'package:flutter/material.dart';


class HeaderTitle extends StatelessWidget {
  final String title;
  final String buttonText;
  final VoidCallback? action;
  const HeaderTitle(
      {required this.title, required this.buttonText, this.action, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left:16.0,right: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.headline1,
          ),

          TextButton(
            child: Text(
              buttonText,
              style: Theme.of(context).textTheme.headline4!.copyWith(decoration: TextDecoration.underline,),
            ),
            onPressed: action,
          ),
        ],
      ),
    );
  }
}
