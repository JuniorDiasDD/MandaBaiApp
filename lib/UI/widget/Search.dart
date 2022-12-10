import 'package:flutter/material.dart';
import 'package:manda_bai/Core/app_colors.dart';

class Search extends StatelessWidget {
  final String textHint;
  final VoidCallback function;
  final TextEditingController controller;
  const Search(
      {required this.textHint,
      required this.function,
      required this.controller,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      cursorColor: AppColors.greenColor,
      controller: controller,
      style: Theme.of(context).textTheme.headline4,
      decoration: InputDecoration(
        hintText: textHint,
        hintStyle: Theme.of(context).textTheme.headline4,
        contentPadding: const EdgeInsets.only(top: 8),
        focusedBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(20.0)),
            borderSide: BorderSide(color: AppColors.greenColor)),
        prefixIcon: Icon(
          Icons.search,
          color: AppColors.black_claro.withOpacity(0.4),
        ),
        filled: true,
        fillColor: AppColors.grey50.withOpacity(0.5),
        enabledBorder: OutlineInputBorder(
          borderRadius: const BorderRadius.all(
            Radius.circular(20.0),
          ),
          borderSide: BorderSide(
              color: AppColors.black_claro.withOpacity(0.4), width: 0.0),
        ),
      ),
      onChanged: (text) => function,
    );
  }
}
