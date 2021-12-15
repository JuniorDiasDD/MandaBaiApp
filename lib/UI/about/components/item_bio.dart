import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:manda_bai/Core/app_images.dart';
import 'package:manda_bai/Model/employee.dart';
import 'package:manda_bai/data/madaBaiData.dart';
import 'package:readmore/readmore.dart';

class Item_Bio extends StatefulWidget {
  Employee employee;
  Item_Bio({Key? key, required this.employee}) : super(key: key);

  @override
  _Item_BioState createState() => _Item_BioState();
}

class _Item_BioState extends State<Item_Bio> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(10.0)),
          color: Theme.of(context).cardColor,
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.employee.cargo,
                    style: Theme.of(context).textTheme.headline5,
                  ),
                  SizedBox(height: Get.height * 0.002),
                  Text(
                    widget.employee.name,
                    style: Theme.of(context).textTheme.headline4,
                  ),
                  SizedBox(height: Get.height * 0.005),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(2.0),
                child: SizedBox(
                  height: Get.height * 0.15,
                  child: Row(
                    children: [
                      Flexible(
                        flex: 1,
                        child: Container(
                          width: Get.width,
                          height: Get.height,
                          decoration: BoxDecoration(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10.0)),
                            color: Colors.white,
                            image: DecorationImage(
                              fit: BoxFit.fill,
                              image: NetworkImage(widget.employee.image),
                            ),
                          ),
                        ),
                      ),
                      Flexible(
                        flex: 2,
                        child: SizedBox(
                          height: Get.height,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ListView(
                              padding: const EdgeInsets.all(0.0),
                              children: [
                                Text(
                                  widget.employee.description,
                                  textAlign: TextAlign.justify,
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline4!
                                      .copyWith(
                                        fontSize: Get.width * 0.03,
                                      ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                width: Get.width,
                height:Get.height*0.02,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Row(
                          children: [
                            Image.asset(
                              AppImages.viber_logo,
                              height: Get.height * 0.03,
                              width: Get.width * 0.03,
                            ),
                            const SizedBox(width: 1),
                            Image.asset(
                              AppImages.whatsapp_logo,
                              height: Get.height * 0.03,
                              width: Get.width * 0.03,
                            ),
                            const SizedBox(width: 2),
                            Text(
                              widget.employee.tel,
                              style: Theme.of(context).textTheme.headline4,
                            ),
                          ],
                        ),
                        const SizedBox(width: 5),
                        Row(
                          children: [
                            Image.asset(
                              AppImages.gmail_logo,
                              height: Get.height * 0.03,
                              width: Get.width * 0.03,
                            ),
                               const SizedBox(width: 2),
                            Text(
                              widget.employee.email,
                              style: Theme.of(context).textTheme.headline4,
                            ),
                          ],
                        ),
                      ],
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
