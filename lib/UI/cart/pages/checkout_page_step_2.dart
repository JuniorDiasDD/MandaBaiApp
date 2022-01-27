import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:manda_bai/Controller/cart_controller.dart';
import 'package:manda_bai/Controller/request.dart';
import 'package:manda_bai/Controller/static_config.dart';
import 'package:manda_bai/Core/app_colors.dart';
import 'package:manda_bai/Core/app_fonts.dart';
import 'package:manda_bai/Core/app_images.dart';
import 'package:manda_bai/Model/location.dart';
import 'package:manda_bai/UI/cart/components/Popupinfo_checkout.dart';
import 'package:manda_bai/UI/cart/pages/web_view.dart';
import 'package:manda_bai/UI/home/pop_up/pop_up_message.dart';
import 'package:manda_bai/UI/location_destination/page/destination_page.dart';
import 'package:readmore/readmore.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CheckoutPageStep2 extends StatefulWidget {
  var location;

  CheckoutPageStep2({Key? key, required this.location}) : super(key: key);

  @override
  _CheckoutPageStep2State createState() => _CheckoutPageStep2State();
}

class _CheckoutPageStep2State extends State<CheckoutPageStep2> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final CartPageController cartPageController = Get.find();
  final input_info = TextEditingController();
  bool isCheckedPromocao = false;
  final input_codigo = TextEditingController();
  Future<void> validateAndSave() async {
    final FormState? form = _formKey.currentState;
    if (form!.validate()) {
      if (widget.location != null) {
        cartPageController.note = input_info.text;
        cartPageController.loading = true;
        var check = await ServiceRequest.createOrder(
            "",
            widget.location,
            cartPageController.list,
            cartPageController.total,
            cartPageController.note,
            isCheckedPromocao,
            input_codigo.text);
        if (check == "Erro de serviço") {
          cartPageController.loading = false;
          return showDialog(
              context: context,
              builder: (BuildContext context) {
                return Pop_up_Message(
                    mensagem: AppLocalizations.of(context)!.message_error_order,
                    icon: Icons.error,
                    caminho: "erro");
              });
        } else if (check == "Erro de cupom") {
          cartPageController.loading = false;
          return showDialog(
              context: context,
              builder: (BuildContext context) {
                return Pop_up_Message(
                    mensagem: AppLocalizations.of(context)!.message_error_order,
                    icon: Icons.error,
                    caminho: "erro");
              });
        } else if (check == "false") {
          cartPageController.loading = false;
          return showDialog(
              context: context,
              builder: (BuildContext context) {
                return Pop_up_Message(
                    mensagem: AppLocalizations.of(context)!.message_error_order,
                    icon: Icons.error,
                    caminho: "erro");
              });
        } else {
          cartPageController.loading = false;
          cartPageController.order = check.toString();
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => WebViewPage(sub: island),
            ),
          );
        }
      } else {
        return showDialog(
            context: context,
            builder: (BuildContext context) {
              return Pop_up_Message(
                  mensagem: AppLocalizations.of(context)!
                      .message_error_destination_select,
                  icon: Icons.error,
                  caminho: "erro");
            });
      }
    }
  }

  List<Location> list_location = [];
  String island = "";
  Future _carregarIsland() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    island = prefs.getString('island')!;
    return island;
  }

  String dataPersone = "";
  Future _carregarDados() async {
    dataPersone = AppLocalizations.of(context)!.text_personal_data +
        " \n " +
        AppLocalizations.of(context)!.textfield_name +
        ": " +
        user.name +
        "\n Email: " +
        user.email +
        "\n " +
        AppLocalizations.of(context)!.textfield_phone +
        ": " +
        user.telefone +
        "\n" +
        AppLocalizations.of(context)!.textfield_city +
        ": " +
        user.city +
        "\n" +
        AppLocalizations.of(context)!.textfield_country +
        ": " +
        user.country;
    return dataPersone;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Padding(
            padding: EdgeInsets.only(
                left: Get.width * 0.04, right: Get.width * 0.04),
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    SizedBox(height: Get.height * 0.08),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          child: IconButton(
                            onPressed: () async {
                              cartPageController.loading = true;
                              var check = await ServiceRequest.createOrder(
                                  "cancelled",
                                  widget.location,
                                  cartPageController.list,
                                  cartPageController.total,
                                  cartPageController.note,
                                  false,
                                  "");

                              cartPageController.loading = false;

                              Navigator.pop(context);
                            },
                            icon: const Icon(
                              Icons.arrow_back,
                            ),
                            alignment: Alignment.centerRight,
                          ),
                        ),
                        Text(
                          AppLocalizations.of(context)!.text_checkout,
                          style: Theme.of(context).textTheme.headline1,
                        ),
                        IconButton(
                          padding: const EdgeInsets.all(0.0),
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return PopupInfo_Checkout(
                                    title: AppLocalizations.of(context)!
                                        .title_instructions,
                                    subTitle: AppLocalizations.of(context)!
                                        .text_information,
                                    text: AppLocalizations.of(context)!
                                        .text_information_checkout);
                              },
                            );
                          },
                          icon: const Icon(
                            Icons.info,
                          ),
                          iconSize: Get.width * 0.05,
                          alignment: Alignment.centerRight,
                        ),
                      ],
                    ),
                    SizedBox(height: Get.height * 0.02),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        AppLocalizations.of(context)!
                            .subtitle_billing_and_shipping,
                        style: Theme.of(context).textTheme.headline1,
                      ),
                    ),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          FutureBuilder(
                              future: _carregarDados(),
                              builder: (BuildContext context,
                                  AsyncSnapshot snapshot) {
                                if (snapshot.data == null) {
                                  return const Text(" ");
                                } else {
                                  return ReadMoreText(
                                    dataPersone,
                                    trimLines: 2,
                                    colorClickableText: AppColors.greenColor,
                                    trimMode: TrimMode.Line,
                                    trimCollapsedText:
                                        AppLocalizations.of(context)!
                                            .readmoretext_data,
                                    trimExpandedText:
                                        AppLocalizations.of(context)!
                                            .readmoretext_close,
                                    style:
                                        Theme.of(context).textTheme.headline4,
                                    moreStyle:
                                        Theme.of(context).textTheme.headline6,
                                  );
                                }
                              }),
                          SizedBox(height: Get.height * 0.01),
                          Text(
                            AppLocalizations.of(context)!
                                .subtitle_recipient_data,
                            style: Theme.of(context).textTheme.headline1,
                          ),
                          SizedBox(height: Get.height * 0.01),
                          Row(
                            children: [
                              Text(
                                AppLocalizations.of(context)!.text_island + " ",
                                style: Theme.of(context).textTheme.headline2,
                              ),
                              FutureBuilder(
                                  future: _carregarIsland(),
                                  builder: (BuildContext context,
                                      AsyncSnapshot snapshot) {
                                    if (snapshot.data == null) {
                                      return const Text(" ");
                                    } else {
                                      return Text(
                                        island,
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline2,
                                      );
                                    }
                                  }),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: Get.height * 0.35,
                      child: widget.location == null
                          ? TextButton(
                              onPressed: () {
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Destination_Page(
                                            route: "checkout")));
                              },
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    AppLocalizations.of(context)!
                                        .text_no_delivery_locations,
                                    style:
                                        Theme.of(context).textTheme.headline3,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        AppLocalizations.of(context)!
                                            .text_enter_destiny,
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline3,
                                      ),
                                      const Icon(
                                        Icons.add,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            )
                          : Column(
                            children: [
                              TextButton(
                                onPressed: () {
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              Destination_Page(
                                                  route: "checkout")));
                                },
                                child: Row(
                                  children: [
                                    Text(
                                      AppLocalizations.of(context)!
                                          .text_delivery_address,
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline1,
                                    ),
                                    const Spacer(),
                                    Text(
                                      AppLocalizations.of(context)!
                                          .text_change,
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline3,
                                    ),
                                    const Icon(
                                      Icons.add,
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  color: Theme.of(context)
                                      .dialogBackgroundColor,
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Theme.of(context).cardColor,
                                      blurRadius: 1.0,
                                      spreadRadius: 0.0,
                                      offset: const Offset(0.5, 0.5),
                                    ),
                                  ],
                                ),
                                height: Get.height * 0.25,
                                child: Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        widget.location.name,
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline2,
                                      ),
                                      SizedBox(
                                        height: Get.height * 0.01,
                                      ),
                                      Row(
                                        children: [
                                          const Icon(
                                            Icons.location_on_outlined,
                                          ),
                                          Text(
                                            widget.location.island,
                                            style: Theme.of(context)
                                                .textTheme
                                                .headline3,
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: Get.height * 0.01,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 15.0),
                                        child: Text(
                                          widget.location.city +
                                              ',' +
                                              widget.location.endereco,
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline4,
                                        ),
                                      ),
                                      SizedBox(
                                        height: Get.height * 0.01,
                                      ),
                                      Row(
                                        children: [
                                          const Icon(
                                            Icons.phone,
                                          ),
                                          Text(
                                            widget.location.phone,
                                            style: Theme.of(context)
                                                .textTheme
                                                .headline4,
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                    ),
                    Row(
                      children: [
                        Checkbox(
                          checkColor: Colors.white,
                          activeColor: Colors.green,
                          value: isCheckedPromocao,
                          onChanged: (bool? value) {
                            setState(() {
                              isCheckedPromocao = value!;
                            });
                          },
                        ),
                        Text(
                          AppLocalizations.of(context)!.text_discount,
                          style: Theme.of(context).textTheme.headline6,
                        ),
                      ],
                    ),
                    Container(
                      child: isCheckedPromocao == true
                          ? Column(
                              children: [
                                Align(
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    AppLocalizations.of(context)!
                                        .subtitle_code_discount,
                                    style:
                                        Theme.of(context).textTheme.headline2,
                                  ),
                                ),
                                SizedBox(
                                  height: Get.height * 0.005,
                                ),
                                TextFormField(
                                  controller: input_codigo,
                                  style: Theme.of(context).textTheme.headline4,
                                  decoration: InputDecoration(
                                    filled: true,
                                    fillColor:
                                        Theme.of(context).backgroundColor,
                                    border: OutlineInputBorder(
                                      borderRadius:
                                          new BorderRadius.circular(15.0),
                                      borderSide: new BorderSide(),
                                    ),
                                  ),
                                  validator: (value) => value!.isEmpty
                                      ? AppLocalizations.of(context)!
                                          .valitador_code_discount
                                      : null,
                                ),
                                SizedBox(
                                  height: Get.height * 0.01,
                                ),
                              ],
                            )
                          : Container(),
                    ),
                    SizedBox(height: Get.height * 0.02),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        AppLocalizations.of(context)!.subtitle_add_information,
                        style: Theme.of(context).textTheme.headline2,
                      ),
                    ),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        AppLocalizations.of(context)!.text_notes,
                        style: Theme.of(context).textTheme.headline4,
                      ),
                    ),
                    SizedBox(height: Get.height * 0.01),
                    SizedBox(
                      height: Get.height * 0.2,
                      width: Get.width,
                      child: TextFormField(
                        maxLines: 10,
                        controller: input_info,
                        keyboardType: TextInputType.text,
                        style: Theme.of(context).textTheme.headline4,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Theme.of(context).backgroundColor,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15.0),
                            borderSide: const BorderSide(),
                          ),
                          hintText: AppLocalizations.of(context)!.hint_write,
                          hintStyle: Theme.of(context).textTheme.headline4,
                        ),
                      ),
                    ),
                    SizedBox(height: Get.height * 0.03),
                  ],
                ),
              ),
            ),
          ),
          Obx(
            () => SizedBox(
              child: cartPageController.loading
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
          ),
        ],
      ),
      bottomNavigationBar: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(" "),
          Padding(
            padding: const EdgeInsets.only(
              right: 15,
              bottom: 10,
            ),
            child: TextButton(
              onPressed: validateAndSave,
              child: Text(
                AppLocalizations.of(context)!.textbutton_next + " >",
                style: const TextStyle(
                    fontFamily: AppFonts.poppinsRegularFont,
                    color: AppColors.greenColor),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
