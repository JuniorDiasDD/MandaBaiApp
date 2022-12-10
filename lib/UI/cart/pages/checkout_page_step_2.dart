import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:manda_bai/Controller/static_config.dart';
import 'package:manda_bai/Core/app_colors.dart';
import 'package:manda_bai/Core/app_fonts.dart';
import 'package:manda_bai/Core/app_images.dart';
import 'package:manda_bai/UI/cart/components/Popupinfo_checkout.dart';
import 'package:manda_bai/UI/cart/pages/web_view.dart';
import 'package:manda_bai/UI/home/pop_up/popup_message_internet.dart';
import 'package:manda_bai/UI/location_destination/components/item_location.dart';
import 'package:manda_bai/UI/location_destination/page/new_destination.dart';
import 'package:manda_bai/UI/widget/dialogs.dart';
import 'package:manda_bai/constants/controllers.dart';
import 'package:readmore/readmore.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CheckoutPageStep2 extends StatefulWidget {
  const CheckoutPageStep2({Key? key}) : super(key: key);

  @override
  _CheckoutPageStep2State createState() => _CheckoutPageStep2State();
}

class _CheckoutPageStep2State extends State<CheckoutPageStep2> {
  ConnectivityResult _connectionStatus = ConnectivityResult.none;
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;

  int net = 0;

  Future<void> initConnectivity() async {
    late ConnectivityResult result;
    try {
      result = await _connectivity.checkConnectivity();
    } on PlatformException catch (e) {
      print('Couldn\'t check connectivity status' + e.toString());
      return;
    }

    if (!mounted) {
      return Future.value(null);
    }
    return _updateConnectionStatus(result);
  }

  Future<void> _updateConnectionStatus(ConnectivityResult result) async {
    setState(() {
      _connectionStatus = result;
      print(_connectionStatus.toString());
      if (_connectionStatus == ConnectivityResult.none) {
        net = 1;
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return PopupMessageInternet(
                  mensagem: AppLocalizations.of(context)!.message_erro_internet,
                  icon: Icons.signal_wifi_off);
            });
      } else {
        if (net != 0) {
          Navigator.pop(context);
        }
      }
    });
  }

  @override
  void initState() {
    super.initState();
    initConnectivity();

    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
  }

  @override
  void dispose() {
    _connectivitySubscription.cancel();
    super.dispose();
  }

  String dataPersone = "";
  Future _carregarDados() async {
    dataPersone = AppLocalizations.of(context)!.text_personal_data +
        " \n " +
        AppLocalizations.of(context)!.textfield_name +
        ": " +
        user.name! +
        "\n Email: " +
        user.email! +
        "\n " +
        AppLocalizations.of(context)!.textfield_phone +
        ": " +
        user.telefone! +
        "\n" +
        AppLocalizations.of(context)!.textfield_city +
        ": " +
        user.city! +
        "\n" +
        AppLocalizations.of(context)!.textfield_country +
        ": " +
        user.country!;
    return dataPersone;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Form(
              key: cartPageController.formKey,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      width: double.infinity,
                      child: Padding(
                        padding: const EdgeInsets.only(
                            right: 16.0, left: 8, top: 16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            TextButton(
                              onPressed: () async {
                                openLoadingStateDialog(context);
                                await cartPageController.canceledOrder();
                                Navigator.pop(context);
                                Navigator.pop(context);
                              },
                              child: Text(
                                "< " +
                                    AppLocalizations.of(context)!
                                        .title_checkout_data,
                                style: Theme.of(context).textTheme.headline3,
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
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
                              child: Container(
                                width: Get.width * 0.1,
                                height: Get.width * 0.1,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  color: AppColors.grey50.withOpacity(0.8),
                                ),
                                child: const Padding(
                                  padding: EdgeInsets.all(6.0),
                                  child: Icon(
                                    Icons.info_outline,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: Get.height * 0.83,
                      child: SingleChildScrollView(
                        child: Padding(
                          padding: EdgeInsets.only(
                              left: Get.width * 0.03, right: Get.width * 0.03),
                          child: Column(
                            children: [
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
                                              colorClickableText:
                                                  AppColors.greenColor,
                                              trimMode: TrimMode.Line,
                                              trimCollapsedText:
                                                  AppLocalizations.of(context)!
                                                      .readmoretext_data,
                                              trimExpandedText:
                                                  AppLocalizations.of(context)!
                                                      .readmoretext_close,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .headline4,
                                              moreStyle: Theme.of(context)
                                                  .textTheme
                                                  .headline6,
                                            );
                                          }
                                        }),
                                    SizedBox(height: Get.height * 0.01),
                                    Text(
                                      AppLocalizations.of(context)!
                                          .subtitle_recipient_data,
                                      style:
                                          Theme.of(context).textTheme.headline1,
                                    ),
                                    SizedBox(height: Get.height * 0.01),
                                    Row(
                                      children: [
                                        Text(
                                          AppLocalizations.of(context)!
                                                  .text_island +
                                              " " +
                                              fullControllerController
                                                  .island.value,
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline2,
                                        ),
                                        const Spacer(),
                                        TextButton(
                                          onPressed: () {
                                            locationController.cleanInptus();
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                       const NewDestination(
                                                            location: null)));
                                          },
                                          child: Row(
                                            children: [
                                              Text(
                                                AppLocalizations.of(context)!
                                                    .new_address,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .headline2,
                                              ),
                                              const Icon(
                                                Icons.add,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: Get.height * 0.3,
                                child: Obx(
                                  () => locationController.listLocation.isEmpty
                                      ? Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              AppLocalizations.of(context)!
                                                  .text_no_locations,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .headline3,
                                            ),
                                            Text(
                                              AppLocalizations.of(context)!
                                                  .text_add_new_location,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .headline3,
                                            ),
                                          ],
                                        )
                                      : ListView.builder(
                                          padding: EdgeInsets.only(
                                            top: 0.0,
                                            bottom: Get.height * 0.03,
                                          ),
                                          scrollDirection: Axis.vertical,
                                          itemCount: locationController
                                              .listLocation.length,
                                          itemBuilder:
                                              (BuildContext context, index) {
                                            var element = locationController
                                                .listLocation[index];
                                            return ItemLocation(
                                                location: element);
                                          },
                                        ),
                                ),
                              ),
                              Row(
                                children: [
                                  Checkbox(
                                    checkColor: Colors.white,
                                    activeColor: Colors.green,
                                    value: cartPageController.isCheckedPromocao,
                                    onChanged: (bool? value) {
                                      setState(() {
                                        cartPageController.isCheckedPromocao =
                                            value!;
                                      });
                                    },
                                  ),
                                  Text(
                                    AppLocalizations.of(context)!.text_discount,
                                    style:
                                        Theme.of(context).textTheme.headline6,
                                  ),
                                ],
                              ),
                              Container(
                                child: cartPageController.isCheckedPromocao ==
                                        true
                                    ? Column(
                                        children: [
                                          Align(
                                            alignment: Alignment.topLeft,
                                            child: Text(
                                              AppLocalizations.of(context)!
                                                  .subtitle_code_discount,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .headline2,
                                            ),
                                          ),
                                          SizedBox(
                                            height: Get.height * 0.005,
                                          ),
                                          TextFormField(
                                            controller:
                                                cartPageController.input_codigo,
                                            style: Theme.of(context)
                                                .textTheme
                                                .headline4,
                                            decoration: InputDecoration(
                                              filled: true,
                                              fillColor: Theme.of(context)
                                                  .backgroundColor,
                                              border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(15.0),
                                                borderSide: const BorderSide(),
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
                                  AppLocalizations.of(context)!
                                      .subtitle_add_information,
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
                                  controller: cartPageController.input_info,
                                  keyboardType: TextInputType.text,
                                  style: Theme.of(context).textTheme.headline4,
                                  decoration: InputDecoration(
                                    filled: true,
                                    fillColor:
                                        Theme.of(context).backgroundColor,
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15.0),
                                      borderSide: const BorderSide(),
                                    ),
                                    hintText: AppLocalizations.of(context)!
                                        .hint_write,
                                    hintStyle:
                                        Theme.of(context).textTheme.headline4,
                                  ),
                                ),
                              ),
                              SizedBox(height: Get.height * 0.03),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
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
                onPressed: () async {
                  openLoadingStateDialog(context);
                  var result = await cartPageController.validateAndSave();
                  Navigator.pop(context);
                  if (result.success) {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => WebViewPage(
                            sub: fullControllerController.island.value),
                      ),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text(
                        result.errorMessage!,
                        style: Theme.of(context).textTheme.labelSmall,
                      ),
                      backgroundColor: Theme.of(context).errorColor,
                    ));
                  }
                },
                child: Text(
                  AppLocalizations.of(context)!.subtitle_payment + " >",
                  style: const TextStyle(
                      fontFamily: AppFonts.poppinsRegularFont,
                      color: AppColors.greenColor),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
