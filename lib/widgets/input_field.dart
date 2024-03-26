import 'package:flutter/material.dart';

import '../theme/fonts.dart';

class InputField extends StatefulWidget {
  final String? title;
  final String hint;
  final TextEditingController? controller;
  final Widget? widget;
  final TextInputType? textType;
  final String? Function(String?)? validator;
  final void Function(String?)? onSaved;
  final bool isPassword;

  const InputField(
      {this.title,
      required this.hint,
      this.controller,
      this.widget,
      this.textType,
      this.validator,
      this.onSaved,
      this.isPassword = false,
      super.key});

  @override
  State<InputField> createState() => _InputFieldState();
}

class _InputFieldState extends State<InputField> {
  bool showPwd = false;
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(top: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (widget.title != null)
              Text(
                widget.title!,
                style: titleStyle,
              ),
            const SizedBox(
              height: 8,
            ),
            TextFormField(
              obscureText: widget.isPassword && !showPwd,
              autocorrect: widget.title == null ? true : false,
              enableSuggestions: widget.title == null ? true : false,
              onSaved: widget.onSaved,
              validator: widget.validator,
              controller: widget.controller,
              keyboardType: widget.textType,
              autofocus: false,
              style: titleStyle,
              cursorColor: const Color.fromRGBO(0, 117, 255, 1),
              decoration: InputDecoration(
                suffixIcon: widget.isPassword
                    ? IconButton(
                        onPressed: () {
                          setState(() {
                            showPwd = !showPwd;
                          });
                        },
                        icon: showPwd
                            ? const Icon(Icons.visibility_off_outlined)
                            : const Icon(Icons.visibility_outlined),
                      )
                    : widget.widget,
                contentPadding: const EdgeInsets.all(12),
                prefixIcon: widget.widget,
                hintText: widget.hint,
                hintStyle: subTitle,
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(
                      color: Colors.grey,
                      style: BorderStyle.solid,
                      width: 1,
                    )),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(
                      color: Theme.of(context).colorScheme.primary,
                      width: 1,
                    )),
              ),
            ),
          ],
        ));
  }
}
