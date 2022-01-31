import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:manda_bai/Model/filter.dart';

class ItemFilter extends StatefulWidget {
  Filter filter;
   ItemFilter({Key? key,required this.filter}) : super(key: key);

  @override
  _ItemFilterState createState() => _ItemFilterState();
}

class _ItemFilterState extends State<ItemFilter> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: SizedBox(
        width: Get.width * 0.15,
       child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.network(
              widget.filter.image,
              width: Get.width * 0.1,
              height: Get.width * 0.1,
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              widget.filter.name,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headline4!.copyWith(fontSize: Get.width * 0.022),
            ),
          ],
        ),
      ),
    );
  }
}
