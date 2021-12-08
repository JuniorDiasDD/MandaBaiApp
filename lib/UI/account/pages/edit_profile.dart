import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:manda_bai/Controller/mandaBaiController.dart';
import 'package:manda_bai/Controller/static_config.dart';
import 'package:manda_bai/Core/app_colors.dart';
import 'package:manda_bai/Core/app_fonts.dart';

class EditPorfilePage extends StatefulWidget {
  @override
  _EditPorfilePageState createState() => _EditPorfilePageState();
}

class _EditPorfilePageState extends State<EditPorfilePage> {
   final MandaBaiController mandaBaiController = Get.find();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final input_email = TextEditingController();
  final input_numero = TextEditingController();
  final input_senha = TextEditingController();
  final input_senha_conf = TextEditingController();
  final input_nome = TextEditingController();
  bool checkPassword = true;
  Future<void> validateAndSave() async {
    final FormState? form = _formKey.currentState;
    if (form!.validate()) {
      if (input_senha.text != mandaBaiController.user.value.senha) {
        if (input_senha == input_senha_conf) {
          mandaBaiController.user.value.Senha = input_senha.text;
          if (input_email.text != mandaBaiController.user.value.email) {
            mandaBaiController.user.value.Email = input_email.text;
          }
          if (input_nome.text != mandaBaiController.user.value.name) {
            mandaBaiController.user.value.Name = input_nome.text;
          }
          if (input_numero.text != mandaBaiController.user.value.telefone) {
            mandaBaiController.user.value.Telefone = input_numero.text;
          }
          setState(() {
            checkPassword = true;
          });
        } else {
          setState(() {
            checkPassword = false;
          });
        }
      } else {
        setState(() {
          checkPassword = true;
        });
        if (input_email.text != mandaBaiController.user.value.email) {
          mandaBaiController.user.value.Email = input_email.text;
        }
        if (input_nome.text != mandaBaiController.user.value.name) {
          mandaBaiController.user.value.Name = input_nome.text;
        }
        if (input_numero.text !=mandaBaiController.user.value.telefone) {
         mandaBaiController.user.value.Telefone = input_numero.text;
        }
      }
      if (checkPassword == true) {
        Navigator.pop(context);
      }
      print('Form is valid');
    } else {
      print('Form is invalid');
    }
  }

  @override
  void initState() {
    super.initState();
    input_email.text = mandaBaiController.user.value.email!;
    input_numero.text = mandaBaiController.user.value.telefone!;
    input_senha.text =mandaBaiController.user.value.senha!;
    input_senha_conf.text = mandaBaiController.user.value.senha!;
    input_nome.text = mandaBaiController.user.value.name!;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.only(top: Get.height * 0.05),
              width: Get.width,
              child: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(Icons.arrow_back),
                alignment: Alignment.topLeft,
              ),
            ),
            Image.network(
              mandaBaiController.user.value.avatar!,
              width: Get.width * 0.2,
              alignment: Alignment.center,
            ),
            SizedBox(
              height: Get.height * 0.1,
            ),
            Padding(
              padding: EdgeInsets.only(
                left: Get.width * 0.05,
                right: Get.width * 0.05,
              ),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: input_nome,
                      obscureText: false,
                      style: Theme.of(context).textTheme.headline4,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Theme.of(context).backgroundColor,
                        border: OutlineInputBorder(
                          borderRadius: new BorderRadius.circular(15.0),
                          borderSide: new BorderSide(),
                        ),
                        prefixIcon: Padding(
                          padding: EdgeInsets.all(0.0),
                          child: Icon(
                            Icons.person,
                            color: Colors.grey,
                          ), // icon is 48px widget.
                        ),
                        labelText: 'Nome',
                        labelStyle: Theme.of(context).textTheme.headline4,
                      ),
                      validator: (value) =>
                          value!.isEmpty ? 'Insira o Nome' : null,
                    ),
                    SizedBox(height: Get.height * 0.01),
                    TextFormField(
                      controller: input_email,
                      obscureText: false,
                      style: Theme.of(context).textTheme.headline4,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Theme.of(context).backgroundColor,
                        border: OutlineInputBorder(
                          borderRadius: new BorderRadius.circular(15.0),
                          borderSide: new BorderSide(),
                        ),
                        prefixIcon: Padding(
                          padding: EdgeInsets.all(0.0),
                          child: Icon(
                            Icons.email,
                            color: Colors.grey,
                          ), // icon is 48px widget.
                        ),
                        labelText: 'Email',
                        labelStyle: Theme.of(context).textTheme.headline4,
                      ),
                      validator: (value) =>
                          value!.isEmpty ? 'Insira o email' : null,
                    ),
                    SizedBox(height: Get.height * 0.01),
                    TextFormField(
                      keyboardType: TextInputType.phone,
                      controller: input_numero,
                      autocorrect: false,
                      obscureText: false,
                      style: Theme.of(context).textTheme.headline4,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Theme.of(context).backgroundColor,
                        border: OutlineInputBorder(
                          borderRadius: new BorderRadius.circular(15.0),
                          borderSide: new BorderSide(),
                        ),
                        prefixIcon: Padding(
                          padding: EdgeInsets.all(0.0),
                          child: Icon(
                            Icons.phone,
                            color: Colors.grey,
                          ), // icon is 48px widget.
                        ),
                        labelText: 'Telefone',
                        labelStyle: Theme.of(context).textTheme.headline4,
                      ),
                      validator: (value) =>
                          value!.isEmpty ? 'Insira o Número' : null,
                    ),
                    SizedBox(height: Get.height * 0.01),
                    TextFormField(
                      controller: input_senha,
                      obscureText: true,
                      style: Theme.of(context).textTheme.headline4,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Theme.of(context).backgroundColor,
                        border: OutlineInputBorder(
                          borderRadius: new BorderRadius.circular(15.0),
                          borderSide: new BorderSide(),
                        ),
                        prefixIcon: Padding(
                          padding: EdgeInsets.all(0.0),
                          child: Icon(
                            Icons.lock,
                            color: Colors.grey,
                          ), // icon is 48px widget.
                        ),
                        labelText: 'Palavra-passe',
                        labelStyle: Theme.of(context).textTheme.headline4,
                      ),
                      validator: (value) =>
                          value!.isEmpty ? 'Insira a senha' : null,
                    ),
                    SizedBox(height: Get.height * 0.01),
                    TextFormField(
                      controller: input_senha_conf,
                      obscureText: true,
                      style: Theme.of(context).textTheme.headline4,
                      decoration: InputDecoration(
                        errorText: checkPassword == false
                            ? 'Senha não corresponde'
                            : null,
                        filled: true,
                        fillColor: Theme.of(context).backgroundColor,
                        border: OutlineInputBorder(
                          borderRadius: new BorderRadius.circular(15.0),
                          borderSide: new BorderSide(),
                        ),
                        prefixIcon: Padding(
                          padding: EdgeInsets.all(0.0),
                          child: Icon(
                            Icons.lock,
                            color: Colors.grey,
                          ), // icon is 48px widget.
                        ),
                        labelText: 'Palavra-passe confirmar',
                        labelStyle: Theme.of(context).textTheme.headline4,
                      ),
                      validator: (value) =>
                          value!.isEmpty ? 'Campo vazio' : null,
                    ),
                    SizedBox(
                      height: Get.height * 0.02,
                    ),
                    Container(
                      height: Get.height * 0.07,
                      width: Get.width,
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
                            offset:
                                Offset(2.0, 2.0), // changes position of shadow
                          ),
                        ],
                      ),
                      child: TextButton(
                        child: Text(
                          'Atualizar',
                          style: TextStyle(
                              fontFamily: AppFonts.poppinsRegularFont,
                              fontSize: Get.width * 0.035,
                              color: Colors.white),
                        ),
                        onPressed: validateAndSave,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
