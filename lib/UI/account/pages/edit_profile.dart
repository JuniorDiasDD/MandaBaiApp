import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:manda_bai/Controller/request.dart';
import 'package:manda_bai/Controller/static_config.dart';
import 'package:manda_bai/Core/app_colors.dart';
import 'package:manda_bai/Core/app_fonts.dart';
import 'package:manda_bai/Core/app_images.dart';
import 'package:manda_bai/UI/home/pop_up/pop_up_message.dart';
import 'package:email_validator/email_validator.dart';

class EditPorfilePage extends StatefulWidget {
  @override
  _EditPorfilePageState createState() => _EditPorfilePageState();
}

class _EditPorfilePageState extends State<EditPorfilePage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final input_email = TextEditingController();
  final input_numero = TextEditingController();
  final input_senha = TextEditingController();
  final input_senha_conf = TextEditingController();
  final input_nome = TextEditingController();
  bool statePassword = true;
  bool statePasswordconf = true;
  bool checkPassword = true, alterado = false;
  Future<void> validateAndSave() async {
    final FormState? form = _formKey.currentState;
    if (form!.validate()) {
      if (input_senha.text != user.senha) {
        if (input_senha == input_senha_conf) {
          alterado = true;
          user.senha = input_senha.text;
          if (input_email.text != user.email) {
            user.email = input_email.text;
          }
          if (input_nome.text != user.name) {
            user.name = input_nome.text;
          }
          if (input_numero.text != user.telefone) {
            user.telefone = input_numero.text;
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
        if (input_email.text != user.email) {
          user.email = input_email.text;
        }
        if (input_nome.text != user.name) {
          user.name = input_nome.text;
        }
        if (input_numero.text != user.telefone) {
          user.telefone = input_numero.text;
        }
      }
      if (checkPassword == true) {
        bool check = await ServiceRequest.updateAccount();
        if (check) {
          return showDialog(
              context: context,
              builder: (BuildContext context) {
                return Pop_up_Message(
                    mensagem: "Atualizado com sucesso",
                    icon: Icons.check,
                    caminho: "atualizar");
              });
        } else {
          return showDialog(
              context: context,
              builder: (BuildContext context) {
                return Pop_up_Message(
                    mensagem: "Falha na Atualização",
                    icon: Icons.error,
                    caminho: "erro");
              });
        }
      }
      // print('Form is valid');
    } else {
      print('Form is invalid');
    }
  }

  @override
  void initState() {
    super.initState();
    input_email.text = user.email;
    input_numero.text = user.telefone;
    input_senha.text = user.senha;
    input_senha_conf.text = user.senha;
    input_nome.text = user.name;
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
              user.avatar,
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
                      keyboardType: TextInputType.emailAddress,
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
                          EmailValidator.validate(value!) ? null:'Emial inváido',
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
                          value!.isEmpty ? 'Insira o Numero' : null,
                    ),
                    SizedBox(height: Get.height * 0.01),
                    TextFormField(
                      controller: input_senha,
                      obscureText: statePassword,
                      style: Theme.of(context).textTheme.headline4,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Theme.of(context).backgroundColor,
                        border: OutlineInputBorder(
                          borderRadius: new BorderRadius.circular(15.0),
                          borderSide: new BorderSide(),
                        ),
                        prefixIcon: const Padding(
                          padding: EdgeInsets.all(0.0),
                          child: Icon(
                            Icons.lock,
                            color: Colors.grey,
                          ), // icon is 48px widget.
                        ),
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              statePassword = !statePassword;
                            });
                          },
                          icon: Icon(
                            statePassword
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: Colors.grey,
                          ),
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
                      obscureText: statePasswordconf,
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
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              statePasswordconf = !statePasswordconf;
                            });
                          },
                          icon: Icon(
                            statePasswordconf
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: Colors.grey,
                          ),
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
