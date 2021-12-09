import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:get/get.dart';
import 'package:manda_bai/Core/app_colors.dart';
import 'package:manda_bai/Core/app_fonts.dart';
import 'package:manda_bai/Core/app_images.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactPage extends StatefulWidget {
  const ContactPage({Key? key}) : super(key: key);

  @override
  _ContactPageState createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  openwhatsapp() async {
    var whatsapp = "+2389149439";
    var whatsappURl_android =
        "whatsapp://send?phone=" + whatsapp + "&text=Hello";
    var whatappURL_ios = "https://wa.me/$whatsapp?text=${Uri.parse("hello")}";

    if (await canLaunch(whatsappURl_android)) {
      await launch(whatsappURl_android);
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: new Text("whatsapp no installed")));
    }
  }

  Future<void> send() async {
    final Email email = Email(
      body: 'Ola, Em que posso te ajudar?',
      subject: 'Preciso da Ajuda',
      recipients: ['mandabai2020@gmail.com'],
    );

    String platformResponse;

    try {
      await FlutterEmailSender.send(email);
      platformResponse = 'success';
    } catch (error) {
      platformResponse = error.toString();
    }
  }

  final input_nome = TextEditingController();
  final input_email = TextEditingController();
  final input_assunto = TextEditingController();
  final input_mensagem = TextEditingController();
  final input_info = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: Get.height * 0.08),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  child: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(
                      Icons.arrow_back,
                    ),
                    alignment: Alignment.centerRight,
                  ),
                ),
                Text(
                  'Fale Connosco',
                  style: Theme.of(context).textTheme.headline1,
                ),
                Container(
                  width: Get.width * 0.08,
                ),
              ],
            ),
            SizedBox(height: Get.height * 0.06),
            Padding(
              padding: EdgeInsets.only(
                  left: Get.width * 0.03, right: Get.width * 0.03),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Pode nos contatar pelo seu Email ou pelo seu WhatsApp e assim que um de nossos colaboradores visualizar sua mensagem irá te responder.\nDesde já agradecemos sua visita e pode contar conosco para tirar qualquer dúvida referente ao uso do aplicativo, envio de encomendas, preços e etc.",
                    style: Theme.of(context).textTheme.headline3,
                  ),
                  SizedBox(height: Get.height * 0.018),
                  Text(
                    "Estamos ao seu dispor!",
                    style: Theme.of(context)
                        .textTheme
                        .headline5!
                        .copyWith(fontSize: Get.width * 0.05),
                  ),
                ],
              ),
            ),
            SizedBox(height: Get.height * 0.05),
            Column(
              children: [
                Container(
                  height: Get.height * 0.07,
                  width: Get.width * 0.7,
                  decoration: BoxDecoration(
                    color: AppColors.greenColor,
                    borderRadius: BorderRadius.all(
                      Radius.circular(15),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Theme.of(context).cardColor,
                        blurRadius: 2.0,
                        spreadRadius: 0.0,
                        offset: Offset(2.0, 2.0), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: TextButton(
                      onPressed: () {
                        send();
                      },
                      child: Row(
                        children: [
                          Flexible(
                            flex: 1,
                            child: Icon(
                              Icons.email,
                              color: Theme.of(context).backgroundColor,
                            ),
                          ),
                          Flexible(
                            flex: 3,
                            child: Align(
                              alignment: Alignment.center,
                              child: Text(
                                'Conversar pelo Email',
                                style: TextStyle(
                                    fontFamily: AppFonts.poppinsBoldFont,
                                    fontSize: Get.width * 0.035,
                                    color: Colors.white),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(height: Get.height * 0.02),
                Container(
                  height: Get.height * 0.07,
                  width: Get.width * 0.7,
                  decoration: BoxDecoration(
                    color: AppColors.greenColor,
                    borderRadius: BorderRadius.all(
                      Radius.circular(15),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Theme.of(context).cardColor,
                        blurRadius: 4.0,
                        spreadRadius: 0.0,
                        offset: Offset(2.0, 2.0), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: TextButton(
                      onPressed: () {
                        openwhatsapp();
                      },
                      child: Row(
                        children: [
                          Flexible(
                            flex: 1,
                            child: Image.asset(
                              AppImages.whatsapp,
                              color: Colors.white,
                              height: Get.height * 0.08,
                              width: Get.width * 0.08,
                            ),
                          ),
                          Flexible(
                            flex: 4,
                            child: Align(
                              alignment: Alignment.center,
                              child: Text(
                                'Conversar pelo WhatsApp',
                                style: TextStyle(
                                    fontFamily: AppFonts.poppinsBoldFont,
                                    fontSize: Get.width * 0.035,
                                    color: Colors.white),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
