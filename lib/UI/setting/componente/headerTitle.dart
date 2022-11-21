import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HeaderTitle extends StatelessWidget {
  final String title;
  final String description;
  const HeaderTitle({Key? key, required this.title, required this.description})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.headline1!.copyWith(
                fontSize: Get.width * 0.035,
              ),
        ),
        Text(
          description,
          style: Theme.of(context).textTheme.headline4!.copyWith(
            fontSize: Get.width * 0.03,
          ),
        ),
      ],
    );
  }
}
