import 'package:flutter/cupertino.dart';

class ErrorPage extends StatelessWidget {
  final String text;
  const ErrorPage({required this.text,Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(text),
    );
  }
}
