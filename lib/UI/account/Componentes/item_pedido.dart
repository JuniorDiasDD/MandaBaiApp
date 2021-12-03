import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:manda_bai/Model/product.dart';

class Item_Pedido extends StatefulWidget {
  @override
  _Item_PedidoState createState() => _Item_PedidoState();
}

class _Item_PedidoState extends State<Item_Pedido> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: Get.width * 0.023,
        //top: Get.height * 0.014,
        //bottom: Get.height * 0.005,
      ),
      child: Container(
        margin: EdgeInsets.only(
          left: Get.width * 0.01,
          right: Get.width * 0.01,
          //top: Get.height * 0.02,
        ),
        decoration: BoxDecoration(
          color: Theme.of(context).dialogBackgroundColor,
          borderRadius: BorderRadius.circular(10),
            boxShadow:[
              BoxShadow(
                color:Theme.of(context).cardColor,
                blurRadius: 1.0,
                spreadRadius: 0.0,
                offset: Offset(0.5, 0.5),
              ),
            ],
                 ),
        child: ExpansionTile(
          backgroundColor: Theme.of(context).cardColor,

          title: Text(
            "Pedido nº1",
            style: Theme.of(context).textTheme.headline1,
          ),
          trailing: Icon(
            Icons.circle,
            color: Colors.green,
            size: 10,
          ),
          children: <Widget>[
            Divider(
              color: Theme.of(context).cardColor,
              height: 5,
            ),

            Padding(
              padding: EdgeInsets.only(
                  left: Get.width * 0.02, right: Get.width * 0.02),

              child: Container(
                width: Get.width,
                height: Get.height * 0.1,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Image.network(
                        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTHpEEl5WrJrxkJS_AXy4xTsa55jmb-zw3iy-W4KHGqZBhrQUSAilwZUHKbcDfgz_BLLDM&usqp=CAU',
                        width: Get.width * 0.2,
                        height: Get.height * 0.2,
                        alignment: Alignment.center),
                    Padding(
                      padding: EdgeInsets.only(
                        right: Get.width * 0.23,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Nome do Produto',
                            style: Theme.of(context).textTheme.headline2,
                          ),
                          SizedBox(height: Get.height * 0.01),
                          Text(
                            '100',
                            style: Theme.of(context).textTheme.headline4,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
