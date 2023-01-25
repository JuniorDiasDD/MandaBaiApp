import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:manda_bai/Model/employee.dart';

class ItemMandatario extends StatefulWidget {
 Employee employee;
  ItemMandatario({Key? key, required this.employee}) : super(key: key);

  @override
  _ItemMandatarioState createState() => _ItemMandatarioState();
}

class _ItemMandatarioState extends State<ItemMandatario> {
  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.all(5.0),
      child: Container(
        decoration:  BoxDecoration(
          borderRadius:const BorderRadius.all(Radius.circular(10.0)),
          color: Theme.of(context).cardColor,
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
               widget.employee.name,
               style: Theme.of(context).textTheme.headline4,
                  ),
                  SizedBox(height: Get.height * 0.002),
                  Text(
               widget.employee.cargo,
               style: Theme.of(context).textTheme.headline6,
                  ),

                  SizedBox(height: Get.height * 0.005),
              Padding(
                padding: const EdgeInsets.all(2.0),
                child: Row(
                  children: [
                    Flexible(
                      flex:1,
                      child: Container(
                        width: 96,
                         height: 96,
                        decoration:  BoxDecoration(
                          borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                          color: Colors.white,
                          image: DecorationImage(
                            fit: BoxFit.fill,
                            image: NetworkImage(widget.employee.image),
                          ),
                        ),
                      ),
                    ),
                    Flexible(
                      flex:2,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          widget.employee.description+"\n\n"+widget.employee.tel+"\n"+widget.employee.email,

                          style: Theme.of(context).textTheme.headline4!.copyWith(fontSize: 13,),
                        ),
                      ),
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