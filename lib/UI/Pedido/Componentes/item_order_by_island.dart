import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:manda_bai/Model/islandOrder.dart';

import 'item_pedido.dart';

class ItemOrderByIsland extends StatefulWidget {
  IslandOrder islandOrder;
   ItemOrderByIsland({Key? key,required this.islandOrder}) : super(key: key);

  @override
  _ItemOrderByIslandState createState() => _ItemOrderByIslandState();
}

class _ItemOrderByIslandState extends State<ItemOrderByIsland> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        height: Get.height*0.3,
        child: Column(
          children: [
            Align(
                alignment:Alignment.topLeft,
                child: Text(widget.islandOrder.island,style: Theme.of(context).textTheme.headline2,)),

            SizedBox(
             height: Get.height * 0.25,
              child: ListView.builder(
                padding: EdgeInsets.only(
                  top: 0.0,
                  bottom: Get.height * 0.03,
                ),
                scrollDirection: Axis.vertical,
                itemCount: widget.islandOrder.listOrder.length,
                itemBuilder: (BuildContext context, index) {
                  var list = widget.islandOrder.listOrder[index];
                  return Item_Pedido(order: list);
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
