import 'package:flutter/material.dart';

import '../constants/consts.dart';
import '../theme/fonts.dart';

class AppInputField extends StatelessWidget {
  final TextEditingController controller;
  final Widget? widget;
  final String hint;
  const AppInputField(
      {required this.controller, this.widget, required this.hint, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(maxWidth: 200),
      height: 60,
      decoration: BoxDecoration(
        color: Colors.grey.withOpacity(0.2),
        borderRadius: BorderRadius.circular(8),
      ),
      child: TextFormField(
        maxLines: 10,
        controller: controller,
        autofocus: false,
        style: titleStyle,
        cursorColor: primaryBlue,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.all(8),
          hintText: hint,
          hintStyle: subTitle,
          suffixIcon: widget,
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(
                color: Colors.grey,
                style: BorderStyle.solid,
                width: 1,
              )),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(
                color: primaryBlue,
                width: 2,
              )),
        ),
      ),
    );
  }
}
