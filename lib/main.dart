import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:manda_bai/UI/location_destination/page/destination_page.dart';

import 'Core/app_themes.dart';
import 'UI/authention/pages/login_page.dart';
import 'UI/authention/pages/register_page.dart';
import 'UI/home/pages/home_page.dart';
import 'UI/intro/splash_page.dart';
import 'UI/location_destination/page/new_destination.dart';


void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'MandaBai',
    
      theme: AppThemes.lightTheme,
      // The Mandy red, dark theme.
      darkTheme: AppThemes.darkTheme,
      // Use dark or light theme based on system setting.
      themeMode: ThemeMode.system,
       initialRoute: '/',
      routes: {
        '/': (context) => SplashPage(),
        '/login': (context) => LoginPage(),
        '/register': (context) => RegisterPage(),
        '/home': (context) => HomePage(index:0),
       //// '/solicitacao': (context) => PageSolicitacao(),
       '/newDestination': (context) => NewDestination(route:"destination"),
         '/Destination': (context) => Destination_Page(),
       // '/servicos': (context) => PageServicos(),
       // '/restaurePassword': (context) => PageRestaurePassword(),
       //  '/ativar': (context)=>PageAtivacaoCategoria(),
       // '/onboarding': (context) => PageOnboarding(),
        //'/StartPage': (context) => StartPage(),
      },
    );
  }
}
