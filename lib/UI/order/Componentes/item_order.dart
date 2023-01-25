import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:manda_bai/Core/app_colors.dart';
import 'package:manda_bai/Core/app_images.dart';
import 'package:manda_bai/Model/order.dart';
import 'package:manda_bai/UI/order/pages/detail_order.dart';
import 'package:manda_bai/constants/controllers.dart';

class ItemOrder extends StatefulWidget {
  final Order order;
  const ItemOrder({Key? key, required this.order}) : super(key: key);
  @override
  _ItemPedidoState createState() => _ItemPedidoState();
}

class _ItemPedidoState extends State<ItemOrder> {
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
                builder: (context) => DetailOrder(order: widget.order)));
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
                          ? AppImages.orderPendent
                          : AppImages.orderFinish,
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
                          .copyWith(fontSize: 6),
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
                      orderController.getStringStatusOrder(
                          widget.order.status, context),
                      style: Theme.of(context).textTheme.labelSmall!.copyWith(
                          color: widget.order.status == "completed"
                              ? AppColors.greenColor
                              : widget.order.status == "processing"
                                  ? Colors.orange
                                  : widget.order.status == "failed"
                                      ? Colors.red
                                      : Theme.of(context).dividerColor),
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
