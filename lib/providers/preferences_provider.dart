import 'package:flutter/material.dart';
import 'package:dadascanner/utils/preferences.dart';

class PreferencesProvider extends ChangeNotifier {
  ThemeMode themeMode = PreferencesUtil.themeMode;
  int themeStyle = PreferencesUtil.themeStyle;

  void setThemeMode(ThemeMode mode) {
    themeMode = mode;
    PreferencesUtil.setThemeMode(themeMode);
    notifyListeners();
  }

  void setMaterial3Enable(int style) {
    themeStyle = style;
    PreferencesUtil.setThemeStyle(themeStyle);
    notifyListeners();
  }
}
