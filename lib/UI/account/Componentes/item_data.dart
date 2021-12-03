import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Item_Data extends StatefulWidget {
  const Item_Data({Key? key}) : super(key: key);

  @override
  _Item_DataState createState() => _Item_DataState();
}

class _Item_DataState extends State<Item_Data> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(
              left: Get.width * 0.03,
              right: Get.width * 0.03,

            ),
            child: Column(
              children: [
                Text(
                  'Nome',
                  style: Theme.of(context).textTheme.headline2,
                ),
                SizedBox(
                  height: Get.height * 0.01,
                ),
                Text(
                  'Cidade',
                  style: Theme.of(context).textTheme.headline2,
                ),
                SizedBox(
                  height: Get.height * 0.01,
                ),
                Text(
                  'Telefone/Telemóvel',
                  style: Theme.of(context).textTheme.headline2,
                ),
                SizedBox(
                  height: Get.height * 0.01,
                ),
                Text(
                  'Ilha',
                  style: Theme.of(context).textTheme.headline2,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
