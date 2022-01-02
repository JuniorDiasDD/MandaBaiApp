import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:manda_bai/Controller/request.dart';
import 'package:manda_bai/Core/app_colors.dart';
import 'package:manda_bai/Core/app_fonts.dart';
import 'package:get/get.dart';
import 'package:manda_bai/Core/app_images.dart';
import 'package:manda_bai/Model/product.dart';
import 'package:manda_bai/UI/home/pop_up/pop_login.dart';
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
        child: SingleChildScrollView(
          child: Stack(
            children: [
              Column(
                children: [
                  Stack(
                    children: [
                      Container(
                        width: Get.width,
                        height: Get.height * 0.45,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          image: DecorationImage(
                            fit: BoxFit.fill,
                            image: NetworkImage(widget.product.image),
                          ),
                        ),
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
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width: Get.width * 0.7,
                                  child: Text(
                                    widget.product.name,
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
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
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
                ],
              ),
              SizedBox(
                child: loading
                    ? Container(
                        color: Colors.black54,
                        height: Get.height,
                        child: Center(
                          child: Image.network(
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
      ),
      bottomNavigationBar: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: Get.height * 0.06,
            width: Get.width * 0.9,
            margin: const EdgeInsets.only(bottom: 20),
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
              onPressed: () async {
                final SharedPreferences prefs =
                    await SharedPreferences.getInstance();
                var check = prefs.getString('id');
                if (check == 'null' || check == null) {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return const Pop_Login();
                      });
                } else {
                  _addCart(widget.product.id);
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
