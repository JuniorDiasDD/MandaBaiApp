import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:manda_bai/Controller/request.dart';
import 'package:manda_bai/Core/app_colors.dart';
import 'package:manda_bai/Core/app_fonts.dart';
import 'package:manda_bai/Core/app_images.dart';
import 'package:manda_bai/UI/authention/pages/recovery_password_page.dart';
import 'package:manda_bai/UI/home/pop_up/pop_up_message.dart';
import 'package:manda_bai/UI/intro/components/colored_circle_component.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _isLoggedIn = false;
  late GoogleSignInAccount _userObj;
  GoogleSignIn _googleSignIn = GoogleSignIn();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool statePassword = true;
  final input_username = TextEditingController();
  final input_senha = TextEditingController();
  bool loading = false;
  Future<void> validateAndSave() async {
    final FormState? form = _formKey.currentState;
    if (form!.validate()) {
      setState(() {
        loading = true;
      });
      var check =
          await ServiceRequest.login(input_username.text, input_senha.text);
      if (check == true) {
        setState(() {
          loading = false;
        });
        Navigator.pushReplacementNamed(context, '/home');
      } else {
        setState(() {
          loading = false;
        });
        return showDialog(
            context: context,
            builder: (BuildContext context) {
              return Pop_up_Message(
                  mensagem:
                      AppLocalizations.of(context)!.message_error_cridencials,
                  icon: Icons.error,
                  caminho: "erro");
            });
      }

      //print('Form is valid');
    } else {
      print('Form is invalid');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Stack(
                    children: [
                      Align(
                        alignment: Alignment.bottomLeft,
                        child: ColoredCircleComponent(),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: Get.height * 0.02,
                  ),
                  Image.asset(
                    AppImages.appLogoIcon,
                    width: Get.width * 0.6,
                    height: Get.height * 0.15,
                  ),
                  SizedBox(
                    height: Get.height * 0.06,
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
                              labelText:
                                  AppLocalizations.of(context)!.textfield_user,
                              labelStyle: Theme.of(context).textTheme.headline4,
                            ),
                            validator: (value) => value!.isEmpty
                                ? AppLocalizations.of(context)!.validator_user
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
                                      ? Icons.visibility_off
                                      : Icons.visibility,
                                ),
                              ),
                              labelText: AppLocalizations.of(context)!
                                  .textfield_password,
                              labelStyle: Theme.of(context).textTheme.headline4,
                            ),
                            validator: (value) => value!.isEmpty
                                ? AppLocalizations.of(context)!
                                    .validator_password
                                : null,
                          ),
                          Align(
                            alignment: Alignment.topLeft,
                            child: TextButton(
                              style: TextButton.styleFrom(
                                primary: Colors.black,
                                textStyle:
                                    TextStyle(fontSize: Get.width * 0.025),
                              ),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => RecoveryPassword()),
                                );
                              },
                              child: Text(
                                AppLocalizations.of(context)!
                                    .text_forgot_password,
                                style: Theme.of(context)
                                    .textTheme
                                    .headline4!
                                    .copyWith(fontStyle: FontStyle.italic),
                              ),
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
                                  offset: Offset(
                                      2.0, 2.0), // changes position of shadow
                                ),
                              ],
                            ),
                            child: TextButton(
                              child: Text(
                                AppLocalizations.of(context)!.button_login,
                                style: TextStyle(
                                    fontFamily: AppFonts.poppinsRegularFont,
                                    fontSize: Get.width * 0.035,
                                    color: Colors.white),
                              ),
                              onPressed: validateAndSave,
                            ),
                          ),
                          SizedBox(
                            height: Get.height * 0.01,
                          ),

                          /* SizedBox(
                            height: Get.height * 0.01,
                          ),
                          Column(
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  Expanded(
                                    child: new Container(
                                      width: Get.width * 0.4,
                                      child: Divider(
                                        height: 36,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                      left: Get.width * 0.05,
                                      right: Get.width * 0.05,
                                    ),
                                    child: Text(
                                      AppLocalizations.of(context)!.text_or,
                                      style:
                                          Theme.of(context).textTheme.headline2,
                                    ),
                                  ),
                                  Expanded(
                                    child: Container(
                                      width: Get.width * 0.4,
                                      child: const Divider(
                                        height: 36,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(
                            height: Get.height * 0.02,
                          ),*/
                          /* Column(
                            children: [
                              Container(
                                width: Get.width,
                                child: SignInButton(
                                  Buttons.Google,
                                  text: "Login com Google",
                                  onPressed: () {
                                    _googleSignIn.signIn().then((userData) {
                                      setState(() {
                                        _isLoggedIn = true;
                                        _userObj = userData!;
                                        print('--' + _userObj.email);
                                      });
                                    }).catchError((e) {
                                      print(e);
                                    });
                                  },
                                ),
                              ),
                              Container(
                                width: Get.width,
                                child: SignInButton(
                                  Buttons.Facebook,
                                  text: "Login com Facebook",
                                  onPressed: () {},
                                ),
                              ),
                            ],
                          ),*/
                        ],
                      ),
                    ),
                  ),
                ],
              ),
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
      bottomNavigationBar: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            AppLocalizations.of(context)!.text_dont_have_an_account,
            style: Theme.of(context).textTheme.headline4,
          ),
          TextButton(
            style: TextButton.styleFrom(
              primary: AppColors.greenColor,
              textStyle: TextStyle(fontSize: Get.width * 0.03),
            ),
            onPressed: () {
              Navigator.pushNamed(context, '/register');
            },
            child: Text(
              AppLocalizations.of(context)!.button_sign_up_now,
              style: TextStyle(
                decoration: TextDecoration.underline,
                fontStyle: FontStyle.italic,
                fontFamily: AppFonts.poppinsItalicFont,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
