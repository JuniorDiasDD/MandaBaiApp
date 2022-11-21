import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:manda_bai/constants/controllers.dart';

class PromotionText extends StatelessWidget {
  final String title;
  final String description;
  const PromotionText({required this.title,required this.description, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.headline1,
        ),
        Text(
          description+fullControllerController.symbolMoney.value,
          style: Theme.of(context).textTheme.headline4,
        ),
      ],
    );
  }
}
