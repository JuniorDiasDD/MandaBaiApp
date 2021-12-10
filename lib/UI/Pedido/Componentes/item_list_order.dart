import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get.dart';
import 'package:manda_bai/Model/order.dart';

class ItemListOrder extends StatefulWidget {
  Items items;
  ItemListOrder({Key? key, required this.items}) : super(key: key);

  @override
  _ItemListOrderState createState() => _ItemListOrderState();
}

class _ItemListOrderState extends State<ItemListOrder> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 20.0,right: 20.0),
      child: Container(
        width: Get.width,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    widget.items.name,
                    style: Theme.of(context).textTheme.headline2,
                  ),
                  const Spacer(),
                  Text(
                    widget.items.total + "\$",
                    style: Theme.of(context).textTheme.headline5,
                  ),
                ],
              ),
              SizedBox(height: 5.0),
              Text(
                "Quant: " + widget.items.quantity.toString(),
                style: Theme.of(context).textTheme.headline4,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
