
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Loading extends StatelessWidget {
  const Loading({Key? key}) : super(key: key);
  static const _padding = EdgeInsets.only( top: 150.0);

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
              child: Image.asset('images/logo.png'),

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
