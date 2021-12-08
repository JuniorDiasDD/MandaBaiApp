import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:manda_bai/Controller/mandaBaiController.dart';
import 'package:manda_bai/Core/app_colors.dart';
import 'package:manda_bai/Core/app_fonts.dart';
import 'package:manda_bai/Core/app_images.dart';
import 'package:manda_bai/Model/location.dart';
import 'package:manda_bai/UI/home/pages/home_page.dart';
import 'package:manda_bai/UI/location_destination/components/item_location.dart';

class Destination_Page extends StatefulWidget {
  const Destination_Page({Key? key}) : super(key: key);

  @override
  _Destination_PageState createState() => _Destination_PageState();
}

class _Destination_PageState extends State<Destination_Page> {
  final MandaBaiController mandaBaiController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding:
            EdgeInsets.only(left: Get.width * 0.04, right: Get.width * 0.04),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: Get.height * 0.08),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    child: IconButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => HomePage(index: 3)));
                      },
                      icon: const Icon(
                        Icons.arrow_back,
                      ),
                      alignment: Alignment.centerRight,
                    ),
                  ),
                  Text(
                    'Locais de Entrega',
                    style: Theme.of(context).textTheme.headline1,
                  ),
                  IconButton(
                    padding: const EdgeInsets.all(0.0),
                    onPressed: () {
                      Navigator.pushNamed(context, '/newDestination');
                    },
                    icon: const Icon(
                      Icons.add,
                    ),
                    iconSize: Get.width * 0.05,
                    alignment: Alignment.centerRight,
                  ),
                ],
              ),
              Container(
                height: Get.height * 0.8,
                child: FutureBuilder(
                  future: mandaBaiController.loadLocation(),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    switch (snapshot.connectionState) {
                      case ConnectionState.waiting:
                        return Container(
                          height: Get.height * 0.2,
                          width: Get.width,
                          child: Center(
                            child: Image.asset(
                              AppImages.loading,
                              width: Get.width * 0.2,
                              height: Get.height * 0.2,
                              alignment: Alignment.center,
                            ),
                          ),
                        );
                      default:
                        /* if (!snapshot.hasData) {
                          return Container(
                            height: Get.height * 0.2,
                            width: Get.width,
                            child: Center(
                              child: Image.asset(
                                AppImages.loading,
                                width: Get.width * 0.2,
                                height: Get.height * 0.2,
                                alignment: Alignment.center,
                              ),
                            ),
                          );
                        } else {*/
                        if (snapshot.data == null) {
                          return Container(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Sem localizações...",
                                  style: Theme.of(context).textTheme.headline3,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Adiciona uma nova localização no ",
                                      style:
                                          Theme.of(context).textTheme.headline3,
                                    ),
                                    Icon(
                                      Icons.add,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          );
                        } else {
                          return Container(
                            height: Get.height * 0.85,
                            child: ListView.builder(
                              padding: EdgeInsets.only(
                                top: 0.0,
                                bottom: Get.height * 0.03,
                              ),
                              scrollDirection: Axis.vertical,
                              itemCount:
                                  mandaBaiController.list_location.length,
                              itemBuilder: (BuildContext context, index) {
                                var list =
                                    mandaBaiController.list_location[index];
                                return ItemLocation(location: list);
                              },
                            ),
                          );
                        }
                      // }
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
