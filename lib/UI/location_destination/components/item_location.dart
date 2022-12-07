import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:manda_bai/Controller/mandaBaiController.dart';
import 'package:manda_bai/Controller/request.dart';
import 'package:manda_bai/Model/location.dart';
import 'package:manda_bai/UI/location_destination/page/new_destination.dart';
import 'package:manda_bai/constants/controllers.dart';

class ItemLocation extends StatefulWidget {
  Location location;
  ItemLocation({Key? key, required this.location}) : super(key: key);
  @override
  _ItemLocationState createState() => _ItemLocationState();
}

class _ItemLocationState extends State<ItemLocation> {
  final MandaBaiController mandaBaiController = Get.find();
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        locationController.isRadioSelected.value =
            widget.location.id.toString();
        locationController.location.value=widget.location;
      },
      child: Padding(
        padding: EdgeInsets.all(
          Get.width * 0.03,
        ),
        child: Obx(
            ()=> Container(
            decoration: BoxDecoration(
              color: locationController.isRadioSelected.value==widget.location.id.toString()?Colors.orange:Theme.of(context).dialogBackgroundColor,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Theme.of(context).cardColor,
                  blurRadius: 1.0,
                  spreadRadius: 0.0,
                  offset: const Offset(0.5, 0.5),
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        widget.location.name!,
                        style: Theme.of(context).textTheme.headline2,
                      ),
                      SizedBox(
                          child: locationController.checkEditLocation.value
                              ? Row(
                                  children: [
                                    IconButton(
                                      padding: const EdgeInsets.all(0.0),
                                      onPressed: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    NewDestination(
                                                        location:
                                                            widget.location)));
                                      },
                                      icon: const Icon(
                                        Icons.edit,
                                      ),
                                    ),
                                    IconButton(
                                      padding: const EdgeInsets.all(0.0),
                                      onPressed: () {},
                                      icon: const Icon(
                                        Icons.delete,
                                      ),
                                    ),
                                  ],
                                )
                              : Container()),
                    ],
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Row(
                    children: [
                      const Icon(
                        Icons.location_on_outlined,
                      ),
                      Text(
                        widget.location.island! +
                            ' (' +
                            widget.location.city! +
                            ')',
                        style: Theme.of(context).textTheme.headline3,
                      ),
                    ],
                  ),

                  Padding(
                    padding: const EdgeInsets.only(left: 25.0),
                    child: Obx(
                      ()=> SizedBox(
                        child: locationController.checkEditLocation.value
                            ? Text(
                                widget.location.endereco!,
                                style: Theme.of(context).textTheme.headline4,
                              )
                            : Row(
                                children: [
                                  Text(
                                    widget.location.endereco!,
                                    style: Theme.of(context).textTheme.headline4,
                                  ),
                                  const Spacer(),
                                  Radio(
                                    value: widget.location.id.toString(),
                                    groupValue: locationController.isRadioSelected.value,
                                    onChanged: (value) {
                                        locationController.isRadioSelected.value =
                                            widget.location.id.toString();
                                        locationController.location.value=widget.location;
                                        },
                                    activeColor: Colors.green,
                                  ),
                                ],
                              ),
                      ),
                    ),
                  ),

                  Row(
                    children: [
                      const Icon(
                        Icons.phone,
                      ),
                      Text(
                        widget.location.phone!,
                        style: Theme.of(context).textTheme.headline4,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
