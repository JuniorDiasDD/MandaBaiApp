import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:manda_bai/Core/app_colors.dart';

class TextFormFieldCustom extends StatefulWidget {
  final String hintText;
  final String? requiredLabel;
  final TextEditingController? textController;
  final bool checkEmail;
  final IconData? icon;
  final TextInputType? keyboardType;
  final bool? login;
  const TextFormFieldCustom(
      {Key? key,
      required this.hintText,
      this.requiredLabel,
      this.textController,
      this.checkEmail = false,
      this.icon,this.keyboardType=TextInputType.text,this.login=false})
      : super(key: key);

  @override
  State<TextFormFieldCustom> createState() => _TextFormFieldCustomState();
}

class _TextFormFieldCustomState extends State<TextFormFieldCustom> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.textController,
      obscureText: false,
      keyboardType: widget.keyboardType,
      style: Theme.of(context).textTheme.headline4,
      decoration: InputDecoration(
        filled: true,
        fillColor:widget.login! ? AppColors.grey50.withOpacity(0.8): AppColors.grey50.withOpacity(0.5),
        enabledBorder: OutlineInputBorder(
          borderRadius: const BorderRadius.all(
            Radius.circular(20.0),
          ),
          borderSide: BorderSide(
              color: AppColors.black_claro.withOpacity(0.4), width: 0.0),
        ),
        focusedBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(20.0)),
            borderSide: BorderSide(color: AppColors.greenColor)),
        prefixIcon: widget.icon == null
            ? null
            :  Padding(
                padding: const EdgeInsets.all(0.0),
                child: Icon(
                 widget.icon,
                  color: widget.login!?Colors.black54:Colors.grey,
                ), // icon is 48px widget.
              ),
        labelText: widget.hintText,
        labelStyle: Theme.of(context).textTheme.headline4,
      ),
      validator: (value) => widget.checkEmail
          ? EmailValidator.validate(value!)
              ? null
              : widget.requiredLabel
          : value!.isEmpty
              ? widget.requiredLabel
              : null,
    );
  }
}
