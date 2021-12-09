import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:manda_bai/Controller/request.dart';
import 'package:manda_bai/Model/location.dart';

class ItemLocation extends StatefulWidget {
  Location location;
  String route;
  ItemLocation({Key? key, required this.location, required this.route})
      : super(key: key);
  @override
  _ItemLocationState createState() => _ItemLocationState();
}

class _ItemLocationState extends State<ItemLocation> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(
        Get.width * 0.03,
      ),
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).dialogBackgroundColor,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Theme.of(context).cardColor,
              blurRadius: 1.0,
              spreadRadius: 0.0,
              offset: Offset(0.5, 0.5),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.only(
            left: 10.0,
            right: 8.0,
            bottom: 10.0,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget.location.name,
                    style: Theme.of(context).textTheme.headline2,
                  ),
                  
                  SizedBox(
                    child: widget.route == "checkout"
                        ? null
                        : IconButton(
                            padding: const EdgeInsets.all(0.0),
                            onPressed: () {
                              setState(() {
                                ServiceRequest.removeLocation(
                                    widget.location.id);
                                Navigator.pushReplacementNamed(
                                    context, '/Destination');
                              });
                            },
                            icon: const Icon(
                              Icons.delete,
                            ),
                          ),
                  ),
                ],
              ),
              SizedBox(
                height: Get.height * 0.01,
              ),
              Row(
                children: [
                  Icon(
                    Icons.location_on_outlined,
                  ),
                  Text(
                    widget.location.island,
                    style: Theme.of(context).textTheme.headline3,
                  ),
                ],
              ),
              SizedBox(
                height: Get.height * 0.01,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15.0),
                child: Text(
                  widget.location.city + ',' + widget.location.endereco,
                  style: Theme.of(context).textTheme.headline4,
                ),
              ),
              SizedBox(
                height: Get.height * 0.01,
              ),
              Row(
                children: [
                  Icon(
                    Icons.phone,
                  ),
                  Text(
                    widget.location.phone,
                    style: Theme.of(context).textTheme.headline4,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
