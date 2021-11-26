import 'package:flutter/material.dart';
import 'package:flutter_session/flutter_session.dart';
import 'package:manda_bai/Core/app_colors.dart';
import 'package:manda_bai/UI/Favorite/page/favorite_page.dart';
import 'package:manda_bai/UI/account/pages/profile_page.dart';
import 'package:manda_bai/UI/cart/pages/cart_page.dart';
import 'package:manda_bai/UI/home/components/pop_login.dart';
import 'package:manda_bai/UI/home/pages/start_page.dart';
class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

/// This is the private State class that goes with MyStatefulWidget.
class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
  TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static  List<Widget> _widgetOptions = <Widget>[
    StartPage(),
    CartPage(),
    FavoritePage(),
    ProfilePage()
  ];

  void _onItemTapped(int index) {
    setState(() async {

      if (index == 3){
        var check = await FlutterSession().get('username');
        if (check == 'null' || check == null) {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return Pop_Login();
              });
        } else {
          _selectedIndex = index;
        }
      }else{
        _selectedIndex = index;
      }

    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart_outlined),
            label: 'Carrinho',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite_border),
            label: 'Favoritos',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outlined),
            label: 'Perfil',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: AppColors.greenColor,
        unselectedItemColor: Colors.black54,
        onTap: _onItemTapped,

      ),
    );
  }
}
