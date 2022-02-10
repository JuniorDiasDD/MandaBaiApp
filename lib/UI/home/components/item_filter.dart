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
    return Container(
      width: Get.width * 0.23,
     child: Column(
        children: [
          Container(
            width: Get.width * 0.15,
            height: Get.width * 0.15,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all( Radius.circular(50.0)),
              color: Theme.of(context).scaffoldBackgroundColor,
              image: DecorationImage(
                fit: BoxFit.fill,
                image: NetworkImage(widget.filter.image),
              ),
            ),
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
    );
  }
}
