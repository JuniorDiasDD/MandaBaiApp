import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:manda_bai/Core/app_colors.dart';

class Menu extends StatefulWidget {
  @override
  _MenuState createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,
        children: <Widget>[
          SizedBox(
            height: Get.height * 0.05,
          ),
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'Menu',
              //style: textTheme.headline6,
            ),
          ),
          const Divider(
            height: 1,
            thickness: 1,
          ),
          ListTile(
            leading: const Icon(
              Icons.home,
              color: AppColors.greenColor,
              size: 20,
            ),
            title: const Text('Home'),
            // subtitle: Text("This is the 1st item"),
            //trailing: Icon(Icons.more_vert),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/home');
            },
          ),
          ListTile(
            leading: ConstrainedBox(
              constraints: BoxConstraints(
                minWidth: 20,
                minHeight: 20,
                maxWidth: 20,
                maxHeight: 20,
              ),
              child:
                  Image.asset('assets/images/cvmovel.png', fit: BoxFit.cover),
            ),
            title: const Text('CvMovel (saldo)'),
            onTap: () {
              // Navigator.pushNamed(context, '/servicos');
              // Navigator.pushReplacementNamed(context, '/servicos');
            },
          ),
          ListTile(
            leading: ConstrainedBox(
              constraints: BoxConstraints(
                minWidth: 20,
                minHeight: 20,
                maxWidth: 20,
                maxHeight: 20,
              ),
              child:
                  Image.asset('assets/images/camara.png', fit: BoxFit.cover),
            ),
            title: const Text('Serviços da Câmara'),
            onTap: () {
              // Navigator.pushNamed(context, '/servicos');
              // Navigator.pushReplacementNamed(context, '/servicos');
            },
          ),
          const Divider(),
          /* ListTile(
            title: const Text('Lista de Operações'),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/solicitacao');
            },
          ),*/
          ListTile(
            leading: const Icon(
              Icons.settings,
              size: 20,
              color: AppColors.greenColor,
            ),
            title: const Text('Configuração de Serviços'),
            onTap: () {
              /*  Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) =>
                          PageAtivacaoCategoria(list_area: list_area)));*/
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.logout,
              size: 20,
              color: AppColors.greenColor,
            ),
            title: const Text('Sair'),
            onTap: () {
              SystemNavigator.pop();
            },
          ),
        ],
      ),
    );
  }
}
