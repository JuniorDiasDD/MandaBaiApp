import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:manda_bai/Model/location.dart';
import 'package:manda_bai/UI/location_destination/page/new_destination.dart';
import 'package:manda_bai/UI/widget/dialogs.dart';
import 'package:manda_bai/constants/controllers.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ItemLocation extends StatefulWidget {
  final Location location;
  final bool select;
  const ItemLocation({Key? key, required this.location,this.select=true}) : super(key: key);
  @override
  _ItemLocationState createState() => _ItemLocationState();
}

class _ItemLocationState extends State<ItemLocation> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        if(widget.select) {
          locationController.isRadioSelected.value =
              widget.location.id.toString();
          locationController.location.value = widget.location;
        }
      },
      child: Padding(
        padding: const EdgeInsets.all(
          8,
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
                          child: !widget.select
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
                                        Icons.edit_note_outlined,
                                        color: Colors.orange,
                                      ),
                                    ),
                                    IconButton(
                                      padding: const EdgeInsets.all(0.0),
                                      onPressed: () async{
                                        openLoadingStateDialog(context);
                                       var result=await locationController.deleteLocation(widget.location);
                                      Navigator.pop(context);
                                       if (result.success) {
                                         ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                           content: Text(
                                             AppLocalizations.of(context)!.message_success_update,
                                             style: Theme.of(context).textTheme.labelSmall,
                                           ),
                                           backgroundColor: Colors.green,
                                         ));
                                       } else {
                                         ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                           content: Text(
                                             AppLocalizations.of(context)!.message_update_failed,
                                             style: Theme.of(context).textTheme.labelSmall,
                                           ),
                                           backgroundColor: Theme.of(context).errorColor,
                                         ));
                                       }
                                      },
                                      icon: const Icon(
                                        Icons.delete,
                                        color: Colors.red,
                                      ),
                                    ),
                                  ],
                                )
                              : Container()),
                    ],
                  ),

                  Row(
                    children: [
                       Icon(
                        Icons.location_on_outlined,
                        size: 16,
                        color: Theme.of(context).dividerColor.withOpacity(0.5),
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
                    child:  SizedBox(
                        child: !widget.select
                            ? Text(
                          "-"+ widget.location.endereco!,
                                style: Theme.of(context).textTheme.headline4,
                              )
                            : Obx(
                              ()=> Row(
                                  children: [
                                    Text(
                                      "-"+widget.location.endereco!,
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
                       Icon(
                        Icons.phone,
                        size: 16,
                        color: Theme.of(context).dividerColor.withOpacity(0.5),
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
