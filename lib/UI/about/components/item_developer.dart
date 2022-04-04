import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ItemDeveloper extends StatelessWidget {
  String image,name,cargo;
   ItemDeveloper({Key? key,required this.image,required this.name,required this.cargo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(
                Radius.circular(80.0),
              ),
              color: Colors.white,
              image: DecorationImage(
                fit: BoxFit.fill,
                image: NetworkImage(image),
              ),
            ),
          ),
         const SizedBox(
            width: 15,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
               Text(
                cargo,
                style: Theme.of(context).textTheme.headline4!.copyWith(fontSize: Get.width*0.025),
                textAlign: TextAlign.center,
              ),
              Text(
                name,
                style: Theme.of(context).textTheme.headline2,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
