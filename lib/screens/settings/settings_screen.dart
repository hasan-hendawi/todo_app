import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/generated/locale_keys.g.dart';
import 'package:todo_app/provider/settings_provider.dart';

class SettingsScreen extends StatefulWidget {
  SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<SettingsProvider>(context);
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.primary,
          toolbarHeight: height * 0.17,
          leadingWidth: width * .3,
          leading: Text(
            "Settings",
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 20),
              Text(
                "Language",
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: provider.lang.languageCode == "en"
                        ? LocaleKeys.english.tr()
                        : LocaleKeys.arabic.tr(),
                    onChanged: (String? newValue) {
                      if (newValue == LocaleKeys.english.tr()) {
                        provider.enableLangEnglish(context);
                      } else {
                        provider.enableLangArabic(context);
                      }
                    },
                    items: [LocaleKeys.english.tr(), LocaleKeys.arabic.tr()]
                        .map<DropdownMenuItem<String>>((String language) {
                      return DropdownMenuItem<String>(
                        value: language,
                        child: Text(language),
                      );
                    }).toList(),
                    style: Theme.of(context).textTheme.bodyMedium,
                    dropdownColor: Theme.of(context).scaffoldBackgroundColor,
                  ),
                ),
              ),
              SizedBox(height: 20),
              Text(
                "Mode",
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: provider.mode == ThemeMode.dark
                        ? LocaleKeys.dark.tr()
                        : LocaleKeys.light.tr(),
                    onChanged: (String? newValue) {
                      if (newValue == LocaleKeys.light.tr()) {
                        provider.enableLightMode();
                      } else {
                        provider.enableDarkMode();
                      }
                    },
                    items: [LocaleKeys.light.tr(), LocaleKeys.dark.tr()]
                        .map<DropdownMenuItem<String>>((String mode) {
                      return DropdownMenuItem<String>(
                        value: mode,
                        child: Text(mode),
                      );
                    }).toList(),
                    style: Theme.of(context).textTheme.bodyMedium,
                    dropdownColor: Theme.of(context).scaffoldBackgroundColor,
                  ),
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onPressed: () {},
                child: Text(
                  "Logout",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
