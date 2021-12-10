import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:manda_bai/Controller/request.dart';
import 'package:manda_bai/Core/app_images.dart';
import 'package:manda_bai/Model/order.dart';
import 'package:manda_bai/UI/Pedido/Componentes/item_pedido.dart';

class PedidoPage extends StatefulWidget {
  @override
  _PedidoPageState createState() => _PedidoPageState();
}

class _PedidoPageState extends State<PedidoPage> {
  List<Order> list_order = [];
  Future _carregar() async {
    if (list_order.isEmpty) {
      list_order = await ServiceRequest.loadOrder();
      if (list_order.isEmpty) {
        return null;
      }
    }

    return list_order;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: Get.height * 0.08),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  child: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(
                      Icons.arrow_back,
                    ),
                    alignment: Alignment.centerRight,
                  ),
                ),
                Text(
                  'Meus Pedidos',
                  style: Theme.of(context).textTheme.headline1,
                ),
                Container(
                  width: Get.width * 0.1,
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.all(15.0),
              child: Row(
                //mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Icon(
                    Icons.circle,
                    color: Colors.orange,
                    size: 10,
                  ),
                  Text(
                    ' Encomenda em processo',
                    style: Theme.of(context).textTheme.headline4!.copyWith(fontSize: Get.width*0.03),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Icon(
                      Icons.circle,
                      color: Colors.green,
                      size: 10,
                    ),
                  ),
                  Text(
                    ' Encomenda entregue',
                    style: Theme.of(context).textTheme.headline4!.copyWith(fontSize: Get.width*0.03),
                  ),
                ],
              ),
            ),
            FutureBuilder(
              future: _carregar(),
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
                    if (snapshot.data == null) {
                      return Container(
                        height: Get.height * 0.5,
                        width: Get.width,
                        child: Center(
                          child: Text(
                            "Ainda não realizou nenhum pedido...",
                            style: Theme.of(context).textTheme.headline3,
                          ),
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
                          itemCount: list_order.length,
                          itemBuilder: (BuildContext context, index) {
                            var list = list_order[index];
                            return Item_Pedido(order:list);
                          },
                        ),
                      );
                    }
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
