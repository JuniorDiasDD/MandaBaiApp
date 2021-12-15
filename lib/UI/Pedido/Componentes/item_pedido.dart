import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:manda_bai/Model/order.dart';
import 'package:manda_bai/Model/product.dart';
import 'package:manda_bai/UI/Pedido/Componentes/item_list_order.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Item_Pedido extends StatefulWidget {
  Order order;
  Item_Pedido({Key? key, required this.order}) : super(key: key);
  @override
  _Item_PedidoState createState() => _Item_PedidoState();
}

class _Item_PedidoState extends State<Item_Pedido> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10.0),
      child: Container(
        margin: EdgeInsets.only(
          left: Get.width * 0.01,
          right: Get.width * 0.01,
        ),
        decoration: BoxDecoration(
          color: Theme.of(context).dialogBackgroundColor,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Theme.of(context).cardColor,
              blurRadius: 1.0,
              spreadRadius: 0.0,
              offset: Offset(0.5, 0.5),
            ),
          ],
        ),
        child: ExpansionTile(
          backgroundColor: Theme.of(context).cardColor,
          title: Row(
            children: [
              Image.asset('assets/images/' + widget.order.status + '.png',
                  width: 30,
                  height: 30,
                  alignment: Alignment.center),
                  
              Padding(
                padding: const EdgeInsets.only(left:8.0),
                child: Text(
                  AppLocalizations.of(context)! .text_order_number+" nº " + widget.order.id.toString(),
                  style: Theme.of(context).textTheme.headline1,
                ),
              ),
            ],
          ),
          trailing: Icon(
            Icons.circle,
            color: widget.order.status == "processing"
                ? Colors.amber
                : Colors.green,
            size: 10,
          ),
          children: <Widget>[
            Divider(
              color: Theme.of(context).cardColor,
              height: 5,
            ),
            SizedBox(
              height: Get.height * 0.3,
              child: ListView.builder(
                padding: EdgeInsets.only(
                  top: 0.0,
                  bottom: Get.height * 0.03,
                ),
                scrollDirection: Axis.vertical,
                itemCount: widget.order.items.length,
                itemBuilder: (BuildContext context, index) {
                  var list = widget.order.items[index];
                  return ItemListOrder(items: list);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
