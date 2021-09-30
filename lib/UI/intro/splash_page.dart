import 'package:flutter/material.dart';
import 'package:manda_bai/Core/app_images.dart';

import 'onboarding_screen.dart';

 class SplashPage extends StatefulWidget {
   const SplashPage({Key? key}) : super(key: key);

   @override
   _SplashPageState createState() => _SplashPageState();
 }

 class _SplashPageState extends State<SplashPage> {
   static const _padding = EdgeInsets.only(top: 150.0);
   @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration(seconds:4)).then((_){
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>OnboardingScreen()));
    });
  }

   @override
   Widget build(BuildContext context) {
     return Scaffold(
       backgroundColor:Colors.white,
       body: Column(
         children: [
           Container(
             width: 400,
             padding:EdgeInsets.only (top: 200.0) ,
             child:  Container(
               width: 200,
               height: 200,
               child: Image.asset(AppImages.appLogo),

             ),
           ),

           Container(
             padding: _padding,
             child: Container(
               padding:EdgeInsets.only (top: 40.0) ,
               child: Text(
                 'Powered by MandaBai',
                 textAlign: TextAlign.center,
                 overflow: TextOverflow.ellipsis,
                 style: const TextStyle(fontWeight: FontWeight.normal),

               ),
             ),


           )


         ],
       ),

     );
   }
 }
