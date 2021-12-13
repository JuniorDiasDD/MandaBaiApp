import 'package:flutter/material.dart';
import 'package:flutter_session/flutter_session.dart';
import 'package:get/get.dart';
import 'package:manda_bai/Controller/request.dart';
import 'package:manda_bai/Core/app_colors.dart';
import 'package:manda_bai/Core/app_fonts.dart';
import 'package:manda_bai/Core/app_images.dart';

class PedidoDescriptionProduct extends StatefulWidget {
  int idProduct;
  PedidoDescriptionProduct({Key? key, required this.idProduct})
      : super(key: key);

  @override
  _PedidoDescriptionProductState createState() =>
      _PedidoDescriptionProductState();
}

class _PedidoDescriptionProductState extends State<PedidoDescriptionProduct> {
  var product;
  Future carregar() async {
    product = await ServiceRequest.loadProductbyId(widget.idProduct);
    if (product == false) {
      return null;
    }
    return product;
  }

  var money_txt;
  Future _carregarMoney() async {
    money_txt = await FlutterSession().get('money');

    return money_txt;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: FutureBuilder(
            future: carregar(),
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
                    return const Text(" ");
                  } else {
                    return Column(
                      children: [
                        Stack(
                          children: [
                            Container(
                              height: Get.height * 0.5,
                              child: Image.network(
                                product.image,
                                width: Get.width,
                                fit: BoxFit.cover,
                              ),
                            ),
                            Align(
                              alignment: Alignment.topLeft,
                              child: IconButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                icon: Icon(
                                  Icons.arrow_back,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: Get.height * 0.01),
                        Padding(
                          padding: EdgeInsets.only(
                            left: Get.width * 0.04,
                            right: Get.width * 0.04,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width: Get.width * 0.7,
                                    child: Text(
                                      product.name,
                                      style:
                                          Theme.of(context).textTheme.headline1,
                                    ),
                                  ),
                                  FutureBuilder(
                                      future: _carregarMoney(),
                                      builder: (BuildContext context,
                                          AsyncSnapshot snapshot) {
                                        if (snapshot.data == null) {
                                          return const Text(" ");
                                        } else {
                                          switch (money_txt) {
                                            case 'EUR':
                                              {
                                                return Text(
                                                  product.price
                                                          .toStringAsFixed(2) +
                                                      " €",
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .headline5!
                                                      .copyWith(
                                                        fontSize:
                                                            Get.width * 0.04,
                                                      ),
                                                );
                                              }
                                            case 'ECV':
                                              {
                                                return Text(
                                                  product.price
                                                          .toStringAsFixed(0) +
                                                      " \$",
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .headline5!
                                                      .copyWith(
                                                        fontSize:
                                                            Get.width * 0.04,
                                                      ),
                                                );
                                              }
                                            case 'USD':
                                              {
                                                return Text(
                                                  "\$ " +
                                                      product.price
                                                          .toStringAsFixed(2),
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .headline5!
                                                      .copyWith(
                                                        fontSize:
                                                            Get.width * 0.04,
                                                      ),
                                                );
                                              }
                                          }
                                          return Container();
                                        }
                                      }),
                                ],
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: Get.height * 0.02),
                        Padding(
                          padding: EdgeInsets.only(
                            left: Get.width * 0.04,
                            right: Get.width * 0.04,
                          ),
                          child: Container(
                            height: Get.height * 0.15,
                            child: SingleChildScrollView(
                              child: Column(
                                children: [
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      'Descrição',
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline2!
                                          .copyWith(
                                            fontSize: Get.width * 0.035,
                                          ),
                                    ),
                                  ),
                                  SizedBox(height: Get.height * 0.01),
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      product.description,
                                      style:
                                          Theme.of(context).textTheme.headline4,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  }
              }
            }),
      ),
    );
  }
}
