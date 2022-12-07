import 'package:flutter/material.dart';
import 'package:get/get.dart';


openCustomDialog(BuildContext context, Widget child, List<Widget> actions, {bool large = false}) {
  Get.dialog(
    AlertDialog(
      alignment: Alignment.center,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(16),
        ),
      ),
      content: SizedBox(
        height: large ? 148 : 76,
        child: child,
      ),
      actions: actions,
    ),
  );
}

openLoadingStateDialog(BuildContext context) {
  showDialog(
      context: context,
      builder: (BuildContext context)
  {
    return AlertDialog(
      alignment: Alignment.center,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(16),
        ),
      ),
      content: SizedBox(
        height: 76,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(color: Theme
                .of(context)
                .primaryColor, strokeWidth: 2,),
            const SizedBox(width: 16,),
            Text("Processando..."),
          ],
        ),
      ),
    );
  }
  );

}
