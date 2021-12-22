import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:manda_bai/Controller/request.dart';
import 'package:manda_bai/Controller/static_config.dart';
import 'package:manda_bai/Core/app_colors.dart';
import 'package:manda_bai/Core/app_fonts.dart';
import 'package:manda_bai/Core/app_images.dart';
import 'package:manda_bai/UI/home/pop_up/pop_up_message.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
  final input_country = TextEditingController();
  final input_city = TextEditingController();

  bool statePassword = true;
  bool statePasswordconf = true;
  bool checkPassword = true, alterado = false, loading = false;
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
          if (input_city.text != user.city) {
            user.city = input_city.text;
          }
          if (input_country.text != user.country) {
            user.country = input_country.text;
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
        if (input_city.text != user.city) {
          user.city = input_city.text;
        }
        if (input_country.text != user.country) {
          user.country = input_country.text;
        }
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
        setState(() {
          loading = true;
        });
        bool check = await ServiceRequest.updateAccount();
        if (check) {
          setState(() {
            loading = false;
          });
          return showDialog(
              context: context,
              builder: (BuildContext context) {
                return Pop_up_Message(
                    mensagem:
                        AppLocalizations.of(context)!.message_success_update,
                    icon: Icons.check,
                    caminho: "atualizar");
              });
        } else {
          setState(() {
            loading = false;
          });
          return showDialog(
              context: context,
              builder: (BuildContext context) {
                return Pop_up_Message(
                    mensagem:
                        AppLocalizations.of(context)!.message_update_failed,
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
    input_country.text = user.country;
    input_city.text = user.city;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
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
                  height: Get.height * 0.05,
                ),
                Padding(
                  padding: EdgeInsets.only(
                    left: Get.width * 0.05,
                    right: Get.width * 0.05,
                  ),
                  child: Form(
                    key: _formKey,
                    child: SizedBox(
                      height: Get.height * 0.7,
                      child: ListView(
                        children: [
                          Column(
                            children: [
                              TextFormField(
                                controller: input_nome,
                                obscureText: false,
                                style: Theme.of(context).textTheme.headline4,
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Theme.of(context).backgroundColor,
                                  border: OutlineInputBorder(
                                    borderRadius:
                                        new BorderRadius.circular(15.0),
                                    borderSide: new BorderSide(),
                                  ),
                                  prefixIcon: Padding(
                                    padding: EdgeInsets.all(0.0),
                                    child: Icon(
                                      Icons.person,
                                      color: Colors.grey,
                                    ), // icon is 48px widget.
                                  ),
                                  labelText: AppLocalizations.of(context)!
                                      .textfield_name,
                                  labelStyle:
                                      Theme.of(context).textTheme.headline4,
                                ),
                                validator: (value) => value!.isEmpty
                                    ? AppLocalizations.of(context)!
                                        .validator_name
                                    : null,
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
                                    borderRadius:
                                        new BorderRadius.circular(15.0),
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
                                  labelStyle:
                                      Theme.of(context).textTheme.headline4,
                                ),
                                validator: (value) =>
                                    EmailValidator.validate(value!)
                                        ? null
                                        : AppLocalizations.of(context)!
                                            .validator_email,
                              ),
                              SizedBox(height: Get.height * 0.01),
                              TextFormField(
                                controller: input_city,
                                autocorrect: false,
                                obscureText: false,
                                style: Theme.of(context).textTheme.headline4,
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Theme.of(context).backgroundColor,
                                  border: OutlineInputBorder(
                                    borderRadius:
                                        new BorderRadius.circular(15.0),
                                    borderSide: new BorderSide(),
                                  ),
                                  prefixIcon: Padding(
                                    padding: EdgeInsets.all(0.0),
                                    child: Icon(
                                      Icons.location_on,
                                      color: Colors.grey,
                                    ), // icon is 48px widget.
                                  ),
                                  labelText: AppLocalizations.of(context)!
                                      .textfield_city,
                                  labelStyle:
                                      Theme.of(context).textTheme.headline4,
                                ),
                                validator: (value) => value!.isEmpty
                                    ? AppLocalizations.of(context)!
                                        .validator_city
                                    : null,
                              ),
                              SizedBox(height: Get.height * 0.01),
                              TextFormField(
                                controller: input_country,
                                autocorrect: false,
                                obscureText: false,
                                style: Theme.of(context).textTheme.headline4,
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Theme.of(context).backgroundColor,
                                  border: OutlineInputBorder(
                                    borderRadius:
                                        new BorderRadius.circular(15.0),
                                    borderSide: new BorderSide(),
                                  ),
                                  prefixIcon: Padding(
                                    padding: EdgeInsets.all(0.0),
                                    child: Icon(
                                      Icons.location_on,
                                      color: Colors.grey,
                                    ), // icon is 48px widget.
                                  ),
                                  labelText: AppLocalizations.of(context)!
                                      .textfield_country,
                                  labelStyle:
                                      Theme.of(context).textTheme.headline4,
                                ),
                                validator: (value) => value!.isEmpty
                                    ? AppLocalizations.of(context)!
                                        .validator_country
                                    : null,
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
                                    borderRadius:
                                        new BorderRadius.circular(15.0),
                                    borderSide: new BorderSide(),
                                  ),
                                  prefixIcon: Padding(
                                    padding: EdgeInsets.all(0.0),
                                    child: Icon(
                                      Icons.phone,
                                      color: Colors.grey,
                                    ), // icon is 48px widget.
                                  ),
                                  labelText: AppLocalizations.of(context)!
                                      .textfield_phone_number,
                                  labelStyle:
                                      Theme.of(context).textTheme.headline4,
                                ),
                                validator: (value) => value!.isEmpty
                                    ? AppLocalizations.of(context)!
                                        .validator_number
                                    : null,
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
                                    borderRadius:
                                        new BorderRadius.circular(15.0),
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
                                  labelText: AppLocalizations.of(context)!
                                      .textfield_password,
                                  labelStyle:
                                      Theme.of(context).textTheme.headline4,
                                ),
                                validator: (value) => value!.isEmpty
                                    ? AppLocalizations.of(context)!
                                        .validator_password
                                    : null,
                              ),
                              SizedBox(height: Get.height * 0.01),
                              TextFormField(
                                controller: input_senha_conf,
                                obscureText: statePasswordconf,
                                style: Theme.of(context).textTheme.headline4,
                                decoration: InputDecoration(
                                  errorText: checkPassword == false
                                      ? AppLocalizations.of(context)!
                                          .message_error_text
                                      : null,
                                  filled: true,
                                  fillColor: Theme.of(context).backgroundColor,
                                  border: OutlineInputBorder(
                                    borderRadius:
                                        new BorderRadius.circular(15.0),
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
                                  labelText: AppLocalizations.of(context)!
                                      .label_confirm_password,
                                  labelStyle:
                                      Theme.of(context).textTheme.headline4,
                                ),
                                validator: (value) => value!.isEmpty
                                    ? AppLocalizations.of(context)!
                                        .validator_empty_field
                                    : null,
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
                                      offset: Offset(2.0,
                                          2.0), // changes position of shadow
                                    ),
                                  ],
                                ),
                                child: TextButton(
                                  child: Text(
                                    AppLocalizations.of(context)!.button_update,
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
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            child: loading
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
        ],
      ),
    );
  }
}
