import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:manda_bai/Core/app_colors.dart';
import 'package:manda_bai/Core/app_fonts.dart';
import 'package:manda_bai/UI/home/pages/home_page.dart';

class Pop_up_Message extends StatefulWidget {
  String mensagem;
  String caminho;
  IconData icon;
  Pop_up_Message(
      {Key? key,
      required this.mensagem,
      required this.icon,
      required this.caminho})
      : super(key: key);

  @override
  _Pop_up_MessageState createState() => _Pop_up_MessageState();
}

class _Pop_up_MessageState extends State<Pop_up_Message> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
        child: Container(
          width: Get.width,
          height: Get.height * 0.25,
          margin:
              EdgeInsets.only(left: Get.width * 0.15, right: Get.width * 0.15),
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
                  child: widget.caminho == "erro_encomenda"
                      ? Icon(
                          widget.icon,
                          color: Colors.yellow,
                          size: Get.height * 0.09,
                        )
                      : Icon(
                          widget.icon,
                          color: widget.caminho != "erro"
                              ? Colors.green
                              : Colors.red,
                          size: Get.height * 0.09,
                        ),
                ),

                Padding(
                  padding: const EdgeInsets.only(
                    left: 10.0,
                    right: 10.0,
                  ),
                  child: Text(
                    widget.mensagem,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headline4,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left:15.0,right: 15.0,top:10.0),
                  child: Container(
                    height: Get.height * 0.05,
                    width: Get.width,
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
                          if (widget.caminho == "home") {
                            Navigator.pushReplacementNamed(context, '/home');
                          } else if (widget.caminho == "erro" ||
                              widget.caminho == "description" ||
                              widget.caminho == "addCarrinho"||widget.caminho == "pedido") {
                            Navigator.pop(context);
                          } else if (widget.caminho == "atualizar") {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => HomePage(index: 3)));
                          } else if (widget.caminho == "encomenda") {
                            Navigator.of(context).pushNamedAndRemoveUntil(
                                '/home', (Route<dynamic> route) => false);
                          } else if (widget.caminho == "registo") {
                            Navigator.pushReplacementNamed(context, '/login');
                          } else if (widget.caminho == "erro_encomenda") {

                          }
                        }),
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
