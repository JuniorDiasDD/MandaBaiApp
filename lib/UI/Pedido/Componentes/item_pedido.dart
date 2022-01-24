import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:manda_bai/Controller/request.dart';
import 'package:manda_bai/Core/app_colors.dart';
import 'package:manda_bai/Core/app_images.dart';
import 'package:manda_bai/Model/order.dart';
import 'package:manda_bai/UI/Pedido/Componentes/item_list_order.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:manda_bai/UI/Pedido/controller/pedidoController.dart';
import 'package:manda_bai/UI/home/pop_up/pop_up_message.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Item_Pedido extends StatefulWidget {
  Order order;
  Item_Pedido({Key? key, required this.order}) : super(key: key);
  @override
  _Item_PedidoState createState() => _Item_PedidoState();
}

class _Item_PedidoState extends State<Item_Pedido> {
  final PedidoController controller = Get.find();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: Container(
        margin: EdgeInsets.only(
          left: Get.width * 0.01,
          right: Get.width * 0.01,
        ),
        decoration: BoxDecoration(
          color: Theme.of(context).dialogBackgroundColor,
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
        child: ExpansionTile(
          backgroundColor: Theme.of(context).cardColor,
          title: Row(
            children: [
              Image.network(
                  widget.order.status == 'processing'
                      ? AppImages.order_pendent
                      : AppImages.order_finish,
                  width: 30,
                  height: 30,
                  alignment: Alignment.center),
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Text(
                  AppLocalizations.of(context)!.text_order_number +
                      " nº " +
                      widget.order.id.toString(),
                  style: Theme.of(context).textTheme.headline1,
                ),
              ),
            ],
          ),
          trailing: Icon(
            Icons.circle,
            color: widget.order.status == "processing"
                ? Colors.amber
                : Colors.green,
            size: 10,
          ),
          children: <Widget>[
            Divider(
              color: Theme.of(context).cardColor,
              height: 5,
            ),
            SizedBox(
              height: Get.height * 0.2,
              child: ListView.builder(
                padding: EdgeInsets.only(
                  top: 0.0,
                  bottom: Get.height * 0.03,
                ),
                scrollDirection: Axis.vertical,
                itemCount: widget.order.items.length,
                itemBuilder: (BuildContext context, index) {
                  var list = widget.order.items[index];
                  return ItemListOrder(items: list);
                },
              ),
            ),
            Divider(
              color: Theme.of(context).cardColor,
              height: 5,
            ),
            Align(
              alignment: Alignment.topRight,
              child: TextButton(
                  onPressed: () async {
                    final SharedPreferences prefs = await SharedPreferences.getInstance();
                    final String? island = prefs.getString('island');
                    if(island==controller.island){
                      setState(() {
                        controller.loading=true;
                      });
                      bool check = false;
                      for (int i = 0; i < widget.order.items.length; i++) {
                        check = await ServiceRequest.addCart(
                            widget.order.items[i].product_id, widget.order.items[i].quantity);
                      }
                      setState(() {
                        controller.loading=false;
                      });
                      if (check) {

                        return showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return Pop_up_Message(
                                  mensagem: AppLocalizations.of(context)!.message_success_cart,
                                  icon: Icons.check,
                                  caminho: "pedido");
                            });
                      } else {
                        return showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return Pop_up_Message(
                                  mensagem: AppLocalizations.of(context)!.message_error_cart,
                                  icon: Icons.error,
                                  caminho: "pedido");
                            });
                      }
                    }else{
                      return showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return Pop_up_Message(
                                mensagem: AppLocalizations.of(context)!.message_update_island,
                                icon: Icons.error,
                                caminho: "pedido");
                          });
                    }

                  },
                  child: Container(
                    width: Get.width*0.4,
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: const BorderRadius.all(
                        Radius.circular(15),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Theme.of(context).cardColor,
                          blurRadius: 2.0,
                          spreadRadius: 0.0,
                          offset: Offset(2.0, 2.0),
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            AppLocalizations.of(context)!.button_add_cart,
                            style: Theme.of(context).textTheme.headline3!.copyWith(color:Colors.white,fontSize: Get.width*0.025),
                          ),
                          const Icon(Icons.shopping_cart_outlined,color:Colors.white,size: 15,),
                        ],
                      ),
                    ),
                  )),
            )
          ],
        ),
      ),
    );
  }
}
