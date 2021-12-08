import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:manda_bai/Controller/mandaBaiController.dart';
import 'package:manda_bai/Core/app_colors.dart';
import 'package:manda_bai/Core/app_fonts.dart';
import 'package:manda_bai/Core/app_images.dart';
import 'package:manda_bai/Model/product.dart';
import 'package:manda_bai/UI/category_filter/controller/mandaBaiProductController.dart';
import 'package:manda_bai/UI/category_filter/components/product_list_component.dart';
import 'package:websafe_svg/websafe_svg.dart';

class CategoryPage extends StatefulWidget {
  const CategoryPage({
    Key? key,
  }) : super(key: key);

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  TextEditingController pesquisa = TextEditingController();

  final MandaBaiProductController mandaBaiProductController = Get.find();

  List<String> list_filter = [
    'Menos Preço',
    'Mais Preço',
  ];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    mandaBaiProductController.filter.value = "Menos Preço";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(
                top: Get.height * 0.045,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(Icons.arrow_back),
                    ),
                  ),
                  SizedBox(
                    width: Get.width * 0.7,
                    height: 40,
                    child: TextField(
                      cursorColor: AppColors.greenColor,
                      controller: pesquisa,
                      style: Theme.of(context).textTheme.headline4,
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(30.0)),
                            borderSide:
                                BorderSide(color: AppColors.greenColor)),
                        hintText: 'Pesquisar Produto...',
                        hintStyle: Theme.of(context).textTheme.headline4,
                        contentPadding: EdgeInsets.only(top: 10, left: 15),
                        suffixIcon: Icon(
                          Icons.search,
                          color: AppColors.greenColor,
                        ),
                        filled: true,
                        fillColor: Theme.of(context).backgroundColor,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(30.0),
                          ),
                        ),
                      ),
                      onChanged: (text) {
                        mandaBaiProductController.text_pesquisa.value =
                            pesquisa.text;
                        mandaBaiProductController.search();
                      },
                    ),
                  ),
                  Container(
                    width: Get.width * 0.1,
                    height: Get.height * 0.06,
                    margin: EdgeInsets.only(
                      right: Get.width * 0.04,
                    ),
                    child: DropdownButton(
                      icon: Icon(
                        Icons.filter_alt_sharp,
                        color: AppColors.greenColor,
                        size: 20.09,
                      ),

                      isExpanded: true,
                      underline:
                          DropdownButtonHideUnderline(child: Container()),
                      items: list_filter.map((val) {
                        return DropdownMenuItem(
                          value: val,
                          child: Text(val),
                        );
                      }).toList(),
                      //  value: dropdownValue,
                      onChanged: (String? value) {
                        setState(() {
                          mandaBaiProductController.filter.value = value!;
                          mandaBaiProductController.ordenar();
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.only(
                  top: Get.height * 0.01, left: Get.width * 0.04),
              child: Align(
                alignment: Alignment.topLeft,
                child: Text(
                  mandaBaiProductController.category.value.name.toString(),
                  style: Theme.of(context).textTheme.headline1,
                ),
              ),
            ),
            FutureBuilder(
              future: mandaBaiProductController.loadProduct(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (!snapshot.hasData) {
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
                } else {
                  if (snapshot.data == null) {
                    return Container(
                      height: Get.height * 0.85,
                      width: Get.width,
                      child: Center(
                        child: Text(
                          "Sem Produtos...",
                          style: TextStyle(
                            fontFamily: AppFonts.poppinsBoldFont,
                            fontSize: Get.width * 0.035,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    );
                  } else {
                    return Container(
                      height: Get.height * 0.85,
                      margin: EdgeInsets.only(
                        left: Get.width * 0.05,
                        right: Get.width * 0.05,
                      ),
                      child: GridView.builder(
                          padding: const EdgeInsets.only(
                            top: 0.0,
                          ),
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount:
                                      (Get.width == Orientation.portrait)
                                          ? 2
                                          : 2),
                          itemCount:
                              mandaBaiProductController.list_product.length,
                          itemBuilder: (BuildContext ctx, index) {
                            var list =
                                mandaBaiProductController.list_product[index];
                            return ProductListComponent(product: list);
                          }),
                    );
                  }
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
