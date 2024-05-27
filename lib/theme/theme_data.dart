import 'package:el_reino/constants/consts.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Themes {
  static final light = ThemeData(
    //useMaterial3: true,
    colorScheme: ColorScheme.fromSwatch().copyWith(
        secondary: const Color.fromRGBO(74, 85, 162, 1),
        primary: primaryBlue,
        background: Colors.white,
        brightness: Brightness.light),
        appBarTheme: const AppBarTheme(
                  titleSpacing: 20,
                  systemOverlayStyle: SystemUiOverlayStyle(
                    statusBarColor: Colors.white,
                    statusBarIconBrightness: Brightness.dark,
                  ),
                  backgroundColor: Colors.white,
                  elevation: 0,
                  titleTextStyle: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                  iconTheme: IconThemeData(color: Colors.black)),
  );
  static final dark = ThemeData(
    //useMaterial3: true,
    colorScheme: ColorScheme.fromSwatch().copyWith(
        //secondary: const Color.fromRGBO(74, 85, 162, 1),
        primary: primaryBlue,
        background: Colors.black,
        brightness: Brightness.dark),
        appBarTheme: const AppBarTheme(
                  titleSpacing: 20,
                  systemOverlayStyle: SystemUiOverlayStyle(
                      statusBarColor: Colors.black,
                      statusBarIconBrightness: Brightness.light),
                  backgroundColor: Colors.black,
                  elevation: 0,
                  titleTextStyle: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                  iconTheme: IconThemeData(color: Colors.white)),
    //canvasColor: Colors.black,
  );
}