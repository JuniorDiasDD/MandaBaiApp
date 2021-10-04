import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:manda_bai/Core/app_images.dart';

class StartPage extends StatefulWidget {
  const StartPage({Key? key}) : super(key: key);

  @override
  _StartPageState createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children:[
          Container(
            width: Get.width,
              child: Image.asset(AppImages.Banner),

            ),
         const TextField(
           decoration: InputDecoration(
               hintText: 'Pesquisar Produto...',
             border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(5.0))),
           ),

         ),


        ]

      ),
    );
  }
}
