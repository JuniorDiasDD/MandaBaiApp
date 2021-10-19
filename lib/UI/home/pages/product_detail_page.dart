import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:manda_bai/Core/app_colors.dart';
import 'package:manda_bai/Core/app_fonts.dart';
import 'package:manda_bai/Core/app_images.dart';
import 'package:get/get.dart';
import 'package:manda_bai/UI/home/pages/cart_page.dart';

class ProdutoDetailPage extends StatefulWidget {
  final String imageName;
  final String productName;
  final String priceProduct;
  ProdutoDetailPage(
      {required this.imageName,
      required this.priceProduct,
      required this.productName});

  @override
  State<ProdutoDetailPage> createState() => _ProdutoDetailPageState();
}

class _ProdutoDetailPageState extends State<ProdutoDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            //SizedBox(height: Get.height * 0.01),
            
            Stack(
              children:[ 
                Container(
                child: Image.asset(
                  widget.imageName,
                  width: Get.width,
                  fit: BoxFit.cover,
                ),
                padding: const EdgeInsets.only(
                  right: 10.0,
                  left: 10.0,
                ),
              ),
              Align(
              alignment: Alignment.topLeft,
              child: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                // ignore: prefer_const_constructors
                icon: Icon(Icons.arrow_back),
              ),
            ),
              ],
              
            ),
            SizedBox(height: Get.height * 0.01),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: EdgeInsets.only(
                    left: Get.width * 0.02,
                    //right: 10.0,
                  ),
                  child: Column(
                    children: [
                      Text(
                        widget.productName,
                        style: const TextStyle(
                          fontFamily: AppFonts.poppinsBoldFont,
                          fontSize: 15,
                        ),
                      ),
                      /*Align(
                        alignment: Alignment.topLeft,
                        child: RatingBar.builder(
                          initialRating: 4,
                          minRating: 1,
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
                      ),*/
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    right: Get.width * 0.02,
                  ),
                  child: Text(
                    widget.priceProduct,
                  ),
                ),
              ],
            ),
            Padding(
              padding:  EdgeInsets.only(
                left: Get.width * 0.02,
                right: Get.width * 0.02,
              ),
              child: Align(
                alignment: Alignment.topLeft,
                child: RatingBar.builder(
                  initialRating: 4,
                  minRating: 1,
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
            ),
            SizedBox(height: Get.height * 0.06),
            Padding(
              padding: EdgeInsets.only(
                left: Get.width * 0.02,
                right: Get.width * 0.02,
              ),
              child: const Text(
                'blablahhhhfffffffblablahhhhfffffffblablahhhhfffffffblablahhhhfffffffblablahhhhffffffffblablahhhhffffffffblablahhhhffffffffblablahhhhffffffffblablahhhhffffffffblablahhhhffffffffblablahhhhfffffff',
                style: TextStyle(
                  fontFamily: AppFonts.poppinsRegularFont,
                  fontSize: 12,
                ),
              ),
            ),
            SizedBox(height: Get.height * 0.04),
            // ignore: sized_box_for_whitespace
            Container(
              width: Get.width * 0.3,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  // ignore: sized_box_for_whitespace
                  Container(
                    width: Get.width * 0.08,
                    child: FloatingActionButton(
                      onPressed: () {
                        setState(
                          () {},
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
                  const Text(
                    '1',
                    style: TextStyle(fontSize: 18.0),
                  ),
                  // ignore: sized_box_for_whitespace
                  Container(
                    width: Get.width * 0.08,
                    child: FloatingActionButton(
                      child: const Icon(Icons.add, color: Colors.white),
                      backgroundColor: AppColors.greenColor,
                      elevation: 0,
                      onPressed: () {
                        setState(() {});
                      },
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: Get.height * 0.05),
            Padding(
              padding: EdgeInsets.only(left: Get.width * 0.02,right: Get.width * 0.02,),
              child: Container(
                height: Get.height * 0.05,
                width: Get.width,
                child: FlatButton(
                  padding: EdgeInsets.only(
                    left: Get.width * 0.05,
                    right: Get.height * 0.05,
                  ),
                  color: AppColors.greenColor,
                  textColor: Colors.white,
                  child: Text('Adicionar ao Carrinho'),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CartPage(),
                      ),
                    );
                  },
                  shape: RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(30.0),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
