import 'package:flutter/material.dart';
import 'package:manda_bai/Core/app_colors.dart';



class CustomTextFieldObscure extends StatefulWidget {
  final String hintText;
  final String requiredLabel;
  final TextEditingController? textController;

  const CustomTextFieldObscure(
      {Key? key, required this.hintText,required this.requiredLabel, this.textController})
      : super(key: key);

  @override
  State<CustomTextFieldObscure> createState() => _CustomTextFieldObscureState();
}

class _CustomTextFieldObscureState extends State<CustomTextFieldObscure> {
  late bool statePassword = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: statePassword,
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
        fillColor: Theme.of(context).primaryColorDark,
        hintText: widget.hintText,
        hintStyle: Theme.of(context).textTheme.headline4,
        suffixIcon: IconButton(
          onPressed: () {
            setState(() {
              statePassword = !statePassword;
            });
          },
          icon: Icon(
            statePassword ? Icons.visibility : Icons.visibility_off,
          ),
        ),
      ),
      controller: widget.textController,
      validator: (value) => value!.isEmpty ? widget.requiredLabel : null,
    );
  }
}
