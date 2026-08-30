import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider extends ChangeNotifier {
  static const String _themeKey = 'isDarkMode';
  ThemeMode _themeMode = ThemeMode.light;
  ThemeMode get themeMode => _themeMode;

  String _message = '';
  String get message => _message;

  bool get isDarkMode => _themeMode == ThemeMode.dark;

  Future<void> loadTheme() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final isDarkMode = prefs.getBool(_themeKey) ?? false;

      _themeMode = isDarkMode ? ThemeMode.dark : ThemeMode.light;
    } catch (e) {
      _message = 'error: ${e.toString()}';
    }

    notifyListeners();
  }

  Future<void> toggleTheme(bool value) async {
    try {
      _themeMode = value ? ThemeMode.dark : ThemeMode.light;
      final prefs = await SharedPreferences.getInstance();

      await prefs.setBool(_themeKey, value);
    } catch (e) {
      _message = 'error: ${e.toString()}';
    }

    notifyListeners();
  }

  // bool _isLightTheme = true;

  // bool get isLightTheme => _isLightTheme;

  // set setIsLightTheme(bool value) {
  //   _isLightTheme = value;
  //   notifyListeners();
  // }
}
