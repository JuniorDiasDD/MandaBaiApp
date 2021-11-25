import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:manda_bai/Controller/static_config.dart';
import 'package:manda_bai/Core/app_colors.dart';
import 'package:manda_bai/Core/app_fonts.dart';
import 'package:manda_bai/Core/app_images.dart';
import 'package:manda_bai/Model/user.dart';
import 'package:manda_bai/UI/Favorite/page/favorite_page.dart';
import 'package:manda_bai/UI/about/pages/info_page.dart';
import 'package:manda_bai/UI/account/pages/edit_profile.dart';
import 'package:manda_bai/UI/home/components/header.dart';
import 'package:manda_bai/UI/home/components/menu.dart';

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
    user = new User(
        name: "Júnior",
        telefone: "9123456",
        email: "junior@gmail.com",
        senha: "12344",
        username: "junior39");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // backgroundColor: Colors.white,
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
            Image.asset(
              AppImages.icone_user,
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
            SizedBox(height: Get.height * 0.05),
            Padding(
              padding: EdgeInsets.only(
                left: Get.width * 0.05,
                right: Get.width * 0.05,
              ),
              child: Column(
                children: [
                  Container(
                    height: Get.height * 0.06,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(
                        Radius.circular(8),
                      ),
                      border: Border.all(
                        color: Colors.black38,
                      ),
                    ),
                    child: TextButton(
                      child: Row(
                        children: [
                          Icon(
                            Icons.edit,
                            color: AppColors.greenColor,
                            size: Get.height * 0.035,
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
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => EditPorfilePage(),
                          ),
                        );
                      },
                    ),
                  ),
                  SizedBox(height: Get.height * 0.01),
                  Container(
                    height: Get.height * 0.06,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(
                        Radius.circular(8),
                      ),
                      border: Border.all(
                        color: Colors.black38,
                      ),
                    ),
                    child: TextButton(
                      child: Row(
                        children: [
                          Icon(
                            Icons.favorite,
                            color: AppColors.greenColor,
                            size: Get.height * 0.035,
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                              left: Get.width * 0.02,
                            ),
                            child: Text(
                              'Favorito',
                              style: TextStyle(
                                fontFamily: AppFonts.poppinsRegularFont,
                                color: Colors.black,
                                fontSize: Get.height * 0.018,
                              ),
                            ),
                          ),
                        ],
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => FavoritePage(),
                          ),
                        );
                      },
                    ),
                  ),
                  SizedBox(height: Get.height * 0.01),
                  Container(
                    height: Get.height * 0.06,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(
                        Radius.circular(8),
                      ),
                      border: Border.all(
                        color: Colors.black38,
                      ),
                    ),
                    child: TextButton(
                      child: Row(
                        children: [
                          Icon(
                            Icons.logout,
                            color: AppColors.greenColor,
                            size: Get.height * 0.035,
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
                      onPressed: () {
                        Navigator.of(context).pushNamedAndRemoveUntil(
                            '/login', (Route<dynamic> route) => false);
                      },
                    ),
                  ),
                  SizedBox(height: Get.height * 0.01),
                  Row(
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
                  SizedBox(height: Get.height * 0.01),
                  Container(
                    height: Get.height * 0.06,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(
                        Radius.circular(8),
                      ),
                      border: Border.all(
                        color: Colors.black38,
                      ),
                    ),
                    child: TextButton(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(
                              left: Get.width * 0.02,
                            ),
                            child: Text(
                              'Mudar de ilha',
                              style: TextStyle(
                                fontFamily: AppFonts.poppinsRegularFont,
                                color: Colors.black,
                                fontSize: Get.height * 0.018,
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                              right: Get.width * 0.02,
                            ),
                            child: Text(
                              'Santiago  >',
                              style: TextStyle(
                                fontFamily: AppFonts.poppinsRegularFont,
                                color: Colors.black,
                                fontSize: Get.height * 0.018,
                              ),
                            ),
                          ),
                        ],
                      ),
                      onPressed: () {},
                    ),
                  ),
                  SizedBox(height: Get.height * 0.01),
                  Container(
                    height: Get.height * 0.06,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(
                        Radius.circular(8),
                      ),
                      border: Border.all(
                        color: Colors.black38,
                      ),
                    ),
                    child: TextButton(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(
                              left: Get.width * 0.02,
                            ),
                            child: Text(
                              'Mudar de idioma',
                              style: TextStyle(
                                fontFamily: AppFonts.poppinsRegularFont,
                                color: Colors.black,
                                fontSize: Get.height * 0.018,
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                              right: Get.width * 0.02,
                            ),
                            child: Text(
                              'pt  >',
                              style: TextStyle(
                                fontFamily: AppFonts.poppinsRegularFont,
                                color: Colors.black,
                                fontSize: Get.height * 0.018,
                              ),
                            ),
                          ),
                        ],
                      ),
                      onPressed: () {},
                    ),
                  ),
                  SizedBox(height: Get.height * 0.01),
                  Container(
                    height: Get.height * 0.06,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(
                        Radius.circular(8),
                      ),
                      border: Border.all(
                        color: Colors.black38,
                      ),
                    ),
                    child: TextButton(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
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
                          Padding(
                            padding: EdgeInsets.only(
                              right: Get.width * 0.02,
                            ),
                            child: Text(
                              'USD  >',
                              style: TextStyle(
                                fontFamily: AppFonts.poppinsRegularFont,
                                color: Colors.black,
                                fontSize: Get.height * 0.018,
                              ),
                            ),
                          ),
                        ],
                      ),
                      onPressed: () {},
                    ),
                  ),
                  SizedBox(height: Get.height * 0.01),
                  Row(
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
                  SizedBox(height: Get.height * 0.01),
                  Container(
                    height: Get.height * 0.06,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(
                        Radius.circular(8),
                      ),
                      border: Border.all(
                        color: Colors.black38,
                      ),
                    ),
                    child: TextButton(
                      child: Row(
                        children: [
                          Icon(
                            Icons.info,
                            color: AppColors.greenColor,
                            size: Get.height * 0.035,
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
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => InfoPage(),
                          ),
                        );
                      },
                    ),
                  ),
                  SizedBox(height: Get.height * 0.01),
                  Container(
                    height: Get.height * 0.06,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(
                        Radius.circular(8),
                      ),
                      border: Border.all(
                        color: Colors.black38,
                      ),
                    ),
                    child: TextButton(
                      child: Row(
                        children: [
                          Icon(
                            Icons.phone,
                            color: AppColors.greenColor,
                            size: Get.height * 0.035,
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                              left: Get.width * 0.02,
                            ),
                            child: Text(
                              'Contactos',
                              style: TextStyle(
                                fontFamily: AppFonts.poppinsRegularFont,
                                color: Colors.black,
                                fontSize: Get.height * 0.018,
                              ),
                            ),
                          ),
                        ],
                      ),
                      onPressed: () {},
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: Get.height * 0.03),
          ],
        ),
      ),
    );
  }
}
