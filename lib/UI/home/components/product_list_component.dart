import 'package:flutter/material.dart';
import 'package:flutter_session/flutter_session.dart';
import 'package:get/get.dart';
import 'package:manda_bai/Controller/request.dart';
import 'package:manda_bai/Model/product.dart';
import 'package:manda_bai/UI/category_filter/controller/categoryController.dart';
import 'package:manda_bai/UI/description_product/pages/product_detail_page.dart';
import 'package:manda_bai/UI/home/pop_up/pop_up_message.dart';

class ProductListComponent extends StatefulWidget {
  Product product;

  ProductListComponent({Key? key, required this.product}) : super(key: key);

  @override
  State<ProductListComponent> createState() => _ProductListComponentState();
}

class _ProductListComponentState extends State<ProductListComponent> {
  final CategoryController controller = Get.find();
  bool checkFavorite = false;
  Future _addCart(id) async {
    bool check = await ServiceRequest.addCart(id, 1);
    return check;
  }

  var money_txt;
  Future _carregarMoney() async {
    money_txt = await FlutterSession().get('money');

    return money_txt;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (controller.loading == false) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ProdutoDetailPage(
                product: widget.product,
              ),
            ),
          );
        }
      },
      child: Padding(
        padding: EdgeInsets.only(
            left: Get.width * 0.023,
            top: Get.height * 0.009,
            bottom: Get.height * 0.005),
        child: Container(
          width: Get.width * 0.4,
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Theme.of(context).cardColor,
                blurRadius: 1.0,
                spreadRadius: 0.0,
                offset: Offset(1.0, 1.0),
              ),
            ],
          ),
          child: Column(
            children: [
              Flexible(
                flex: 2,
                child: Container(
                  width: Get.width,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(10.0),
                        topRight: Radius.circular(10.0)),
                    color: Colors.white,
                    image: DecorationImage(
                      fit: BoxFit.fill,
                      image: NetworkImage(widget.product.image),
                    ),
                  ),
                ),
              ),
              Flexible(
                flex: 1,
                child: Column(
                  children: [
                    Flexible(
                      flex: 1,
                      child: Text(
                        widget.product.name,
                        maxLines: 1,
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.headline4,
                      ),
                    ),
                    Flexible(
                      flex: 1,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          SizedBox(
                            child: Padding(
                              padding: EdgeInsets.only(
                                left: 2.0,
                              ),
                              child: FutureBuilder(
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
                                              widget.product.price
                                                      .toStringAsFixed(2) +
                                                  " €",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .headline5,
                                            );
                                          }
                                        case 'ECV':
                                          {
                                            return Text(
                                              widget.product.price
                                                      .toStringAsFixed(0) +
                                                  " \$",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .headline5,
                                            );
                                          }
                                        case 'USD':
                                          {
                                            return Text(
                                              "\$ " +
                                                  widget.product.price
                                                      .toStringAsFixed(2),
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .headline5,
                                            );
                                          }
                                      }
                                      return Container();
                                    }
                                  }),
                            ),
                          ),
                          Row(
                            children: [
                              IconButton(
                                padding: const EdgeInsets.all(0.0),
                                onPressed: () {
                                  if (widget.product.favorite == false) {
                                    ServiceRequest.addFavrite(
                                        widget.product.id);
                                    setState(() {
                                      widget.product.favorite =
                                          !widget.product.favorite;
                                    });
                                  } else {
                                    ServiceRequest.removeFavrite(
                                        widget.product.id);
                                    setState(() {
                                      widget.product.favorite =
                                          !widget.product.favorite;
                                    });
                                  }
                                },
                                icon: const Icon(Icons.favorite),
                                iconSize: Get.width * 0.05,
                                alignment: Alignment.centerRight,
                                color: widget.product.favorite
                                    ? Colors.red
                                    : Theme.of(context).indicatorColor,
                              ),
                              IconButton(
                                padding: const EdgeInsets.all(0.0),
                                onPressed: () async {
                                  setState(() {
                                    controller.loading = true;
                                     });
                                    var check = await _addCart(widget.product.id);
                                    print(check.toString());
                                    if (check==true) {
                                     setState(() {
                                    controller.loading = false;
                                     });
                                      showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return Pop_up_Message(
                                                mensagem:
                                                    "Adicionado no carrinho",
                                                icon: Icons.check,
                                                caminho: "addCarrinho");
                                          });
                                    } else {
                                      setState(() {
                                    controller.loading = false;
                                     });
                                      showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return Pop_up_Message(
                                                mensagem:
                                                    "Erro em adicionar no carrinho",
                                                icon: Icons.error,
                                                caminho: "erro");
                                          });
                                    }
                                 
                                },
                                icon: const Icon(Icons.shopping_cart_outlined),
                                iconSize: Get.width * 0.05,
                                alignment: Alignment.center,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      // onTap: onTap,
    );
  }
}
