import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:manda_bai/Controller/cart_controller.dart';
import 'package:manda_bai/Controller/request.dart';
import 'package:manda_bai/Core/app_colors.dart';
import 'package:manda_bai/Core/app_fonts.dart';
import 'package:manda_bai/Core/app_images.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class WebViewPage extends StatefulWidget {
  String sub;
   WebViewPage({Key? key,required this.sub}) : super(key: key);

  @override
  _WebViewPageState createState() => _WebViewPageState();
}

class _WebViewPageState extends State<WebViewPage> {
  final CartPageController cartPageController = Get.find();

  checkPagamento() async {
    cartPageController.loading = true;
  
    var response =
        await ServiceRequest.getOrderIdStatus(cartPageController.order);
    if (null != response) {
      switch (response.toString()) {
        case "pending":
          {
            cartPageController.loading = false;
            await popup(
                AppLocalizations.of(context)!.message_error_order_pending,
                Icons.money_off,
                "erro");
            Navigator.of(context).pop();
            break;
          }
        case "failed":
          {
            cartPageController.loading = false;
            await popup(
                AppLocalizations.of(context)!.message_error_order_failed,
                Icons.error_outline_rounded,
                "erro");
            Navigator.of(context).pop();
            break;
          }
        case "cancelled":
          {
            cartPageController.loading = false;
            await popup(
                AppLocalizations.of(context)!.message_error_order_cancelled,
                Icons.cancel_outlined,
                "erro");
            Navigator.of(context).pop();
            break;
          }
        case "processing":
          {
            List<String> list_item = [];
            for (int i = 0; i < cartPageController.list.length; i++) {
              list_item.add(cartPageController.list[i].item_key);
            }
            await ServiceRequest.removeCart(list_item);
            cartPageController.loading = false;
            await popup(AppLocalizations.of(context)!.message_success_order,
                Icons.check, "encomenda");
            Navigator.of(context).pop();
            break;
          }
        default:
          cartPageController.loading = false;
          Navigator.of(context).pop();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        return new Future(() => false);
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).primaryColor,
          leading: IconButton(
            icon: Icon(Icons.close, color: Colors.black),
            onPressed: () => checkPagamento(),
          ),
          title: Text("Fechar Pagamento"),
        ),
        body: Stack(
          children: [
            WebView(
              initialUrl:
                  "https://mandabai.herokuapp.com/site/checkout?order=" +
                      cartPageController.order+"&sub="+widget.sub,
              onWebViewCreated: (controller) {
                // _controller = controller;
              },
              javascriptMode: JavascriptMode.unrestricted,
              gestureNavigationEnabled: false,

              /* navigationDelegate: (NavigationRequest request) {
                  print(request.url);
                  if (request.url == 'http://destination.com/') {
                    setState(() {
                      print("entrour");
                    });
                    // do not navigate
                    return NavigationDecision.prevent;
                  }

                  return NavigationDecision.navigate;
                }*/
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
      ),
    );
  }

  popup(mensagem, icon, caminho) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return Scaffold(
            backgroundColor: Colors.transparent,
            body: Center(
              child: Container(
                width: Get.width,
                height: Get.height * 0.3,
                margin: EdgeInsets.only(
                    left: Get.width * 0.12, right: Get.width * 0.12),
                decoration: BoxDecoration(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Icon(
                          icon,
                          color: caminho != "erro" ? Colors.green : Colors.red,
                          size: Get.height * 0.09,
                        ),
                      ),
                      SizedBox(height: Get.height * 0.01),
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 10.0,
                          right: 10.0,
                        ),
                        child: Text(
                          mensagem,
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.headline4,
                        ),
                      ),
                      SizedBox(height: Get.height * 0.02),
                      Container(
                        height: Get.height * 0.06,
                        width: Get.width * 0.3,
                        decoration: BoxDecoration(
                          color: AppColors.greenColor,
                          borderRadius: const BorderRadius.all(
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
                              'OK',
                              style: TextStyle(
                                  fontFamily: AppFonts.poppinsBoldFont,
                                  fontSize: Get.width * 0.035,
                                  color: Colors.white),
                            ),
                            onPressed: () {
                              if (caminho == "encomenda") {
                                Navigator.of(context).pushNamedAndRemoveUntil(
                                    '/home', (Route<dynamic> route) => false);
                              } else if (caminho == "erro") {
                                Navigator.pop(context);
                              }
                            }),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }
}
