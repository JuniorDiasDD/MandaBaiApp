import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:manda_bai/UI/account/Componentes/item_pedido.dart';

class PedidoPage extends StatefulWidget {



  @override
  _PedidoPageState createState() => _PedidoPageState();
}

class _PedidoPageState extends State<PedidoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(children: [
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
            padding:EdgeInsets.only(top:Get.height* 0.1),
            child: Row (
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: [
                    Icon(
                      Icons.circle,
                      color: Colors.red,
                      size: 10,
                    ),
                    Text('Efectuado',
                      style: Theme.of(context).textTheme.headline4,

                        )
                  ],
                ),
                Column(
                  children: [
                    Icon(
                      Icons.circle,
                      color: Colors.blue,
                      size: 10,
                    ),
                    Text('Em processo',
                      style: Theme.of(context).textTheme.headline4, ),
                  ],
                ),
                Column(
                  children: [
                    Icon(
                      Icons.circle,
                      color: Colors.green,
                      size: 10,
                    ),
                    Text('Recebido',
                      style: Theme.of(context).textTheme.headline4,),
                  ],
                ),

              ],

            ),
          ),

          Container(
            //margin: EdgeInsets.only(top:Get.height * 0.02),
            height: Get.height * 0.6,
            child: ListView(
              children: [
                Item_Pedido(),
              ],

            ),
          ),
        ],
        ),
      ),
    );
  }
}
