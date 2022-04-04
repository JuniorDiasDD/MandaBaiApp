import 'package:flutter/material.dart';
import 'package:manda_bai/Core/app_colors.dart';
import 'package:manda_bai/UI/Favorite/page/favorite_page.dart';
import 'package:manda_bai/UI/Pedido/pages/pedido_page.dart';
import 'package:manda_bai/UI/account/pages/profile_page.dart';
import 'package:manda_bai/UI/cart/pages/cart_page.dart';
import 'package:manda_bai/UI/category_filter/controller/mandaBaiProductController.dart';
import 'package:manda_bai/UI/home/controller/mandaBaiCategoryController.dart';
import 'package:manda_bai/UI/home/pop_up/pop_login.dart';
import 'package:manda_bai/UI/home/pages/start_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HomePage extends StatefulWidget {
  int index;
  HomePage({required this.index});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  static List<Widget> _widgetOptions = <Widget>[
    StartPage(),
    CartPage(),
    FavoritePage(),
    PedidoPage(),
    ProfilePage()
  ];

  Future<void> _onItemTapped(int index) async {
    if (index == 1 || index == 2 || index == 3) {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      var check = prefs.getString('id');
      if (check == 'null' || check == null) {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return Pop_Login();
            });
      } else {
        setState(() {
          _selectedIndex = index;
        });
      }
    } else {
      setState(() {
        _selectedIndex = index;
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      _selectedIndex = widget.index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: _selectedIndex == 0
                ? Icon(Icons.home)
                : Icon(Icons.home_outlined),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: _selectedIndex == 1
                ? Icon(Icons.shopping_cart)
                : Icon(Icons.shopping_cart_outlined),
            label: AppLocalizations.of(context)!.label_cart,
          ),
          BottomNavigationBarItem(
            icon: _selectedIndex == 2
                ? Icon(Icons.favorite)
                : Icon(Icons.favorite_border),
            label: AppLocalizations.of(context)!.label_favorites,
          ),
          BottomNavigationBarItem(
            icon: _selectedIndex == 3
                ? Icon(Icons.shopping_bag)
                : Icon(Icons.shopping_bag_outlined),
            label: AppLocalizations.of(context)!.label_order,
          ),
          BottomNavigationBarItem(
            icon: _selectedIndex == 4
                ? Icon(Icons.line_weight)
                : Icon(Icons.line_weight),
            label: AppLocalizations.of(context)!.label_more,
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: AppColors.greenColor,
        unselectedItemColor: Theme.of(context).indicatorColor,
        onTap: _onItemTapped,
      ),
    );
  }
}
