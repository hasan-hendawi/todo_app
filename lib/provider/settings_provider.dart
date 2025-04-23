import 'package:flutter/material.dart';

class SettingsProvider extends ChangeNotifier {
  ThemeMode mode = ThemeMode.dark;

  void enableDarkMode() {
    mode = ThemeMode.dark;
    notifyListeners();
  }

  void enableLightMode() {
    mode = ThemeMode.light;
    notifyListeners();
  }

  AssetImage getAuthBackgroundImage() {
    return AssetImage(mode == ThemeMode.dark
        ? "assets/images/dark_auth.png"
        : "assets/images/light_auth.png");
  }

}