import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:manda_bai/Model/filter.dart';
import 'package:manda_bai/UI/category_filter/pages/category_page.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ItemFilter extends StatefulWidget {
  Filter filter;
  ItemFilter({Key? key, required this.filter}) : super(key: key);

  @override
  _ItemFilterState createState() => _ItemFilterState();
}

class _ItemFilterState extends State<ItemFilter> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10.0),
      child: OpenContainer(
          closedBuilder: (context, action) {
            return Column(
              children: [
                Container(
                  width: Get.width * 0.15,
                  height: Get.width * 0.15,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(50.0)),
                    color: Theme.of(context).scaffoldBackgroundColor,
                    image: DecorationImage(
                      fit: BoxFit.fill,
                      image: NetworkImage(widget.filter.image),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  widget.filter.name,
                  textAlign: TextAlign.center,
                  style: Theme.of(context)
                      .textTheme
                      .headline4!
                      .copyWith(fontSize: Get.width * 0.022),
                ),
              ],
            );
          },
          closedElevation: 0.0,
      closedColor: Colors.transparent,
          openBuilder: (context, action) {
            return CategoryPage(
                category: widget.filter.category,
                filter_most: AppLocalizations.of(context)!.filter_more_price,
                filter_less: AppLocalizations.of(context)!.filter_less_price);
          }),
    );
  }
}
