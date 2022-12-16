import 'package:flutter/material.dart';
import 'package:manda_bai/Core/app_colors.dart';


class CustomTextField extends StatelessWidget {
  final String hintText;
  final String? requiredLabel;
  final TextEditingController? textController;
  final bool enable;
  final IconData? icon;
  final TextInputType? keyboardType;
  final bool? login;
  const CustomTextField(
      {Key? key,
        this.icon,this.keyboardType=TextInputType.text,
        this.login=false,
      required this.hintText,
      this.textController,
       this.requiredLabel,
      this.enable = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      enabled: enable,
      keyboardType: keyboardType,
      style: Theme.of(context).textTheme.headline4,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderSide:
              BorderSide(color: Theme.of(context).colorScheme.onBackground),
          borderRadius: BorderRadius.circular(16.0),
        ),
        focusedBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(20.0)),
            borderSide: BorderSide(color: AppColors.greenColor)),
        fillColor: Theme.of(context).primaryColor,
        hintText: hintText,
        hintStyle: Theme.of(context).textTheme.headline4,
        prefixIcon: icon == null
            ? null
            :  Padding(
          padding: const EdgeInsets.all(0.0),
          child: Icon(
            icon,
            color: login!?Colors.black54:Colors.grey,
          ), // icon is 48px widget.
        ),
      ),
      controller: textController,
      validator: (value) => value!.isEmpty ? requiredLabel : null,
    );
  }
}
