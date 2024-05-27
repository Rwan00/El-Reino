import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

TextStyle get heading {
  return GoogleFonts.abyssinicaSil(
    fontSize: 32,
    fontWeight: FontWeight.w700,
    color: Get.isDarkMode ? Colors.white : Colors.black,
  );
}

TextStyle get appTitle {
  return GoogleFonts.abyssinicaSil(
    fontSize: 24,
    color: Get.isDarkMode ? Colors.white : Colors.black,
    fontWeight: FontWeight.w700,
  );
}

TextStyle get subTitle {
  return GoogleFonts.acme(
      fontSize: 14,
      fontWeight: FontWeight.w400,
      color: Get.isDarkMode
          ? const Color.fromARGB(255, 176, 174, 174)
          : const Color.fromRGBO(112, 123, 129, 1));
}

TextStyle get titleStyle {
  return GoogleFonts.acme(
      fontSize: 16,
      fontWeight: FontWeight.w500,
      color: Get.isDarkMode ? Colors.white : Colors.black);
}
