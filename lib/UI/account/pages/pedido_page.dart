import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PedidoPage extends StatefulWidget {
  const PedidoPage({Key? key}) : super(key: key);

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
        ]),
      ),
    );
  }
}
