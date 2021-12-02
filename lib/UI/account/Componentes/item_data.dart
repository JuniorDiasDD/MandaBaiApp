import 'package:flutter/material.dart';
import 'package:get/get.dart';


class Item_Component extends StatefulWidget {
  const Item_Component({Key? key}) : super(key: key);

  @override
  _Item_ComponentState createState() => _Item_ComponentState();
}

class _Item_ComponentState extends State<Item_Component> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       body: SingleChildScrollView(
         child: Column(
           children: [
             Container (
               width: Get.width ,
               height: Get.height * 0.3,

               child: Row (
                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                 crossAxisAlignment: CrossAxisAlignment.start,
                 children: [
                   Column(
                     children: [


                     ],
                   )


                 ],
               ),
             ),
           ],
         ),
       ),

    );
  }
}
