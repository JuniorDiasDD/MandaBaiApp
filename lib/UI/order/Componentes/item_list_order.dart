import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:manda_bai/Model/order.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:manda_bai/UI/order/pages/order_description_product.dart';

class ItemListOrder extends StatefulWidget {
  final Items item;
  const ItemListOrder({Key? key, required this.item}) : super(key: key);

  @override
  _ItemListOrderState createState() => _ItemListOrderState();
}

class _ItemListOrderState extends State<ItemListOrder> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
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
                      widget.item.name,
                      style: Theme.of(context).textTheme.headline2,
                    ),
                    const Spacer(),
                    Text(
                      widget.item.total + "\$",
                      style: Theme.of(context).textTheme.headline5,
                    ),
                  ],
                ),
                const SizedBox(height: 5.0),
                Text(
                  AppLocalizations.of(context)!.text_amount +": "+
                      widget.item.quantity.toString(),
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
            return PedidoDescriptionProduct(idProduct: widget.item.product_id);
          }),
    );
  }
}
