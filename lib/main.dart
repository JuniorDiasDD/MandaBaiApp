import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:manda_bai/Controller/favorite_controller.dart';
import 'package:manda_bai/Controller/full_controller.dart';
import 'package:manda_bai/Controller/location_controller.dart';
import 'package:manda_bai/Controller/mandaBaiController.dart';
import 'package:manda_bai/Controller/orderController.dart';
import 'package:manda_bai/UI/Contact/contact_page.dart';
import 'package:manda_bai/UI/about/pages/info_app.dart';
import 'package:manda_bai/UI/account/edit_profile.dart';
import 'package:manda_bai/UI/cart/pages/cart_page.dart';
import 'package:manda_bai/UI/cart/pages/checkout_page_step_2.dart';
import 'package:manda_bai/UI/category_filter/controller/mandaBaiProductController.dart';
import 'package:manda_bai/UI/intro/pages/onboarding_page.dart';
import 'package:manda_bai/UI/location_destination/page/destination_page.dart';
import 'package:manda_bai/UI/setting/pages/setting_moeda.dart';
import 'package:manda_bai/UI/updateApp/UpdateApp.dart';
import 'package:manda_bai/constants/controllers.dart';
import 'Controller/authentication_controller.dart';
import 'Controller/category_controller.dart';
import 'Controller/product_controller.dart';
import 'Core/app_themes.dart';
import 'UI/about/pages/info_manda_bai.dart';
import 'UI/authention/pages/login_page.dart';
import 'UI/authention/pages/register_page.dart';
import 'UI/categories/pages/categories.dart';
import 'UI/home/pages/home_page.dart';
import 'UI/intro/pages/choose_island_page.dart';
import 'UI/intro/splash_page.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await initialization;

  HttpOverrides.global =  MyHttpOverrides();
  Get.put(MandaBaiProductController());
  Get.put(MandaBaiController());
  Get.put(FullController());
  Get.put(CategoryController());
  Get.put(ProductController());
  Get.put(LocationController());
  Get.put(AuthenticationController());
  Get.put(FavoriteController());
  Get.put(OrderController());

  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'MandaBai',
      localizationsDelegates: const [
        AppLocalizations.delegate, // Add this line
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en', ''), // English, no country code
        Locale('pt', ''),
        Locale('nl', ''), //
        Locale('fr', ''), // Spanish, no country code
      ],
      theme: AppThemes.lightTheme,
      // The Mandy red, dark theme.
      darkTheme: AppThemes.darkTheme,
      // Use dark or light theme based on system setting.
      themeMode: ThemeMode.system,
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashPage(),
        '/chooseIsland': (context) => const ChooseIsland(),
        '/boarding': (context) => const OnboardingPage(),
        '/login': (context) => const LoginPage(),
        '/register': (context) => const RegisterPage(),
        '/home': (context) => const HomePage(index: 0),
        '/cart': (context) => const CartPage(),
        '/SettingDestination': (context) => const DestinationPage(),
        '/checkoutFinal': (context) =>const CheckoutPageStep2(),
        '/infoMandaBai': (context) => const InfoMandaBai(),
        '/infoApp': (context) => const InfoApp(),
        '/contact': (context) => const ContactPage(),
        '/updateApp': (context) => const UpdateApp(),
        '/categories': (context) => const Categories(),
        '/settingMoney': (context) => const SettingMoney(),
        '/editProfile': (context) => const EditPorfilePage(),
      },
    );
  }
}
