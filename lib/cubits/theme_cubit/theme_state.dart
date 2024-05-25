import 'package:flutter/material.dart';

abstract class ThemeState {}

class ThemeInitial extends ThemeState {}

class ThemeChanged extends ThemeState {
  final ThemeMode themeMode;

  ThemeChanged(this.themeMode);
}

class AppChangeModeState extends ThemeState {
  final ThemeMode themeMode;

  AppChangeModeState(this.themeMode);
}