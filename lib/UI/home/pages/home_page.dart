import 'package:flutter/material.dart';
import 'package:manda_bai/Core/app_colors.dart';
import 'package:manda_bai/UI/Favorite/page/favorite_page.dart';
import 'package:manda_bai/UI/Pedido/pages/pedido_page.dart';
import 'package:manda_bai/UI/categories/pages/categoriesMenu.dart';
import 'package:manda_bai/UI/home/pop_up/pop_login.dart';
import 'package:manda_bai/UI/home/pages/start_page.dart';
import 'package:manda_bai/UI/setting/pages/setting.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:websafe_svg/websafe_svg.dart';

import '../../../Core/app_images.dart';

class HomePage extends StatefulWidget {
  int index;
  HomePage({Key? key, required this.index}) : super(key: key);
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  static final List<Widget> _widgetOptions = <Widget>[
    StartPage(),
    const CategoriesMenu(),
    const FavoritePage(),
    PedidoPage(),
    const Setting()
  ];

  Future<void> _onItemTapped(int index) async {
    if (index == 2 || index == 3) {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      var check = prefs.getString('id');
      if (check == 'null' || check == null) {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return const Pop_Login();
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
                ? WebsafeSvg.asset(AppImages.iconMenuHome)
                : WebsafeSvg.asset(AppImages.iconMenuHomeOutline),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: _selectedIndex == 1
                ? WebsafeSvg.asset(AppImages.iconMenuCategory)
                : WebsafeSvg.asset(AppImages.iconMenuCategoryOutline),
            label: AppLocalizations.of(context)!.label_category,
          ),
          BottomNavigationBarItem(
            icon: _selectedIndex == 2
                ? WebsafeSvg.asset(AppImages.iconMenuShopping)
                : WebsafeSvg.asset(AppImages.iconMenuShoppingOutline),
            label: AppLocalizations.of(context)!.label_order,
          ),
          BottomNavigationBarItem(
            icon: _selectedIndex == 3
                ? WebsafeSvg.asset(AppImages.iconMenuFavorite)
                : WebsafeSvg.asset(AppImages.iconMenuFavoriteOutline),
            label: AppLocalizations.of(context)!.label_favorites,
          ),
          BottomNavigationBarItem(
            icon: _selectedIndex == 4
                ? WebsafeSvg.asset(AppImages.iconMenuSetting)
                : WebsafeSvg.asset(AppImages.iconMenuSettingOutline),
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
