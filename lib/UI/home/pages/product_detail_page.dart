import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:manda_bai/Core/app_colors.dart';
import 'package:manda_bai/Core/app_fonts.dart';
import 'package:manda_bai/Core/app_images.dart';
import 'package:get/get.dart';

class ProdutoDetailPage extends StatefulWidget {
  const ProdutoDetailPage({Key? key}) : super(key: key);

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
            Container(
              child: Image.asset(
                AppImages.tv,
                width: Get.width,
                fit: BoxFit.cover,
              ),
              padding: const EdgeInsets.only(
                right: 10.0,
                left: 10.0,
              ),
            ),
            SizedBox(height: Get.height * 0.01),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    left: 10.0,
                    right: 10.0,
                  ),
                  child: Column(
                    children: const [
                      Text(
                        'Samsung SmartTv',
                        style: TextStyle(
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
                const Padding(
                  padding: EdgeInsets.only(
                    right: 10.0,
                  ),
                  child: Text(
                    '500.00 €',
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 10.0,
                right: 10.0,
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
            const Padding(
              padding: EdgeInsets.only(
                left: 10.0,
                right: 10.0,
              ),
              child: Text(
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
          ],
        ),
      ),
    );
  }
}
