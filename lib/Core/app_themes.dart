import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:manda_bai/Core/app_fonts.dart';

import 'app_colors.dart';

abstract class AppThemes {
  static final ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: AppColors.black_escuro,
    primaryColor: AppColors.greenColor,
    cardColor: AppColors.black_claro,
    indicatorColor: AppColors.white,
    dividerColor: AppColors.Dimgrey,
    dialogBackgroundColor: AppColors.black_claro,
    backgroundColor: AppColors.black_escuro,
    canvasColor: AppColors.black_claro,
    iconTheme: IconThemeData(color: AppColors.white),
    checkboxTheme: CheckboxThemeData(
      fillColor: MaterialStateColor.resolveWith((states) => AppColors.white),
    ),
     radioTheme: RadioThemeData(
      fillColor:
          MaterialStateColor.resolveWith((states) => AppColors.white),
    ),
    fontFamily: AppFonts.poppinsRegularFont,
    textTheme: TextTheme(
      headline1: TextStyle(
        fontFamily: AppFonts.poppinsBoldFont,
        fontSize: Get.width * 0.042,
        color: AppColors.white,
      ),
      headline2: TextStyle(
        fontFamily: AppFonts.poppinsBoldFont,
        fontSize: Get.width * 0.033,
        color: AppColors.white,
      ),
      headline3: TextStyle(
        fontFamily: AppFonts.poppinsRegularFont,
        fontSize: Get.width * 0.038,
        color: AppColors.white,
      ),
      headline4: TextStyle(
        fontFamily: AppFonts.poppinsRegularFont,
        fontSize: Get.width * 0.033,
        color: AppColors.white,
      ),
      headline5: TextStyle(
        fontFamily: AppFonts.poppinsBoldFont,
        fontSize: Get.width * 0.035,
        color: AppColors.greenColor,
      ),
      headline6: TextStyle(
        fontFamily: AppFonts.poppinsRegularFont,
        fontSize: Get.width * 0.03,
        color: AppColors.greenColor,
      ),
    ),
  );

  static final ThemeData lightTheme = ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: AppColors.white_50,
    primaryColor: AppColors.greenColor,
    cardColor: AppColors.Dimgrey,
    indicatorColor: AppColors.black_escuro,
    dividerColor: AppColors.black_claro,
    dialogBackgroundColor: AppColors.white,
    backgroundColor: AppColors.white,
    bottomAppBarColor: AppColors.white,
    canvasColor: AppColors.white,
    accentColor: AppColors.Dimgrey,
    iconTheme: IconThemeData(color: AppColors.black_escuro),
    checkboxTheme: CheckboxThemeData(
      fillColor:
          MaterialStateColor.resolveWith((states) => AppColors.black_claro),
    ),
    radioTheme: RadioThemeData(
      fillColor:
          MaterialStateColor.resolveWith((states) => AppColors.black_claro),
    ),
    fontFamily: AppFonts.poppinsRegularFont,
    textTheme: TextTheme(
      headline1: TextStyle(
        fontFamily: AppFonts.poppinsBoldFont,
        fontSize: Get.width * 0.042,
        color: AppColors.black_escuro,
      ),
      headline2: TextStyle(
        fontFamily: AppFonts.poppinsBoldFont,
        fontSize: Get.width * 0.03,
        color: AppColors.black_escuro,
      ),
      headline3: TextStyle(
        fontFamily: AppFonts.poppinsRegularFont,
        fontSize: Get.width * 0.038,
        color: AppColors.black_escuro,
      ),
      headline4: TextStyle(
        fontFamily: AppFonts.poppinsRegularFont,
        fontSize: Get.width * 0.033,
        color: AppColors.black_escuro,
      ),
      headline5: TextStyle(
        fontFamily: AppFonts.poppinsRegularFont,
        fontSize: Get.width * 0.035,
        color: AppColors.greenColor,
      ),
      headline6: TextStyle(
        fontFamily: AppFonts.poppinsBoldFont,
        fontSize: Get.width * 0.03,
        color: AppColors.greenColor,
      ),
    ),
  );
}
