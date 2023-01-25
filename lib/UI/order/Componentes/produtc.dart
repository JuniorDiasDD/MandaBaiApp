import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:manda_bai/Model/order.dart';
import 'package:manda_bai/UI/order/Componentes/item_list_order.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ProductList extends StatelessWidget {
  final List<Items> items;
  const ProductList({Key? key, required this.items}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
        child: Container(
          width: Get.width,
          height: Get.height*0.6,
          margin: const EdgeInsets.only(left: 20, right: 20),
          decoration: BoxDecoration(
            color: Theme.of(context).scaffoldBackgroundColor,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: Get.width * 0.08,
                  ),
                  Text(
                    AppLocalizations.of(context)!.product,
                    style: Theme.of(context).textTheme.headline1,
                  ),
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
              Expanded(
                child: ListView(
                  scrollDirection: Axis.vertical,
                  children: items
                      .map((e) => ItemListOrder(
                            item: e,
                          ))
                      .toList(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
