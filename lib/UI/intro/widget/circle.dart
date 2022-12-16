import 'package:flutter/material.dart';

class Circle extends StatefulWidget {
  final bool active;
  const Circle({Key? key,this.active=false}) : super(key: key);

  @override
  State<Circle> createState() => _CircleState();
}

class _CircleState extends State<Circle> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Container(
        width: widget.active? 20 : 8,
        height: 8,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(20)),
          color: widget.active?  Theme.of(context).primaryColor: Theme.of(context).primaryColor.withOpacity(0.4),
        ),
      ),
    );
  }
}
