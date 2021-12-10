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
      padding: EdgeInsets.only(left:20.0,top:5.0,bottom: 5.0,right:20.0),
      child: Container(
        width: Get.width,
        height: Get.height * 0.1,
        child: Row(
          children: [
            Image.network(
                'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTHpEEl5WrJrxkJS_AXy4xTsa55jmb-zw3iy-W4KHGqZBhrQUSAilwZUHKbcDfgz_BLLDM&usqp=CAU',
                width: Get.width * 0.2,
                height: Get.height * 0.2,
                alignment: Alignment.center),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.items.name,
                    style: Theme.of(context).textTheme.headline2,
                  ),
                  SizedBox(height: Get.height * 0.01),
                   Text(
                    "Quant: "+widget.items.quantity.toString(),
                    style: Theme.of(context).textTheme.headline4,
                  ),
                  Text(
                    widget.items.total+"\$",
                    style: Theme.of(context).textTheme.headline5,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
