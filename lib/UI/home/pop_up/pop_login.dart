import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:manda_bai/Core/app_colors.dart';
import 'package:manda_bai/Core/app_fonts.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
class Pop_Login extends StatefulWidget {
  const Pop_Login({Key? key}) : super(key: key);
  @override
  _Pop_LoginState createState() => _Pop_LoginState();
}

class _Pop_LoginState extends State<Pop_Login> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
        child: Container(
          width: Get.width,
          height: Get.height * 0.23,
          margin:
              EdgeInsets.only(left: Get.width * 0.15, right: Get.width * 0.15),
          decoration: BoxDecoration(
                 color:Theme.of(context).scaffoldBackgroundColor,
            borderRadius: BorderRadius.circular(12),
          ),
          child: SingleChildScrollView(
            child: Column(

              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                        left: Get.width * 0.04,
                      ),
                      child: Container(
                        width: Get.width * 0.05,
                        height: Get.height * 0.04,
                        child: Icon(Icons.person,
                             size: Get.width * 0.06,color: Colors.black54,),
                      ),
                    ),
                    Text(
                      AppLocalizations.of(context)!.button_login,
                       style: Theme.of(context).textTheme.headline3,
                    ),
                    IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ],
                ),
                SizedBox(
                  height: Get.height*0.2,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                          left: Get.width * 0.05,
                          right: Get.width * 0.05,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Text(
                              AppLocalizations.of(context)!.message_login,
                              textAlign: TextAlign.center,
                              style: Theme.of(context).textTheme.headline4,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: Get.height * 0.01),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          height: Get.height * 0.05,
                          width: Get.width,
                          decoration:  BoxDecoration(
                            color: AppColors.greenColor,
                            borderRadius: BorderRadius.all(
                              Radius.circular(15),
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Theme.of(context).cardColor,
                                blurRadius: 2.0,
                                spreadRadius: 0.0,
                                offset: Offset(
                                    2.0, 2.0), // changes position of shadow
                              ),
                            ],
                          ),
                          child: TextButton(
                            child: Text(
                              AppLocalizations.of(context)!.button_login,
                              style: Theme.of(context).textTheme.headline4!.copyWith(color:Colors.white,),
                            ),
                            onPressed: () => Navigator.pushNamed(context, '/login'),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
