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

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final input_email = TextEditingController();
  final input_nickname = TextEditingController();
  final input_username = TextEditingController();
  final input_senha = TextEditingController();
  final input_nome = TextEditingController();
  final input_city = TextEditingController();
  final input_country = TextEditingController();
  bool statePassword = false;
  Future<void> validateAndSave() async {
    final FormState? form = _formKey.currentState;
    if (form!.validate()) {
      User new_user = new User(
          name: input_nome.text,
          telefone: "0",
          email: input_email.text,
          senha: input_senha.text,
          username: input_username.text,
          nickname: input_nickname.text,
          avatar: "",
          city: input_city.text,
          country: input_country.text);

      bool check = await ServiceRequest.createAccount(new_user);
      if (check == true) {
        return showDialog(
            context: context,
            builder: (BuildContext context) {
              return Pop_up_Message(
                  mensagem: "Registo feito com sucesso!",
                  icon: Icons.check,
                  caminho: "home");
            });
      } else {
        return showDialog(
            context: context,
            builder: (BuildContext context) {
              return Pop_up_Message(
                  mensagem: "Dados invalidos...",
                  icon: Icons.error,
                  caminho: "erro");
            });
      }
    } else {
      print('Form is invalid');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
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
                              labelText: 'Nome',
                              labelStyle: Theme.of(context).textTheme.headline4,
                            ),
                            validator: (value) =>
                                value!.isEmpty ? 'Insira o Nome' : null,
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
                              labelText: 'Apelido',
                              labelStyle: Theme.of(context).textTheme.headline4,
                            ),
                            validator: (value) =>
                                value!.isEmpty ? 'Insira o Apelido' : null,
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
                      validator: (value) =>
                          value!.isEmpty ? 'Insira o email' : null,
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
                        labelText: 'Utilizador',
                        labelStyle: Theme.of(context).textTheme.headline4,
                      ),
                      validator: (value) =>
                          value!.isEmpty ? 'Insira o Utilizador' : null,
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
                        labelText: 'Palavra-passe',
                        labelStyle: Theme.of(context).textTheme.headline4,
                      ),
                      validator: (value) =>
                          value!.isEmpty ? 'Insira a senha' : null,
                    ),
                    SizedBox(height: Get.height * 0.005),
                    FlutterPwValidator(
                      controller: input_senha,
                      minLength: 8,
                      uppercaseCharCount: 1,
                      numericCharCount: 2,
                      specialCharCount: 1,
                      width: 400,
                      height: 150,
                      //   strings:FrenchStrings(),
                      onSuccess: () {
                        print("Matched");
                        Scaffold.of(context).showSnackBar(new SnackBar(
                            content: new Text("Password is matched")));
                      },
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
                          'Registar',
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
    );
  }
}

class FrenchStrings implements FlutterPwValidatorStrings {
  @override
  final String atLeast = 'Au moins - caractères';
  @override
  final String uppercaseLetters = '- Lettres majuscules';
  @override
  final String numericCharacters = '- Chiffres';
  @override
  final String specialCharacters = '- Caractères spéciaux';
}
