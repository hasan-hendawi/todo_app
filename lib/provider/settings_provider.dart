import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class SettingsProvider extends ChangeNotifier {
  ThemeMode mode = ThemeMode.dark;
  Locale lang = Locale("en");

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

  void enableLangArabic(BuildContext context) async {
    lang = Locale("ar");
    await context.setLocale(lang);
    notifyListeners();
  }

  void enableLangEnglish(BuildContext context) async {
    lang = Locale("en");
    await context.setLocale(lang);
    notifyListeners();
  }
}
