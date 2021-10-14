import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:manda_bai/Core/app_colors.dart';
import 'package:manda_bai/Core/app_fonts.dart';
import 'package:manda_bai/Core/app_images.dart';
import 'package:manda_bai/UI/Favorite/page/favorite_page.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _StartPageState createState() => _StartPageState();
}

class _StartPageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: Get.height * 0.08),
            Image.asset(
              AppImages.icone_user,
              width: Get.width * 0.3,
              height: Get.height * 0.3,
              alignment: Alignment.center,
            ),
            SizedBox(height: Get.height * 0.01),
            Text(
              "Alberto Duarte",
              style: TextStyle(
                fontFamily: AppFonts.poppinsBoldFont,
                fontSize: 14,
              ),
            ),
            Text(
              "alberto@gmail.com",
              style: TextStyle(
                fontFamily: AppFonts.poppinsRegularFont,
                fontSize: 12,
              ),
            ),
            SizedBox(height: Get.height * 0.05),
            Container(
              height: Get.height * 0.06,
              margin: EdgeInsets.only(
                left: Get.width * 0.05,
                right: Get.width * 0.05,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(2),
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
                onPressed: () {},
              ),
            ),
            SizedBox(height: Get.height * 0.01),
            Container(
              height: Get.height * 0.06,
              margin: EdgeInsets.only(
                left: Get.width * 0.05,
                right: Get.width * 0.05,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(2),
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
              margin: EdgeInsets.only(
                left: Get.width * 0.05,
                right: Get.width * 0.05,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(2),
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
                onPressed: () {},
              ),
            ),
            SizedBox(height: Get.height * 0.01),
            Container(
              height: Get.height * 0.06,
              margin: EdgeInsets.only(
                left: Get.width * 0.05,
                right: Get.width * 0.05,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(2),
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
                        'Sobre Aplicação',
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
            SizedBox(height: Get.height * 0.03),
            Container(
              height: Get.height * 0.001,
              color: Colors.black38,
              margin: EdgeInsets.only(
                left: Get.width * 0.05,
                right: Get.width * 0.05,
              ),
            ),
            SizedBox(height: Get.height * 0.03),
            Container(
              height: Get.height * 0.06,
              margin: EdgeInsets.only(
                left: Get.width * 0.05,
                right: Get.width * 0.05,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(2),
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
              margin: EdgeInsets.only(
                left: Get.width * 0.05,
                right: Get.width * 0.05,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(2),
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
              margin: EdgeInsets.only(
                left: Get.width * 0.05,
                right: Get.width * 0.05,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(2),
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
          ],
        ),
      ),
    );
  }
}
