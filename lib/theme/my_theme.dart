import 'package:flutter/material.dart';

class MyTheme {
  static const primaryColor = Color(0xff5D9CEC);

  static const lightScaffoldBgColor = Color(0xffDFECDB);
  static const darkScaffoldBgColor = Color(0xff060E1E);

  static const lightBottomNavigateBgColor = Color(0xffFFFFFF);
  static const darkBottomNavigateBgColor = Color(0xff141922);

  static const greenColorTheme = Color(0xff61E757);
  static const redColorTheme = Color(0xffEC4B4B);

  static ThemeData lightTheme = ThemeData(
    appBarTheme: AppBarTheme(backgroundColor: primaryColor),
    colorScheme: ColorScheme.light(
      primary: primaryColor,
      secondary: lightBottomNavigateBgColor,

    ),
    scaffoldBackgroundColor: lightScaffoldBgColor,
    textTheme: TextTheme(
      titleMedium: TextStyle(
          fontSize: 22, fontWeight: FontWeight.bold, color: lightScaffoldBgColor),
      bodyMedium: TextStyle(
          color: Color(0xff303030), fontSize: 14, fontWeight: FontWeight.bold),
    ),
  );

  static ThemeData darkTheme = ThemeData(
    colorScheme: ColorScheme.dark(
      primary: primaryColor,
      secondary: darkBottomNavigateBgColor,
    ),
    scaffoldBackgroundColor: darkScaffoldBgColor,
    textTheme: TextTheme(
      titleMedium: TextStyle(
          fontSize: 22, fontWeight: FontWeight.bold, color: darkScaffoldBgColor),
      bodyMedium: TextStyle(
          color: lightBottomNavigateBgColor, fontSize: 14, fontWeight: FontWeight.bold),
    ),
  );
}
