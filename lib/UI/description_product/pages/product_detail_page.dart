import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_session/flutter_session.dart';
import 'package:manda_bai/Controller/request.dart';
import 'package:manda_bai/Core/app_colors.dart';
import 'package:manda_bai/Core/app_fonts.dart';
import 'package:get/get.dart';
import 'package:manda_bai/Model/product.dart';
import 'package:manda_bai/UI/cart/pages/cart_page.dart';
import 'package:manda_bai/UI/home/pop_up/pop_up_message.dart';

class ProdutoDetailPage extends StatefulWidget {
  Product product;
  ProdutoDetailPage({Key? key, required this.product}) : super(key: key);
  @override
  State<ProdutoDetailPage> createState() => _ProdutoDetailPageState();
}

class _ProdutoDetailPageState extends State<ProdutoDetailPage> {
  int quantidade = 1;
  _addCart(id) async {
    bool check = await ServiceRequest.addCart(id, quantidade);
    if (check) {
      return showDialog(
          context: context,
          builder: (BuildContext context) {
            return Pop_up_Message(
                mensagem: "Adicionado no carrinho",
                icon: Icons.check,
                caminho: "description");
          });
    } else {
      return showDialog(
          context: context,
          builder: (BuildContext context) {
            return Pop_up_Message(
                mensagem: "Erro em adicionar",
                icon: Icons.error,
                caminho: "erro");
          });
    }
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
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  height: Get.height * 0.5,
                  child: Image.network(
                    widget.product.image,
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
                    icon: Icon(Icons.arrow_back,color:Colors.black,),
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
                          widget.product.name,
                          style: Theme.of(context).textTheme.headline1,
                        ),
                      ),

                  FutureBuilder(
                      future: _carregarMoney(),
                      builder: (BuildContext context, AsyncSnapshot snapshot) {
                        if (snapshot.data == null) {
                          return const Text(" ");
                        } else {
                          switch (money_txt) {
                            case 'EUR':
                              {
                                return Text(
                                  widget.product.price.toStringAsFixed(2) +
                                      " €",
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline5!
                                      .copyWith(
                                        fontSize: Get.width * 0.04,
                                      ),
                                );
                              }
                            case 'ECV':
                              {
                                return Text(
                                  widget.product.price.toStringAsFixed(0) +
                                      " \$",
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline5!
                                      .copyWith(
                                        fontSize: Get.width * 0.04,
                                      ),
                                );
                              }
                            case 'USD':
                              {
                                return Text(
                                  "\$ " +
                                      widget.product.price.toStringAsFixed(2),
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline5!
                                      .copyWith(
                                        fontSize: Get.width * 0.04,
                                      ),
                                );
                              }
                          }
                          return Container();
                        }
                      }),

                    ],
                  ),
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
                    iconSize: Get.width * 0.09,
                    alignment: Alignment.centerRight,
                    color: widget.product.favorite
                        ? Colors.red
                        : Theme.of(context).indicatorColor,
                  ),
                ],
              ),
            ),
            /*   Padding(
              padding: EdgeInsets.only(
                left: Get.width * 0.03,
                right: Get.width * 0.04,
              ),
              child: Align(
                alignment: Alignment.topLeft,
                child: RatingBar.builder(
                  unratedColor: Colors.grey,
                  initialRating: widget.product.rating_count.toDouble(),
                  minRating: 0,
                  direction: Axis.horizontal,
                  allowHalfRating: true,
                  itemCount: 5,
                  itemSize: Get.height * 0.025,
                  itemPadding: const EdgeInsets.all(0.0),
                  itemBuilder: (context, _) => const Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
                  onRatingUpdate: (rating) {
                    //print(rating);
                  },
                ),
              ),
            ),*/
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
                        child: Text('Descrição',
                         style: Theme.of(context).textTheme.headline2!.copyWith( fontSize: Get.width * 0.035,
                         ),
                        ),
                      ),
                      SizedBox(height: Get.height * 0.01),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          widget.product.description,
                          style: Theme.of(context).textTheme.headline4,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: Get.height * 0.02),
            Container(
              width: Get.width * 0.3,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    width: Get.width * 0.08,
                    child: FloatingActionButton(
                      onPressed: () {
                        setState(
                          () {
                            if (quantidade != 1) {
                              quantidade--;
                            }
                          },
                        );
                      },
                      child: const Icon(
                        Icons.remove,
                        color: Colors.white,
                      ),
                      backgroundColor: AppColors.greenColor,
                      elevation: 0,
                    ),
                  ),
                  Text(
                    quantidade.toString(),
                    style: Theme.of(context).textTheme.headline3,
                  ),
                  Container(
                    width: Get.width * 0.08,
                    child: FloatingActionButton(
                      child: const Icon(Icons.add, color: Colors.white),
                      backgroundColor: AppColors.greenColor,
                      elevation: 0,
                      onPressed: () {
                        setState(() {
                          quantidade++;
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: Get.height * 0.026),
            Padding(
              padding: EdgeInsets.only(
                left: Get.width * 0.04,
                right: Get.width * 0.04,
              ),
              child: Container(
                height: Get.height * 0.06,
                width: Get.width,
                decoration: BoxDecoration(
                  color: AppColors.greenColor,
                  borderRadius: BorderRadius.all(
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
                child: TextButton(
                  child: Text(
                    'Adicionar ao Carrinho',
                    style: TextStyle(
                        fontFamily: AppFonts.poppinsBoldFont,
                        fontSize: Get.width * 0.035,
                        color: Colors.white),
                  ),
                  onPressed: () {
                    _addCart(widget.product.id);
                  },
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }
}
