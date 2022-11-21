import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:manda_bai/Core/app_colors.dart';
import 'package:manda_bai/Core/app_images.dart';
import 'package:manda_bai/UI/home/components/item_category.dart';
import 'package:manda_bai/UI/home/pop_up/pop_login.dart';
import 'package:manda_bai/UI/widget/Empty.dart';
import 'package:manda_bai/UI/widget/Search.dart';
import 'package:manda_bai/constants/controllers.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:websafe_svg/websafe_svg.dart';
import '../../home/pop_up/popup_message_internet.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Categories extends StatefulWidget {
  const Categories({Key? key}) : super(key: key);

  @override
  State<Categories> createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
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
      //  print(_connectionStatus.toString());
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
    initConnectivity();
    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
    super.initState();
  }

  @override
  void dispose() {
    _connectivitySubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding:const EdgeInsets.only(left: 16.0,right: 16.0,top: 8.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      child:Text('< '+AppLocalizations.of(context)!.all_categories,
                      style: Theme.of(context).textTheme.headline3,),
                      onPressed: (){
                        Navigator.pop(context);
                      },
                    ),
                    GestureDetector(
                      onTap: () async {
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
                          Navigator.pushNamed(context, '/cart');
                        }
                      },
                      child: Container(
                        width: Get.width * 0.1,
                        height: Get.width * 0.1,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          color: AppColors.grey50.withOpacity(0.8),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(6.0),
                          child: WebsafeSvg.asset(
                              AppImages.iconMenuCartOutline),
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(
                      left: Get.width * 0.03, right: Get.width * 0.03,top: 8,bottom: 8),
                  child: Search(
                    textHint: AppLocalizations.of(context)!.search,
                    function: () {},
                  ),
                ),

                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                   AppLocalizations.of(context)!.best_product,
                    style: Theme.of(context).textTheme.headline3,
                  ),
                ),
                FutureBuilder(
                  future: categoryController.carregarCategory(),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    switch (snapshot.connectionState) {
                      case ConnectionState.waiting:
                        return SizedBox(
                          height: Get.height * 0.2,
                          width: Get.width,
                          child: Center(
                            child: SizedBox(
                                width: 32,
                                height: 32,
                                child: CircularProgressIndicator(
                                  color: Theme.of(context).primaryColor,
                                  strokeWidth: 2,
                                )),
                          ),
                        );
                      default:
                        if (snapshot.data == null) {
                          return const Empty();
                        } else {
                          return  SizedBox(
                            height: Get.height * 0.8,
                            child: ListView.builder(
                              padding: EdgeInsets.only(
                                top: 0.0,
                                bottom: Get.height * 0.03,
                              ),
                              scrollDirection: Axis.vertical,
                              itemCount: snapshot.data.length,
                              itemBuilder: (BuildContext context, index) {
                                var list = categoryController.listCategory[index];
                                return ListViewItemComponent(category: list);
                              },
                            ),
                          );
                        }
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
