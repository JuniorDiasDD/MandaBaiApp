import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:manda_bai/UI/home/pop_up/carrega_saldo.dart';
import 'package:manda_bai/UI/home/pop_up/pop_up_message.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
class ItemNew extends StatefulWidget {
  String image, title;
  ItemNew({Key? key, required this.image, required this.title})
      : super(key: key);
  @override
  _ItemNewState createState() => _ItemNewState();
}

class _ItemNewState extends State<ItemNew> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (widget.title == "Saldo CvMovel") {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return Carrega_Saldo();
              });
        } else if (widget.title == "Serviços da Câmara") {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return Pop_up_Message(
                    mensagem:
                        AppLocalizations.of(context)!.text_unavailable_service,
                    icon: Icons.device_unknown_sharp,
                    caminho: "erro");
              });
        }
      },
      child: Padding(
        padding: EdgeInsets.only(
          left: Get.width * 0.023,
          top: Get.height * 0.014,
          bottom: Get.height * 0.005,
        ),
        child: Container(
          width: Get.width * 0.3,
          height: Get.height * 0.15,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Theme.of(context).cardColor,
                blurRadius: 1.0,
                spreadRadius: 0.0,
                offset: Offset(0.5, 0.5),
              ),
            ],
            color: Theme.of(context).dialogBackgroundColor,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.network(
                widget.image,
                width: Get.width * 0.15,
                height: Get.width * 0.15,
              ),
              SizedBox(
                height: Get.height * 0.01,
              ),
              Text(
                widget.title,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.subtitle1,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
