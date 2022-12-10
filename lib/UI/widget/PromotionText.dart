import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:manda_bai/Model/discount.dart';
import 'package:manda_bai/constants/controllers.dart';

class PromotionText extends StatelessWidget {
final Discount discount;
  const PromotionText({required this.discount, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            discount.title!,
            style: Theme.of(context).textTheme.headline1,
          ),
          Text(
            discount.description!+fullControllerController.symbolMoney.value,
            style: Theme.of(context).textTheme.headline4,
          ),
        ],
      ),
    );
  }
}
