import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:manda_bai/Controller/request.dart';
import 'package:manda_bai/Model/product.dart';
import 'package:manda_bai/UI/description_product/pages/product_detail_page.dart';

class ProductListComponent extends StatefulWidget {
  Product product;

  ProductListComponent({Key? key, required this.product}) : super(key: key);

  @override
  State<ProductListComponent> createState() => _ProductListComponentState();
}

class _ProductListComponentState extends State<ProductListComponent> {
  bool checkFavorite = false;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ProdutoDetailPage(
            product: widget.product,
          ),
        ),
      ),
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
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: Get.width,
                height: Get.height * 0.11,
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
              Padding(
                child: Text(
                  widget.product.name,
                  maxLines: 1,
                  style: Theme.of(context).textTheme.headline4,
                ),
                padding: EdgeInsets.only(
                  left: Get.width * 0.03,
                  top: Get.width * 0.03,
                ),
              ),
              Container(
                padding: EdgeInsets.only(
                  left: Get.width * 0.01,
                ),
                width: Get.width,
                height: Get.height * 0.03,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                            left: Get.width * 0.02,
                          ),
                          child: Text(
                            widget.product.price.toString(),
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.headline5,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            left: Get.width * 0.01,
                          ),
                          child: Text(
                            '€',
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.headline5,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        IconButton(
                          padding: const EdgeInsets.all(0.0),
                          onPressed: () {
                            if (widget.product.favorite == false) {
                              ServiceRequest.addFavrite(widget.product.id);
                              setState((){
                                widget.product.favorite=!widget.product.favorite;
                              });
                            } else {
                              ServiceRequest.removeFavrite(widget.product.id);
                               setState((){
                                widget.product.favorite=!widget.product.favorite;
                              });
                            }
                          },
                          icon: const Icon(Icons.favorite),
                          iconSize: Get.width * 0.05,
                          alignment: Alignment.centerRight,
                          color: widget.product.favorite ? Colors.red : Colors.black54,
                        ),
                        IconButton(
                          padding: const EdgeInsets.all(0.0),
                          onPressed: () {},
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
      ),
      // onTap: onTap,
    );
  }
}
