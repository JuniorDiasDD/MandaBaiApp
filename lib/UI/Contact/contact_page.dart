import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:manda_bai/Core/app_colors.dart';
import 'package:manda_bai/Core/app_fonts.dart';

class ContactPage extends StatefulWidget {
  const ContactPage({Key? key}) : super(key: key);

  @override
  _ContactPageState createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
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
          //mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
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
                  width: Get.width * 0.1,
                ),
              ],
            ),
            SizedBox(height: Get.height * 0.06),
            Padding(
              padding: EdgeInsets.only(left: Get.width * 0.04),
              child: Text(
                "Poderá nos contatar via o seu E-mail ou pelo seu WhatsApp.",
                style: Theme.of(context).textTheme.headline2,
              ),
            ),
            SizedBox(height: Get.height * 0.03),
            Padding(
              padding: EdgeInsets.only(
                  left: Get.width * 0.04, right: Get.width * 0.04),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: Get.width,
                    height: Get.height * 0.06,
                    child: TextFormField(
                      controller: input_nome,
                      style: Theme.of(context).textTheme.headline4,
                      decoration: InputDecoration(
                        labelText: "Nome",
                        labelStyle: Theme.of(context).textTheme.headline4,
                        filled: true,
                        fillColor: Theme.of(context).backgroundColor,
                        border: OutlineInputBorder(
                          borderRadius: new BorderRadius.circular(10.0),
                          borderSide:
                              new BorderSide(color: Colors.red, width: 2.0),
                        ),
                      ),
                      validator: (value) =>
                          value!.isEmpty ? 'Insira o nome' : null,
                    ),
                  ),
                  SizedBox(height: Get.height * 0.01),
                  SizedBox(
                    width: Get.width,
                    height: Get.height * 0.06,
                    child: TextFormField(
                      controller: input_email,
                      style: Theme.of(context).textTheme.headline4,
                      decoration: InputDecoration(
                        labelText: "Email",
                        labelStyle: Theme.of(context).textTheme.headline4,
                        filled: true,
                        fillColor: Theme.of(context).backgroundColor,
                        border: OutlineInputBorder(
                          borderRadius: new BorderRadius.circular(10.0),
                          borderSide: new BorderSide(),
                        ),
                      ),
                      validator: (value) =>
                          value!.isEmpty ? 'Insira o email' : null,
                    ),
                  ),
                  SizedBox(height: Get.height * 0.01),
                  SizedBox(
                    width: Get.width,
                    height: Get.height * 0.06,
                    child: TextFormField(
                      controller: input_assunto,
                      style: Theme.of(context).textTheme.headline4,
                      decoration: InputDecoration(
                        labelText: "Assunto",
                        labelStyle: Theme.of(context).textTheme.headline4,
                        filled: true,
                        fillColor: Theme.of(context).backgroundColor,
                        border: OutlineInputBorder(
                          borderRadius: new BorderRadius.circular(10.0),
                          borderSide: new BorderSide(),
                        ),
                      ),
                      validator: (value) =>
                          value!.isEmpty ? 'Insira o Assunto' : null,
                    ),
                  ),
                  SizedBox(height: Get.height * 0.01),
                  Container(
                    height: Get.height * 0.2,
                    width: Get.width,
                    child: TextField(
                      maxLines: 10,
                      controller: input_info,
                      keyboardType: TextInputType.text,
                      style: Theme.of(context).textTheme.headline4,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Theme.of(context).backgroundColor,
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide:
                              BorderSide(width: 2, color: Colors.black54),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(width: 2, color: Colors.black54),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        hintText: 'escrever...',
                        hintStyle: Theme.of(context).textTheme.headline4,
                        labelStyle: Theme.of(context).textTheme.headline4,
                      ),
                    ),
                  ),
                  SizedBox(height: Get.height * 0.035),
                  Container(
                    height: Get.height * 0.07,
                    width: Get.width * 0.7,
                    decoration:  BoxDecoration(
                      color: AppColors.greenColor,
                      borderRadius: BorderRadius.all(
                        Radius.circular(35),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Theme.of(context).cardColor,
                          blurRadius: 2.0,
                          spreadRadius: 0.0,
                          offset:
                              Offset(2.0, 2.0), // changes position of shadow
                        ),
                      ],
                    ),
                    child: TextButton(
                      child: Text(
                        'Enviar Mensagem',
                        style: TextStyle(
                            fontFamily: AppFonts.poppinsBoldFont,
                            fontSize: Get.width * 0.035,
                            color: Colors.white),
                      ),
                      onPressed: () {},
                    ),
                  ),
                  SizedBox(height: Get.height * 0.02),
                  Container(
                    height: Get.height * 0.07,
                    width: Get.width * 0.7,
                    decoration:  BoxDecoration(
                      color: AppColors.greenColor,
                      borderRadius: BorderRadius.all(
                        Radius.circular(35),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Theme.of(context).cardColor,
                          blurRadius: 4.0,
                          spreadRadius: 0.0,
                          offset:
                              Offset(2.0, 2.0), // changes position of shadow
                        ),
                      ],
                    ),
                    child: TextButton(
                      child: Text(
                        'Conversar pelo WhatsApp',
                        style: TextStyle(
                            fontFamily: AppFonts.poppinsBoldFont,
                            fontSize: Get.width * 0.035,
                            color: Colors.white),
                      ),
                      onPressed: () {},
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
