import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:manda_bai/Controller/request.dart';
import 'package:manda_bai/Core/app_images.dart';
import 'package:manda_bai/UI/authention/pages/set_password_page.dart';
import 'package:manda_bai/UI/home/pop_up/pop_up_message.dart';
import 'package:manda_bai/UI/home/pop_up/popup_message_internet.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ValidateCode extends StatefulWidget {
  String email;
  ValidateCode({Key? key, required this.email}) : super(key: key);

  @override
  _ValidateCodeState createState() => _ValidateCodeState();
}

class _ValidateCodeState extends State<ValidateCode> {
  late Timer _timer;

  int _minuto=15,_segundo=59;
  void startTimer() {
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSec,
          (Timer timer) {
        if (_minuto == 0 && _segundo==0) {
          setState(() {
            timer.cancel();
          });
        } else if(_segundo==0) {
          setState(() {
            _minuto--;
            _segundo=59;
          });
        }else{
          setState(() {
            _segundo--;
          });
        }
      },
    );
  }
  Future<void> newPassword() async {
    setState(() {
      loading=true;
    });
    var check = await ServiceRequest.resetPassword(widget.email);
    if(check){

      setState(() {
        loading=false;
        _minuto=15;
        _segundo=59;
        startTimer();
        input_code.text="";
      });
    }else{
      setState(() {
        loading=false;
      });
    }
  }
  ConnectivityResult _connectionStatus = ConnectivityResult.none;
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;

  int net = 0;

  Future<void> initConnectivity() async {
    late ConnectivityResult result;
    try {
      result = await _connectivity.checkConnectivity();
    } on PlatformException catch (e) {
      print('Couldn\'t check connectivity status' + e.toString());
      return;
    }

    if (!mounted) {
      return Future.value(null);
    }
    return _updateConnectionStatus(result);
  }

  Future<void> _updateConnectionStatus(ConnectivityResult result) async {
    setState(() {
      _connectionStatus = result;
      print(_connectionStatus.toString());
      if (_connectionStatus == ConnectivityResult.none) {
        net = 1;
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return PopupMessageInternet(
                  mensagem: AppLocalizations.of(context)!.message_erro_internet,
                  icon: Icons.signal_wifi_off);
            });
      } else {
        if (net != 0) {
          Navigator.pop(context);
        }
      }
    });
  }

  @override
  void initState() {
    super.initState();
    initConnectivity();
    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
    startTimer();
  }

  @override
  void dispose() {
    _connectivitySubscription.cancel();
    _timer.cancel();
    super.dispose();
  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final input_code = TextEditingController();
  bool loading = false;
  Future<void> validateAndSave() async {
    final FormState? form = _formKey.currentState;
    if (form!.validate()) {
      setState(() {
        loading = true;
      });
      var check = await ServiceRequest.validateCodePassword(
          widget.email, input_code.text);
      if (check) {
        setState(() {
          loading = false;
        });
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                SetPasswordPage(
                    email: widget.email,code:input_code.text),
          ),
        );
      } else {
        setState(() {
          loading = false;
        });
        input_code.text="";
        return showDialog(
            context: context,
            builder: (BuildContext context) {
              return Pop_up_Message(
                  mensagem: AppLocalizations.of(context)!
                      .message_erro_email_set_password,
                  icon: Icons.error,
                  caminho: "erro");
            });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Stack(
                children: [

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(top: 33.0),
                        child: IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: const Icon(
                            Icons.arrow_back,
                            color: Colors.black,
                          ),
                          alignment: Alignment.topLeft,
                        ),
                      ),
                      const Spacer(),
                    ],
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(
                  left: Get.width * 0.05,
                  right: Get.height * 0.05,
                ),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: 33.0),
                        child: Text(
                          AppLocalizations.of(context)!.title_validate_code,
                          style: Theme.of(context).textTheme.headline1,
                        ),
                      ),
                      SizedBox(height: Get.height * 0.02),
                      Text(
                        AppLocalizations.of(context)!
                                .descriction_validate_code +
                            ": " +
                            widget.email,
                        style: Theme.of(context).textTheme.headline4,
                      ),
                      SizedBox(height: Get.height * 0.01),
                      TextButton(onPressed: (){
                        if(_segundo==0 && _minuto==0){
                          newPassword();
                        }

                        }, child:Align(
                        alignment:Alignment.topLeft,
                          child: Text(
                          AppLocalizations.of(context)!.reenviar_code,
                          style: _minuto==0 && _segundo==0? Theme.of(context).textTheme.headline5 : Theme.of(context).textTheme.headline4,
                      ),
                        ),),

                      Row(
                        children: [
                         const Icon(
                            Icons.access_time,
                            color: Colors.grey,
                          ),
                         const SizedBox(width: 5,),
                          Text(
                           "$_minuto:$_segundo",
                            style: Theme.of(context).textTheme.headline4,
                          ),
                        ],
                      ),
                      SizedBox(height: Get.height * 0.02),
                      SizedBox(height: Get.height * 0.01),
                      Padding(
                        padding: EdgeInsets.only(
                          left: Get.width * 0.2,
                          right: Get.width * 0.2,
                        ),
                        child: TextFormField(
                          obscureText: false,
                          controller: input_code,
                          style: Theme.of(context).textTheme.headline4!.copyWith(fontSize: Get.height*0.04),
                          keyboardType: TextInputType.number,
                          textAlign: TextAlign.center,
                          maxLength: 4,
                          validator: (value) => value!.isEmpty
                              ? AppLocalizations.of(context)!
                                  .validator_validate_code
                              : null,
                          onChanged: (value){
                            if(value.length==4){
                              validateAndSave();
                            }
                          },
                        ),
                      ),
                      SizedBox(
                        height: Get.height * 0.05,
                      ),
                     /* Container(
                        height: Get.height * 0.07,
                        width: Get.width,
                        child: FlatButton(
                          padding: EdgeInsets.only(
                            left: Get.width * 0.05,
                            right: Get.height * 0.05,
                          ),
                          color: AppColors.greenColor,
                          textColor: Colors.white,
                          child: Text(AppLocalizations.of(context)!
                              .button_validate_code),
                          onPressed: () => validateAndSave(),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                        ),
                      ),*/
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
      ]),
    );
  }
}
