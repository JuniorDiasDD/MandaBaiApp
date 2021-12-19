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
import 'package:manda_bai/UI/home/pop_up/pop_up_message.dart';
import 'package:manda_bai/UI/location_destination/page/destination_page.dart';
import 'package:readmore/readmore.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'checkout_page_step_3.dart';
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
  Future<void> validateAndSave() async {
    final FormState? form = _formKey.currentState;
    if (form!.validate()) {
      if (widget.location != null) {
        cartPageController.note = input_info.text;
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CheckoutPageStep3(location: widget.location),
          ),
        );
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
      print('Form is valid');
    } else {
      print('Form is invalid');
    }
  }

  List<Location> list_location = [];
  Future _carregarLocation() async {
    if (list_location.isEmpty) {
      list_location = await ServiceRequest.loadLocation();

      if (list_location.isEmpty) {
        return null;
      }
    }
    return list_location;
  }

  String island = "";
  Future _carregarIsland() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    island = prefs.getString('island')!;
    return island;
  }

  String dataPersone = "";
  Future _carregarDados() async {
    dataPersone = "Dados Pessoais \n " +
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
                              bool check = await ServiceRequest.createOrder(
                                  false,
                                  "cancelled",
                                  widget.location,
                                  cartPageController.list,
                                  cartPageController.total,
                                  cartPageController.note);
                              if (check) {
                                cartPageController.loading = false;
                              } else {
                                cartPageController.loading = false;
                              }
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
                          onPressed: () {},
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
                                AppLocalizations.of(context)!.text_island,
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
                      height: Get.height * 0.3,
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
                                      Icon(
                                        Icons.add,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            )
                          : Padding(
                              padding: EdgeInsets.all(
                                Get.width * 0.03,
                              ),
                              child: Column(
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
                                        Icon(
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
                                          offset: Offset(0.5, 0.5),
                                        ),
                                      ],
                                    ),
                                    height: Get.height * 0.15,
                                    child: ListView(
                                      padding: EdgeInsets.all(0.0),
                                      children: [
                                        Padding(
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
                                                  Icon(
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
                                                  Icon(
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
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
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
                    Container(
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
                            borderRadius: new BorderRadius.circular(15.0),
                            borderSide: new BorderSide(),
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
          ),
        ],
      ),
      bottomNavigationBar: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(" "),
          Padding(
            padding: EdgeInsets.only(
              right: 15,
              bottom: 10,
            ),
            child: TextButton(
              onPressed: validateAndSave,
              child: Text(
                AppLocalizations.of(context)!.textbutton_next + " >",
                style: TextStyle(
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
