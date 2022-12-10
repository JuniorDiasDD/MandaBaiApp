import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:manda_bai/Core/app_colors.dart';
import 'package:manda_bai/Core/app_images.dart';
import 'package:manda_bai/Model/order.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:manda_bai/UI/order/pages/detail_order.dart';
import 'package:manda_bai/constants/controllers.dart';

class ItemOrder extends StatefulWidget {
  final Order order;
  const ItemOrder({Key? key, required this.order}) : super(key: key);
  @override
  _Item_PedidoState createState() => _Item_PedidoState();
}

class _Item_PedidoState extends State<ItemOrder> {
  @override
  void initState() {
    super.initState();
    orderController.data(widget.order.date_created);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    DetailOrder(
                        order: widget.order)));
      },
      child: Padding(
        padding: const EdgeInsets.only(top: 10.0),
        child: Container(
          margin: const EdgeInsets.only(
            left: 8.0,
            right: 8.0,
          ),
          decoration: BoxDecoration(
            color: Theme.of(context).dialogBackgroundColor,
            boxShadow: [
              BoxShadow(
                color: Theme.of(context).cardColor,
                blurRadius: 1.0,
                spreadRadius: 0.0,
                offset: const Offset(0.5, 0.5),
              ),
            ],
          ),
          child: Row(
            children: [
              Column(
                children: [
                  Container(
                    height: 15,
                    width: 2,
                    color: Colors.green,
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  Image.network(
                      widget.order.status != 'processing'
                          ? AppImages.order_pendent
                          : AppImages.order_finish,
                      width: 24,
                      height: 24,
                      alignment: Alignment.center),
                  const SizedBox(
                    height: 4,
                  ),
                  Container(
                    height: 15,
                    width: 2,
                    color: Colors.green,
                  ),
                ],
              ),
              const SizedBox(
                width: 4.0,
              ),
              SizedBox(
                width: Get.width * 0.14,
                child: Column(
                  children: [
                    Text(
                      orderController.dataOrder.value,
                      style: Theme.of(context)
                          .textTheme
                          .labelSmall!
                          .copyWith(fontSize: 8),
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    Text(
                      orderController.horaOrder.value,
                      style: Theme.of(context)
                          .textTheme
                          .labelSmall!
                          .copyWith(fontSize: 8),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                width: 4.0,
              ),
              Container(
                width: 1,
                height: 64,
                color: Theme.of(context).dividerColor.withOpacity(0.4),
              ),
              const SizedBox(
                width: 8.0,
              ),
              Column(
                children: [
                  Row(
                    children: [
                      Text(
                        "Encomenda ",
                        style: Theme.of(context).textTheme.headline3!.copyWith(
                              fontSize: Get.width * 0.03,
                            ),
                      ),
                      Text(
                        "#" + widget.order.id.toString(),
                        style: Theme.of(context).textTheme.headline2,
                      ),
                    ],
                  ),
                ],
              ),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: Row(
                  children: [
                    Text(
                      widget.order.status != "complete"
                          ? widget.order.status == "cancelled"
                              ? AppLocalizations.of(context)!.text_canceled_order
                              : AppLocalizations.of(context)!.text_in_process_order
                          : AppLocalizations.of(context)!.text_delivery_order,
                      style: Theme.of(context).textTheme.labelSmall!.copyWith(color:
                      widget.order.status != "complete"
                          ? widget.order.status == "cancelled"
                          ? Colors.black26
                          : Colors.orange
                          : AppColors.greenColor,
                      ),
                    ),
                    Text(
                    " >",
                      style: Theme.of(context).textTheme.labelSmall,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
