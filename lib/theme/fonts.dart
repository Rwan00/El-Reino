
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Color primaryBlue = const Color.fromRGBO(0, 141, 218,1);
Color lightBlue = const Color.fromRGBO(65, 201, 226,1);
Color primaryLightTeal = const Color.fromRGBO(172, 226, 225,1);
Color sandColor = const Color.fromRGBO(247, 238, 221,1);

TextStyle get heading {
  return GoogleFonts.abyssinicaSil(
    fontSize: 32,
    fontWeight: FontWeight.w700,
    
  );
}
TextStyle get subTitle {
  return GoogleFonts.acme(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: const Color.fromRGBO(112, 123, 129, 1)
  );
}

TextStyle get titleStyle {
  return GoogleFonts.acme(
      fontSize: 16,
      fontWeight: FontWeight.w500,
      
  );
}