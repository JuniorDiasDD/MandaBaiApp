import 'package:flutter/material.dart';
import 'package:flutter_session/flutter_session.dart';
import 'package:get/get.dart';
import 'package:manda_bai/Controller/cart_controller.dart';
import 'package:manda_bai/Controller/mandaBaiController.dart';
import 'package:manda_bai/Core/app_colors.dart';
import 'package:manda_bai/UI/Favorite/page/favorite_page.dart';
import 'package:manda_bai/UI/account/pages/profile_page.dart';
import 'package:manda_bai/UI/cart/pages/cart_page.dart';
import 'package:manda_bai/UI/category_filter/controller/mandaBaiProductController.dart';
import 'package:manda_bai/UI/home/controller/mandaBaiCategoryController.dart';
import 'package:manda_bai/UI/home/pop_up/pop_login.dart';
import 'package:manda_bai/UI/home/pages/start_page.dart';

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
    ProfilePage()
  ];

  Future<void> _onItemTapped(int index) async {
    /*if (index == 3){
        var check = await FlutterSession().get('id');
        if (check == 'null' || check == null) {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return Pop_Login();
              });
        }else {
          setState(()  { _selectedIndex = index;  });
        }
      }else{*/
    setState(() {
      _selectedIndex = index;
    });
    // }
  }

  final MandaBaiCategoryController mandaBaiCategoryController =
      Get.put(MandaBaiCategoryController());
  final MandaBaiController mandaBaiController = Get.put(MandaBaiController());
  final MandaBaiProductController mandaBaiProductController =
      Get.put(MandaBaiProductController());
  CartPageController cartPageController = Get.put(CartPageController());
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
            icon: Icon(Icons.line_weight),
            label: 'Mais',
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
