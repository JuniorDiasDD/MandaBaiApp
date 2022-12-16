import 'package:flutter/material.dart';

class CircleIcon extends StatefulWidget {
  final IconData icon;
  final VoidCallback action;
  const CircleIcon({Key? key,required this.icon,required this.action}) : super(key: key);

  @override
  State<CircleIcon> createState() => _CircleIconState();
}

class _CircleIconState extends State<CircleIcon> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(50)),
          color:Theme.of(context).primaryColor,
        ),
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: IconButton(icon:Icon(widget.icon,color: Colors.white,),onPressed: widget.action,),
        ),
      ),
    );
  }
}
