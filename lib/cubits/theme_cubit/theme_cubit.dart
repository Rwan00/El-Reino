import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../helper/cache_helper.dart';
import 'theme_state.dart';

class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit() : super(ThemeInitial()) {
    // Initialize the theme in the constructor
    theme = _loadThemeFromBox() ? ThemeMode.dark : ThemeMode.light;
    emit(ThemeChanged(theme));
  }

  void _saveThemeToBox(bool isDark) {
    CacheHelper.saveData(key: "isDark", value: isDark);
  }

  bool _loadThemeFromBox() => CacheHelper.getData(key: "isDark") ?? false;

  late ThemeMode theme;

  void switchTheme() {
    theme = _loadThemeFromBox() ? ThemeMode.light : ThemeMode.dark;
    _saveThemeToBox(theme == ThemeMode.dark);
    emit(AppChangeModeState(theme));
  }
}