import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:manda_bai/Controller/request.dart';
import 'package:manda_bai/Core/app_images.dart';
import 'package:manda_bai/Model/location.dart';
import 'package:manda_bai/UI/cart/pages/checkout_page_step_2.dart';
import 'package:manda_bai/UI/location_destination/components/item_location.dart';
import 'package:manda_bai/UI/location_destination/page/new_destination.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Destination_Page extends StatefulWidget {
  String route;
  Destination_Page({Key? key, required this.route}) : super(key: key);

  @override
  _Destination_PageState createState() => _Destination_PageState();
}

class _Destination_PageState extends State<Destination_Page> {
  List<Location> list_location = [];

  Future _carregarLocation() async {
    if (list_location.isEmpty) {
      list_location = await ServiceRequest.loadLocation();
      if (list_location.isEmpty) {
        return null;
      }
    }
    return list_location;
  }
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
                  IconButton(
                    onPressed: () {
                      if (widget.route == "checkout") {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                CheckoutPageStep2(location: null),
                          ),
                        );
                      } else {
                        Navigator.pop(context);
                      }
                    },
                    icon: const Icon(
                      Icons.arrow_back,
                    ),
                    alignment: Alignment.centerRight,
                  ),
                  Text(
                    AppLocalizations.of(context)!.text_delivery_location,
                    style: Theme.of(context).textTheme.headline1,
                  ),
                  IconButton(
                    padding: const EdgeInsets.all(0.0),
                    onPressed: () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  NewDestination(route: widget.route,location:null)));
                    },
                    icon: const Icon(
                      Icons.add,
                    ),
                    iconSize: Get.width * 0.05,
                    alignment: Alignment.centerRight,
                  ),
                ],
              ),
              SizedBox(
                height: Get.height * 0.8,
                child: FutureBuilder(
                  future: _carregarLocation(),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    switch (snapshot.connectionState) {
                      case ConnectionState.waiting:
                        return SizedBox(
                          height: Get.height * 0.2,
                          width: Get.width,
                          child: Center(
                            child: Image.network(
                              AppImages.loading,
                              width: Get.width * 0.2,
                              height: Get.height * 0.2,
                              alignment: Alignment.center,
                            ),
                          ),
                        );
                      default:

                        if (snapshot.data == null) {
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                AppLocalizations.of(context)!.text_no_locations,
                                style: Theme.of(context).textTheme.headline3,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    AppLocalizations.of(context)!.text_add_new_location,
                                    style:
                                        Theme.of(context).textTheme.headline3,
                                  ),
                                  const Icon(
                                    Icons.add,
                                  ),
                                ],
                              ),
                            ],
                          );
                        } else {
                          return SizedBox(
                            height: Get.height * 0.85,
                            child: ListView.builder(
                              padding: EdgeInsets.only(
                                top: 0.0,
                                bottom: Get.height * 0.03,
                              ),
                              scrollDirection: Axis.vertical,
                              itemCount: list_location.length,
                              itemBuilder: (BuildContext context, index) {
                                var list = list_location[index];
                                return ItemLocation(
                                    location: list, route: widget.route);
                              },
                            ),
                          );
                        }
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
