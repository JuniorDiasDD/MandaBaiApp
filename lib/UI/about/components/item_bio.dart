import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:manda_bai/Core/app_images.dart';
import 'package:manda_bai/Model/employee.dart';

class ItemBio extends StatefulWidget {
  final Employee employee;
  const ItemBio({Key? key, required this.employee}) : super(key: key);

  @override
  _ItemBioState createState() => _ItemBioState();
}

class _ItemBioState extends State<ItemBio> {
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

              Padding(
                padding: const EdgeInsets.all(2.0),
                child: SizedBox(
                  height: Get.height * 0.15,
                  child: Row(
                    children: [
                      Flexible(
                        flex: 1,
                        child: Container(
                          width: 96,
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
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
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
                              Row(
                                children: [
                                  Image.asset(
                                    AppImages.viberLogo,
                                    height: 14,
                                    width: 14,
                                  ),
                                  const SizedBox(width: 1),
                                  Image.asset(
                                    AppImages.whatsappLogo,
                                    height: 14,
                                    width: 14,
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
                                    AppImages.appLogoGmail,
                                    height: 14,
                                    width: 14,
                                  ),
                                  const SizedBox(width: 2),
                                  Expanded(
                                    child: Text(
                                      widget.employee.email,
                                      style: Theme.of(context).textTheme.headline4!.copyWith(fontSize: 12),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16,),
              Text(
                widget.employee.description,
                textAlign: TextAlign.start,
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
    );
  }
}
