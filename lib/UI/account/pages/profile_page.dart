import 'package:flutter/material.dart';
import 'package:flutter_session/flutter_session.dart';
import 'package:get/get.dart';
import 'package:manda_bai/Controller/request.dart';
import 'package:manda_bai/Controller/static_config.dart';
import 'package:manda_bai/Core/app_colors.dart';
import 'package:manda_bai/Core/app_fonts.dart';
import 'package:manda_bai/Core/app_images.dart';
import 'package:manda_bai/Model/user.dart';
import 'package:manda_bai/UI/Favorite/page/favorite_page.dart';
import 'package:manda_bai/UI/about/pages/info_page.dart';
import 'package:manda_bai/UI/account/pages/edit_profile.dart';
import 'package:manda_bai/UI/home/components/carrega_saldo.dart';
import 'package:manda_bai/UI/home/components/header.dart';
import 'package:manda_bai/UI/home/components/menu.dart';
import 'package:manda_bai/UI/home/pop_up/popup_island.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _StartPageState createState() => _StartPageState();
}

class _StartPageState extends State<ProfilePage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  Future _carregarUser() async {
    bool check = await ServiceRequest.GetUser();
    if (check == false) {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        return new Future(() => false);
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "Minha Conta",
            style: TextStyle(
              fontFamily: AppFonts.poppinsRegularFont,
            ),
          ),
        ),
        drawer: Menu(),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: Get.height * 0.03),
              FutureBuilder(
                future: _carregarUser(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (ConnectionState.waiting == true) {
                    return Container(
                      child: Text(
                        "Loading...",
                      ),
                    );
                  } else {
                    return Column(
                      children: [
                        Image.network(
                          user.avatar,
                          width: Get.width * 0.2,
                          // height: Get.height * 0.2,
                          alignment: Alignment.center,
                        ),
                        SizedBox(height: Get.height * 0.03),
                        Text(
                          user.name,
                          style: TextStyle(
                            fontFamily: AppFonts.poppinsBoldFont,
                            fontSize: 14,
                          ),
                        ),
                        Text(
                          user.email,
                          style: TextStyle(
                            fontFamily: AppFonts.poppinsRegularFont,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    );
                  }
                },
              ),
              SizedBox(height: Get.height * 0.05),
              Padding(
                padding: EdgeInsets.only(
                  left: Get.width * 0.05,
                  right: Get.width * 0.05,
                ),
                child: Container(
                  height: Get.height * 0.06,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => EditPorfilePage(),
                        ),
                      );
                    },
                    child: Row(
                      children: [
                        Container(
                          height: Get.height * 0.042,
                          width: Get.height * 0.042,
                          decoration: BoxDecoration(
                            color: Colors.teal,
                            borderRadius: BorderRadius.all(
                              Radius.circular(100),
                            ),
                            border: Border.all(color: Colors.teal),
                          ),
                          child: Icon(
                            Icons.edit,
                            color: Colors.white,
                            size: Get.height * 0.025,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            left: Get.width * 0.02,
                          ),
                          child: Text(
                            'Editar Perfil',
                            style: TextStyle(
                              fontFamily: AppFonts.poppinsRegularFont,
                              color: Colors.black,
                              fontSize: Get.height * 0.018,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: Get.height * 0.01),
              Padding(
                padding:  EdgeInsets.only(left: Get.width * 0.05,
                  right: Get.width * 0.05,),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: new Container(
                        width: Get.width * 0.1,
                        child: Divider(
                          color: Colors.black,
                          height: 36,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        left: Get.width * 0.05,
                        right: Get.width * 0.05,
                      ),
                      child: Text("Outros Serviços"),
                    ),
                    Expanded(
                      child: Container(
                        width: Get.width * 0.4,
                        child: const Divider(
                          color: Colors.black,
                          height: 36,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  left: Get.width * 0.05,
                  right: Get.width * 0.05,
                ),
                child: Container(
                  height: Get.height * 0.06,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Carrega_Saldo(),
                        ),
                      );
                    },
                    child: Row(
                      children: [
                        Container(
                          height: Get.height * 0.042,
                          width: Get.height * 0.042,
                          decoration: BoxDecoration(
                            color: Colors.lightBlueAccent,
                            borderRadius: BorderRadius.all(
                              Radius.circular(100),
                            ),
                            border: Border.all(color: Colors.lightBlueAccent),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Image.asset(
                              AppImages.cvmovel,
                            ),
                          ),
                        ),
                        SizedBox(height: Get.height * 0.01),
                        Padding(
                          padding: EdgeInsets.only(
                            left: Get.width * 0.02,
                          ),
                          child: Text(
                            'Saldo CvMóvel',
                            style: TextStyle(
                              fontFamily: AppFonts.poppinsRegularFont,
                              color: Colors.black,
                              fontSize: Get.height * 0.018,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: Get.height * 0.01),
              Padding(
                padding: EdgeInsets.only(
                  left: Get.width * 0.05,
                  right: Get.width * 0.05,
                ),
                child: Container(
                  height: Get.height * 0.06,
                  child: GestureDetector(
                    onTap: () {},
                    child: Row(
                      children: [
                        Container(
                          height: Get.height * 0.042,
                          width: Get.height * 0.042,
                          decoration: BoxDecoration(
                            color: Colors.deepPurpleAccent,
                            borderRadius: BorderRadius.all(
                              Radius.circular(100),
                            ),
                            border: Border.all(color: Colors.deepPurpleAccent),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Image.asset(
                              AppImages.camara,
                            ),
                          ),
                        ),
                        SizedBox(height: Get.height * 0.01),
                        Padding(
                          padding: EdgeInsets.only(
                            left: Get.width * 0.02,
                          ),
                          child: Text(
                            'Serviços da Câmara ',
                            style: TextStyle(
                              fontFamily: AppFonts.poppinsRegularFont,
                              color: Colors.black,
                              fontSize: Get.height * 0.018,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: Get.width * 0.05,
                  right: Get.width * 0.05,),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: new Container(
                        width: Get.width * 0.1,
                        child: Divider(
                          color: Colors.black,
                          height: 36,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        left: Get.width * 0.05,
                        right: Get.width * 0.05,
                      ),
                      child: Text("Configurações"),
                    ),
                    Expanded(
                      child: Container(
                        width: Get.width * 0.4,
                        child: const Divider(
                          color: Colors.black,
                          height: 36,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  left: Get.width * 0.05,
                  right: Get.width * 0.05,
                ),
                child: Column(
                  children: [
                    Container(
                      height: Get.height * 0.06,
                      child: GestureDetector(
                        onTap: () {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return Popup_Island();
                              });
                        },
                        child: Row(
                          children: [
                            Container(
                              height: Get.height * 0.042,
                              width: Get.height * 0.042,
                              decoration: BoxDecoration(
                                color: Colors.lightBlueAccent,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(100),
                                ),
                                border:
                                    Border.all(color: Colors.lightBlueAccent),
                              ),
                              child: Image.asset(
                                AppImages.santiago,
                                color: Colors.white,
                                height: Get.height * 0.1,
                                width: Get.width * 0.6,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                left: Get.width * 0.02,
                              ),
                              child: Text(
                                'Mudar de ILha',
                                style: TextStyle(
                                  fontFamily: AppFonts.poppinsRegularFont,
                                  color: Colors.black,
                                  fontSize: Get.height * 0.018,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: Get.height * 0.01),
                    Container(
                      height: Get.height * 0.06,
                      child: GestureDetector(
                        onTap: () {},
                        child: Row(
                          children: [
                            Container(
                              height: Get.height * 0.042,
                              width: Get.height * 0.042,
                              decoration: BoxDecoration(
                                color: Colors.orangeAccent,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(100),
                                ),
                                border: Border.all(color: Colors.orangeAccent),
                              ),
                              child: Icon(
                                Icons.language,
                                color: Colors.white,
                                size: Get.height * 0.025,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                left: Get.width * 0.02,
                              ),
                              child: Text(
                                'Mudar de Idioma',
                                style: TextStyle(
                                  fontFamily: AppFonts.poppinsRegularFont,
                                  color: Colors.black,
                                  fontSize: Get.height * 0.018,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: Get.height * 0.01),
                    Container(
                      height: Get.height * 0.06,
                      child: GestureDetector(
                        onTap: () {},
                        child: Row(
                          children: [
                            Container(
                              height: Get.height * 0.042,
                              width: Get.height * 0.042,
                              decoration: BoxDecoration(
                                color: Colors.lightGreen,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(100),
                                ),
                                border: Border.all(color: Colors.lightGreen),
                              ),
                              child: Icon(
                                Icons.attach_money,
                                color: Colors.white,
                                size: Get.height * 0.025,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                left: Get.width * 0.02,
                              ),
                              child: Text(
                                'Selecionar Moeda',
                                style: TextStyle(
                                  fontFamily: AppFonts.poppinsRegularFont,
                                  color: Colors.black,
                                  fontSize: Get.height * 0.018,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding:EdgeInsets.only(left: Get.width * 0.05,
                        right: Get.width * 0.05,),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: new Container(
                              width: Get.width * 0.1,
                              child: Divider(
                                color: Colors.black,
                                height: 36,
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                              left: Get.width * 0.05,
                              right: Get.width * 0.05,
                            ),
                            child: Text("Informações"),
                          ),
                          Expanded(
                            child: Container(
                              width: Get.width * 0.4,
                              child: const Divider(
                                color: Colors.black,
                                height: 36,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: Get.height * 0.01),
                    Container(
                      height: Get.height * 0.06,
                      child: GestureDetector(
                        onTap: () {Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => InfoPage(),
                          ),
                        );},
                        child: Row(
                          children: [
                            Container(
                              height: Get.height * 0.042,
                              width: Get.height * 0.042,
                              decoration: BoxDecoration(
                                color: Colors.deepPurpleAccent,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(100),
                                ),
                                border:
                                    Border.all(color: Colors.deepPurpleAccent),
                              ),
                              child: Icon(
                                Icons.info,
                                color: Colors.white,
                                size: Get.height * 0.025,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                left: Get.width * 0.02,
                              ),
                              child: Text(
                                'Sobre Nós e Aplicação',
                                style: TextStyle(
                                  fontFamily: AppFonts.poppinsRegularFont,
                                  color: Colors.black,
                                  fontSize: Get.height * 0.018,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: Get.height * 0.01),
                    Container(
                      height: Get.height * 0.06,
                      child: GestureDetector(
                        onTap: () {},
                        child: Row(
                          children: [
                            Container(
                              height: Get.height * 0.042,
                              width: Get.height * 0.042,
                              decoration: BoxDecoration(
                                color: Colors.teal,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(100),
                                ),
                                border: Border.all(color: Colors.teal),
                              ),
                              child: Icon(
                                Icons.phone,
                                color: Colors.white,
                                size: Get.height * 0.025,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                left: Get.width * 0.02,
                              ),
                              child: Text(
                                'Contacto',
                                style: TextStyle(
                                  fontFamily: AppFonts.poppinsRegularFont,
                                  color: Colors.black,
                                  fontSize: Get.height * 0.018,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: Get.height * 0.01),
                    Container(
                      height: Get.height * 0.06,
                      child: GestureDetector(
                        onTap: () => _terminarSessao(),
                        child: Row(
                          children: [
                            Container(
                              height: Get.height * 0.042,
                              width: Get.height * 0.042,
                              decoration: BoxDecoration(
                                color: Colors.redAccent,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(100),
                                ),
                                border: Border.all(color: Colors.redAccent),
                              ),
                              child: Icon(
                                Icons.logout,
                                color: Colors.white,
                                size: Get.height * 0.025,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                left: Get.width * 0.02,
                              ),
                              child: Text(
                                'Terminar Sessão',
                                style: TextStyle(
                                  fontFamily: AppFonts.poppinsRegularFont,
                                  color: Colors.black,
                                  fontSize: Get.height * 0.018,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: Get.height * 0.03),
            ],
          ),
        ),
      ),
    );
  }

  _terminarSessao() async {
    var session = FlutterSession();
    await session.set('id', "null");
    Navigator.of(context)
        .pushNamedAndRemoveUntil('/login', (Route<dynamic> route) => false);
  }
}
