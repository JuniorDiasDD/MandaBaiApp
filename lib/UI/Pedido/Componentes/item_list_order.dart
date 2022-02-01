import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:manda_bai/Model/order.dart';
import 'package:manda_bai/UI/Pedido/pages/pedido_description_product.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
      padding: const EdgeInsets.only(left: 20.0, right: 20.0,top:10),
      child: OpenContainer(closedBuilder: (context, action) {
        return Container(
          width: Get.width,
          color:Theme.of(context).backgroundColor,
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
                const SizedBox(height: 5.0),
                Text(
                  AppLocalizations.of(context)!.text_amount +": "+
                      widget.items.quantity.toString(),
                  style: Theme.of(context).textTheme.headline4,
                ),
              ],
            ),
          ),
        );
      },
          closedElevation: 5.0,
          closedShape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10)
          ),
        //  openColor: Theme.of(context).primaryColor,

          openBuilder: (context, action){
            return PedidoDescriptionProduct(idProduct: widget.items.product_id);
          }),
    );
  }
}
