import 'package:flutter/material.dart';

import 'UI/authention/pages/login_page.dart';
import 'UI/authention/pages/register_page.dart';
import 'UI/home/pages/home_page.dart';


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
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      //home: const LoginPage(),
       initialRoute: '/',
      routes: {
        '/': (context) => LoginPage(),
        '/login': (context) => LoginPage(),
        '/register': (context) => RegisterPage(),
        '/home': (context) => HomePage(),
       //// '/solicitacao': (context) => PageSolicitacao(),
       // '/gestaoPagamentoo': (context) => PageStartPayments(),
       // '/servicos': (context) => PageServicos(),
       // '/restaurePassword': (context) => PageRestaurePassword(),
       //  '/ativar': (context)=>PageAtivacaoCategoria(),
       // '/onboarding': (context) => PageOnboarding(),
        //'/StartPage': (context) => StartPage(),
      },
    );
  }
}
