import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_pw_validator/Resource/Strings.dart';
import 'package:flutter_pw_validator/flutter_pw_validator.dart';
import 'package:get/get.dart';
import 'package:manda_bai/Controller/request.dart';
import 'package:manda_bai/Core/app_colors.dart';
import 'package:manda_bai/Core/app_fonts.dart';
import 'package:manda_bai/Core/app_images.dart';
import 'package:manda_bai/Model/user.dart';
import 'package:manda_bai/UI/home/pop_up/pop_up_message.dart';
import 'package:manda_bai/UI/intro/components/colored_circle_component.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);
  @override
  _RegisterPageState createState() => _RegisterPageState();
}
class _RegisterPageState extends State<RegisterPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final input_email = TextEditingController();
  final input_telefone = TextEditingController();
  final input_nickname = TextEditingController();
  final input_username = TextEditingController();
  final input_senha = TextEditingController();
  final input_nome = TextEditingController();
  final input_city = TextEditingController();
  final input_country = TextEditingController();
  String mensage_password = " ";
  Color cor_password = Colors.transparent;
  bool statePassword = false;
    bool loading = false;
  Future<void> validateAndSave() async {
    final FormState? form = _formKey.currentState;
    if (form!.validate()) {
      User new_user =  User(
          name: input_nome.text,
          telefone: input_telefone.text,
          email: input_email.text,
          senha: input_senha.text,
          username: input_username.text,
          nickname: input_nickname.text,
          avatar: "",
          city: input_city.text,
          country: input_country.text);
 setState(() {
        loading = true;
      });
      bool check = await ServiceRequest.createAccount(new_user);
      if (check == true) {
         setState(() {
        loading = false;
      });
        return showDialog(
            context: context,
            builder: (BuildContext context) {
              return Pop_up_Message(
                  mensagem: AppLocalizations.of(context)!.message_success_register,
                  icon: Icons.check,
                  caminho: "registo");
            });
      } else {
         setState(() {
        loading = false;
      });
        return showDialog(
            context: context,
            builder: (BuildContext context) {
              return Pop_up_Message(
                  mensagem: AppLocalizations.of(context)!.message_error_register,
                  icon: Icons.error,
                  caminho: "erro");
            });
      }
    } else {
      print('Form is invalid');
    }
  }
  _validar_password() {
    if (input_senha.text.length < 7) {
      setState(() {
        mensage_password = AppLocalizations.of(context)!.message_password_weak;
        cor_password = Colors.red;
      });
    } else if (RegExp(r'\d+\w*\d+').hasMatch(input_senha.text) &&
        !input_senha.text.contains(RegExp(r'[A-Z]'))) {
      setState(() {
        mensage_password = AppLocalizations.of(context)!.message_password_reasonable;
        cor_password = Colors.yellowAccent;
      });
    } else if (input_senha.text.contains(RegExp(r'[A-Z]'))) {
      setState(() {
        mensage_password = AppLocalizations.of(context)!.message_password_strong;
        cor_password = Colors.green;
      });
    }
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
                Stack(
                  children: [
                    Align(
                      alignment: Alignment.bottomLeft,
                      child: ColoredCircleComponent(),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 33.0),
                      width: Get.width,
                      child: IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Icon(Icons.arrow_back),
                        alignment: Alignment.topLeft,
                      ),
                    ),
                  ],
                ),
                Image.asset(
                  AppImages.appLogo2,
                  width: Get.width * 0.6,
                  height: Get.height * 0.1,
                ),
                SizedBox(
                  height: Get.height * 0.03,
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: Get.width * 0.43,
                              child: TextFormField(
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
                                  labelText: AppLocalizations.of(context)!.textfield_name,
                                  labelStyle: Theme.of(context).textTheme.headline4,
                                ),
                                validator: (value) =>
                                    value!.isEmpty ? AppLocalizations.of(context)!.validator_name : null,
                              ),
                            ),
                            SizedBox(
                              width: Get.width * 0.43,
                              child: TextFormField(
                                controller: input_nickname,
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
                                  labelText: AppLocalizations.of(context)!.textfield_nickname,
                                  labelStyle: Theme.of(context).textTheme.headline4,
                                ),
                                validator: (value) =>
                                    value!.isEmpty ? AppLocalizations.of(context)!.validator_nickname : null,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: Get.height * 0.01),
                         Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: Get.width * 0.43,
                              child: TextFormField(
                                controller: input_country,
                                style: Theme.of(context).textTheme.headline4,
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Theme.of(context).backgroundColor,
                                  border: OutlineInputBorder(
                                    borderRadius: new BorderRadius.circular(15.0),
                                    borderSide: new BorderSide(),
                                  ),
                                  labelText: AppLocalizations.of(context)!.textfield_country,
                                  labelStyle: Theme.of(context).textTheme.headline4,
                                ),
                                validator: (value) =>
                                    value!.isEmpty ? AppLocalizations.of(context)!.validator_country : null,
                              ),
                            ),
                            SizedBox(
                              width: Get.width * 0.43,
                              child: TextFormField(
                                controller: input_city,
                                style: Theme.of(context).textTheme.headline4,
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Theme.of(context).backgroundColor,
                                  border: OutlineInputBorder(
                                    borderRadius: new BorderRadius.circular(15.0),
                                    borderSide: new BorderSide(),
                                  ),
                                  labelText: AppLocalizations.of(context)!.textfield_city,
                                  labelStyle: Theme.of(context).textTheme.headline4,
                                ),
                                validator: (value) =>
                                    value!.isEmpty ? AppLocalizations.of(context)!.validator_city : null,
                              ),
                            ),
                          ],
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
                          validator: (value) => EmailValidator.validate(value!)
                              ? null
                              : AppLocalizations.of(context)!.validator_email,
                        ),
                        SizedBox(height: Get.height * 0.01),
                        TextFormField(
                          controller: input_telefone,
                          keyboardType: TextInputType.phone,
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
                            labelText: AppLocalizations.of(context)!.textfield_phone,
                            labelStyle: Theme.of(context).textTheme.headline4,
                          ),
                          validator: (value) =>
                              value!.length<7 ? AppLocalizations.of(context)!.validator_number : null,
                        ),
                        SizedBox(height: Get.height * 0.01),
                        TextFormField(
                          controller: input_username,
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
                            labelText: AppLocalizations.of(context)!.textfield_user,
                            labelStyle: Theme.of(context).textTheme.headline4,
                          ),
                          validator: (value) =>
                              value!.isEmpty ? AppLocalizations.of(context)!.validator_user : null,
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
                                  statePassword = !statePassword;
                                });
                              },
                              icon: Icon(
                                statePassword
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                              ),
                            ),
                            labelText: AppLocalizations.of(context)!.textfield_password,
                            labelStyle: Theme.of(context).textTheme.headline4,
                          ),
                          validator: (value) =>
                              value!.isEmpty ? AppLocalizations.of(context)!.validator_password : null,
                          onChanged: (value) => _validar_password(),
                        ),
                        SizedBox(height: Get.height * 0.005),
                        Align(
                          alignment:Alignment.topLeft,
                          child: Text(
                            mensage_password,
                            style: Theme.of(context)
                                .textTheme
                                .headline4!
                                .copyWith(color: cor_password),
                          ),
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
                              AppLocalizations.of(context)!.button_register,
                              style: TextStyle(
                                  fontFamily: AppFonts.poppinsRegularFont,
                                  fontSize: Get.width * 0.035,
                                  color: Colors.white),
                            ),
                            onPressed: validateAndSave,
                          ),
                        ),
                        SizedBox(height: Get.height * 0.02),
                      ],
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
                      child: Image.asset(
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


