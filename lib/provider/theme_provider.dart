import 'package:flutter/material.dart';

class ThemeModeProvider extends ChangeNotifier {
  ThemeMode themeMode = ThemeMode.light;

  switchTheme() {
    if (themeMode == ThemeMode.light) {
      themeMode = ThemeMode.dark;
    } else {
      themeMode = ThemeMode.light;
    }
    notifyListeners();
  }
}
