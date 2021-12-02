import 'package:flutter/material.dart';
import 'package:flutter_session/flutter_session.dart';
import 'package:get/get.dart';
import 'package:manda_bai/Controller/request.dart';
import 'package:manda_bai/Controller/static_config.dart';
import 'package:manda_bai/Core/app_images.dart';
import 'package:manda_bai/UI/about/pages/info_page.dart';
import 'package:manda_bai/UI/account/pages/edit_profile.dart';
import 'package:manda_bai/UI/home/components/carrega_saldo.dart';
import 'package:manda_bai/UI/home/pop_up/popup_island.dart';
import 'package:manda_bai/UI/home/pop_up/popup_moeda.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _StartPageState createState() => _StartPageState();
}

class _StartPageState extends State<ProfilePage> {
  String check = "";
  
  String island = "";
  String money="";
  String language="";
  Future _carregarIsland() async {
    island = await FlutterSession().get('island');
    return island;
  }
  Future _carregarMoney() async {
    money = await FlutterSession().get('money');
    return money;
  }
  Future _carregarLanguage() async {
    language = await FlutterSession().get('language');
    return language;
  }

  Future _carregarUser() async {
    bool check = await ServiceRequest.GetUser();

    if (check == false) {
      return null;
    }
    return check;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        return new Future(() => false);
      },
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(
              left: Get.width * 0.05,
              right: Get.width * 0.05,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: Get.height * 0.1),
                FutureBuilder(
                  future: _carregarUser(),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (!snapshot.hasData) {
                      return Container(
                        height: Get.height * 0.1,
                        width: Get.width,
                        child: Center(
                          child: Image.asset(
                            AppImages.loading,
                            width: Get.width * 0.1,
                            height: Get.height * 0.1,
                            alignment: Alignment.center,
                          ),
                        ),
                      );
                    } else {
                      return Column(
                        children: [
                          Image.network(
                            user.avatar,
                            width: Get.width * 0.2,
                            alignment: Alignment.center,
                          ),
                          SizedBox(height: Get.height * 0.03),
                          Text(
                            user.name,
                            style: Theme.of(context).textTheme.headline2,
                          ),
                          Text(
                            user.email,
                            style: Theme.of(context).textTheme.headline4,
                          ),
                        ],
                      );
                    }
                  },
                ),
                SizedBox(height: Get.height * 0.05),
                Container(
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
                            borderRadius: const BorderRadius.all(
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
                            style: Theme.of(context).textTheme.headline3,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: Get.height * 0.01),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: SizedBox(
                        width: Get.width * 0.1,
                        child: const Divider(
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
                        "Outros Serviços",
                        style: Theme.of(context).textTheme.headline4,
                      ),
                    ),
                    Expanded(
                      child: SizedBox(
                        width: Get.width * 0.4,
                        child: const Divider(
                          height: 36,
                        ),
                      ),
                    ),
                  ],
                ),
                Container(
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
                            borderRadius: const BorderRadius.all(
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
                            style: Theme.of(context).textTheme.headline3,
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
                            color: Colors.deepPurpleAccent,
                            borderRadius: const BorderRadius.all(
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
                            style: Theme.of(context).textTheme.headline3,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: SizedBox(
                        width: Get.width * 0.1,
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
                        "Configurações",
                        style: Theme.of(context).textTheme.headline4,
                      ),
                    ),
                    Expanded(
                      child: SizedBox(
                        width: Get.width * 0.4,
                        child: const Divider(
                          height: 36,
                        ),
                      ),
                    ),
                  ],
                ),
                Column(
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
                                borderRadius: const BorderRadius.all(
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
                              child: Row(
                                children: [
                                  Text(
                                    'Mudar de ILha',
                                    style:
                                        Theme.of(context).textTheme.headline3,
                                  ),
                                  FutureBuilder(
                                      future: _carregarIsland(),
                                      builder: (BuildContext context,
                                          AsyncSnapshot snapshot) {
                                        if (snapshot.data == null) {
                                          return const Text(" ");
                                        } else {
                                          return Text(
                                            ' (' + island + ')',
                                            style: Theme.of(context)
                                                .textTheme
                                                .headline3,
                                          );
                                        }
                                      }),
                                ],
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
                                borderRadius: const BorderRadius.all(
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
                              child: Row(
                                children: [
                                  Text(
                                    'Mudar de Idioma',
                                    style: Theme.of(context).textTheme.headline3,
                                  ),
                                    FutureBuilder(
                                      future: _carregarLanguage(),
                                      builder: (BuildContext context,
                                          AsyncSnapshot snapshot) {
                                        if (snapshot.data == null) {
                                          return const Text(" ");
                                        } else {
                                          return Text(
                                            ' (' + language + ')',
                                            style: Theme.of(context)
                                                .textTheme
                                                .headline3,
                                          );
                                        }
                                      }),
                                ],
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
                        onTap: () {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return const Popup_Moeda();
                              });
                        },
                        child: Row(
                          children: [
                            Container(
                              height: Get.height * 0.042,
                              width: Get.height * 0.042,
                              decoration: BoxDecoration(
                                color: Colors.lightGreen,
                                borderRadius: const BorderRadius.all(
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
                              child: Row(
                                children: [
                                  Text(
                                    'Selecionar Moeda',
                                    style: Theme.of(context).textTheme.headline3,
                                  ),
                                   FutureBuilder(
                                      future: _carregarMoney(),
                                      builder: (BuildContext context,
                                          AsyncSnapshot snapshot) {
                                        if (snapshot.data == null) {
                                          return const Text(" ");
                                        } else {
                                          return Text(
                                            ' (' + money + ')',
                                            style: Theme.of(context)
                                                .textTheme
                                                .headline3,
                                          );
                                        }
                                      }),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: SizedBox(
                            width: Get.width * 0.1,
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
                            "Informações",
                            style: Theme.of(context).textTheme.headline4,
                          ),
                        ),
                        Expanded(
                          child: SizedBox(
                            width: Get.width * 0.4,
                            child: const Divider(
                              height: 36,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: Get.height * 0.01),
                    Container(
                      height: Get.height * 0.06,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => InfoPage(),
                            ),
                          );
                        },
                        child: Row(
                          children: [
                            Container(
                              height: Get.height * 0.042,
                              width: Get.height * 0.042,
                              decoration: BoxDecoration(
                                color: Colors.deepPurpleAccent,
                                borderRadius: const BorderRadius.all(
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
                                style: Theme.of(context).textTheme.headline3,
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
                                borderRadius: const BorderRadius.all(
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
                                style: Theme.of(context).textTheme.headline3,
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
                                borderRadius: const BorderRadius.all(
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
                                style: Theme.of(context).textTheme.headline3,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: Get.height * 0.03),
              ],
            ),
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
