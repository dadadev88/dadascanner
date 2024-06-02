import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

const _themeModPref = 'THEME_MODE_PREF';
const _themeStyle = 'THEME_STYLE_PREF';

class PreferencesUtil {
  static late SharedPreferences _pref;

  static Future<void> initialize() async {
    _pref = await SharedPreferences.getInstance();
    // _pref.remove(_themeModPref);
    // _pref.remove(_themeStyle);
  }

  static setThemeMode(ThemeMode mode) {
    final String modeStr = mode == ThemeMode.dark ? 'dark' : 'light';
    _pref.setString(_themeModPref, modeStr);
  }

  static ThemeMode get themeMode {
    final bool isDarkMode = _pref.getString(_themeModPref) == 'dark';
    return isDarkMode ? ThemeMode.dark : ThemeMode.light;
  }

  static setThemeStyle(int value) {
    _pref.setInt(_themeStyle, value);
  }

  static int get themeStyle {
    return _pref.getInt(_themeStyle) ?? 1;
  }
}
