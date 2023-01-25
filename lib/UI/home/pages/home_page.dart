import 'package:flutter/material.dart';
import 'package:manda_bai/Core/app_colors.dart';
import 'package:manda_bai/Core/app_images.dart';
import 'package:manda_bai/UI/Favorite/page/favorite_page.dart';
import 'package:manda_bai/UI/order/pages/order_page.dart';
import 'package:manda_bai/UI/categories/pages/categoriesMenu.dart';
import 'package:manda_bai/UI/widget/dialog_custom.dart';
import 'package:manda_bai/UI/home/pages/start_page.dart';
import 'package:manda_bai/UI/setting/pages/setting.dart';
import 'package:manda_bai/constants/controllers.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:websafe_svg/websafe_svg.dart';

class HomePage extends StatefulWidget {
  final int index;
  const HomePage({Key? key, required this.index}) : super(key: key);
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;


  static final List<Widget> _widgetOptions = <Widget>[
    const StartPage(),
    const CategoriesMenu(),
    const PedidoPage(),
    const FavoritePage(),
    const Setting()
  ];

  Future<void> _onItemTapped(int index) async {
    if (index == 2 || index == 3) {
      if (!await authenticationController.checkLogin()) {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return DialogCustom(textButton: AppLocalizations.of(context)!.button_login,action: (){
                Navigator.pushNamed(context, '/login');
              },);
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
    super.initState();
    setState(() {
      _selectedIndex = widget.index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        return Future(() => false);
      },
      child: Scaffold(
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
      ),
    );
  }
}
