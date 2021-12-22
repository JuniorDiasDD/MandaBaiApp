import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:manda_bai/Controller/request.dart';
import 'package:manda_bai/Core/app_colors.dart';
import 'package:manda_bai/Core/app_fonts.dart';
import 'package:get/get.dart';
import 'package:manda_bai/Core/app_images.dart';
import 'package:manda_bai/Model/product.dart';
import 'package:manda_bai/UI/home/pop_up/pop_up_message.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
//import 'package:flutter_html/flutter_html.dart';

class ProdutoDetailPage extends StatefulWidget {
  Product product;
  ProdutoDetailPage({Key? key, required this.product}) : super(key: key);
  @override
  State<ProdutoDetailPage> createState() => _ProdutoDetailPageState();
}

class _ProdutoDetailPageState extends State<ProdutoDetailPage> {
  int quantidade = 1;
  bool loading = false;
  _addCart(id) async {
    setState(() {
      loading = true;
    });
    bool check = await ServiceRequest.addCart(id, quantidade);
    if (check) {
      setState(() {
        loading = false;
      });
      return showDialog(
          context: context,
          builder: (BuildContext context) {
            return Pop_up_Message(
                mensagem: AppLocalizations.of(context)!.message_success_cart,
                icon: Icons.check,
                caminho: "description");
          });
    } else {
      setState(() {
        loading = false;
      });
      return showDialog(
          context: context,
          builder: (BuildContext context) {
            return Pop_up_Message(
                mensagem: AppLocalizations.of(context)!.message_error_cart,
                icon: Icons.error,
                caminho: "erro");
          });
    }
  }

  var money_txt;
  Future _carregarMoney() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    money_txt = prefs.getString('money');

    return money_txt;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: Get.height,
        child: Stack(
          children: [
            Column(
              children: [
                Stack(
                  children: [
                    Image.network(
                      widget.product.image,
                      width: Get.width,
                      fit: BoxFit.cover,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0, top: 30.0),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: const Icon(
                            Icons.arrow_back,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                // SizedBox(height: Get.height * 0.01),
                SizedBox(
                  height: Get.height * 0.35,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    widget.product.name,
                                    style:
                                        Theme.of(context).textTheme.headline1,
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
                                                  widget.product.price
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
                                                  widget.product.price
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
                                                      widget.product.price
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
                              const Spacer(),
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
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: SizedBox(
                            height: Get.height * 0.25,
                            child: SingleChildScrollView(
                              child: Column(
                                children: [
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      AppLocalizations.of(context)!
                                          .text_description,
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
                                    child: Html(
                                      data: widget.product.description,
                                    ), /*Text(
                                      widget.product.description,
                                      style:
                                          Theme.of(context).textTheme.headline4,
                                    ),*/
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
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

                const Spacer(),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      SizedBox(
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
                                child:
                                    const Icon(Icons.add, color: Colors.white),
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
                      const SizedBox(height: 10),
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
                              (AppLocalizations.of(context)!.button_add_cart),
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
              ],
            ),
            SizedBox(
              child: loading
                  ? Container(
                      color: Colors.black54,
                      height: Get.height,
                      child: Center(
                        child: Image.asset(
                          AppImages.loading,
                          width: Get.width * 0.2,
                          height: Get.height * 0.2,
                          alignment: Alignment.center,
                        ),
                      ),
                    )
                  : null,
            ),
          ],
        ),
      ),
    );
  }
}
