import 'package:flutter/widgets.dart';

class ThemeProvider extends ChangeNotifier {
  bool _isLightTheme = true;

  bool get isLightTheme => _isLightTheme;

  set setIsLightTheme(bool value) {
    _isLightTheme = value;
    notifyListeners();
  }
}
