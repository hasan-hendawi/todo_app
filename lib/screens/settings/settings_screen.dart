import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/provider/settings_provider.dart';

class SettingsScreen extends StatefulWidget {
  SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  String selectedLanguage = 'English';


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
            crossAxisAlignment: CrossAxisAlignment.start,
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
                    value: selectedLanguage,
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedLanguage = newValue!;
                      });
                    },
                    items: ['English', 'Arabic']
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
                    value: provider.mode==ThemeMode.dark?"Dark":'Light',
                    onChanged: (String? newValue) {
                      if(newValue == "Light"){
                        provider.enableLightMode();
                      }else {
                        provider.enableDarkMode();
                      }
                    },
                    items: ['Light', 'Dark']
                        .map<DropdownMenuItem<String>>((String mode) {
                      return DropdownMenuItem<String>(
                        value: mode,
                        child: Text(mode),
                      );
                    }).toList(),
                    style: Theme.of(context).textTheme.bodyMedium,
                    dropdownColor:Theme.of(context).scaffoldBackgroundColor,

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
