import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:manda_bai/Core/app_colors.dart';

class RecoveryPassword extends StatefulWidget {
  const RecoveryPassword({Key? key}) : super(key: key);

  @override
  _RecoveryPasswordState createState() => _RecoveryPasswordState();
}

class _RecoveryPasswordState extends State<RecoveryPassword> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        child: AppBar(
          title: const Text(
            'Esquece sua Senha',
            style: TextStyle(color: Colors.black),
          ),
          backgroundColor: Colors.transparent,
          centerTitle: true,
        ),
        preferredSize: Size.fromHeight(Get.height * 0.1),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(9.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.only(top: 35.0),
                height: Get.height * 0.25,
                child: const Text(
                  'Por favor, digite seu e-mail registrado ou seu numero de telefone para redefinir sua senha ',
                ),
              ),
              const Text(
                'E-mail ou número de telefone',
                textAlign: TextAlign.left,
              ),
              Container(
                height: Get.height * 0.07,
                width: Get.width,
                child: TextField(
                  obscureText: false,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(35),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                          width: 1, color: AppColors.greenColor),
                      borderRadius: BorderRadius.circular(35),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: Get.height * 0.05,
              ),
              Container(
                height: Get.height * 0.07,
                width: Get.width,
                child: FlatButton(
                  padding: EdgeInsets.only(
                    left: Get.width * 0.05,
                    right: Get.height * 0.05,
                  ),
                  color: AppColors.greenColor,
                  textColor: Colors.white,
                  child: const Text('Enviar'),
                  onPressed: () {},
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
