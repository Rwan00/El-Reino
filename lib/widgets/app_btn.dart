
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../constants/consts.dart';

class AppBtn extends StatelessWidget {
  final void Function()? onPressed;
  final String label;
  final Color? clr;
  final TextStyle? style;
  const AppBtn(
      {required this.label,
      required this.onPressed,
      this.clr,
      this.style,
      super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ButtonStyle(
          foregroundColor: MaterialStateProperty.all(Colors.white),
          textStyle:
              MaterialStateProperty.all(GoogleFonts.raleway(fontSize: 16)),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16.0),
            ),
          ),
          backgroundColor:
              MaterialStateProperty.all(clr ?? primaryBlue.withOpacity(0.6))),
      child: Text(
        label,
        style: style,
      ),
    );
  }
}
