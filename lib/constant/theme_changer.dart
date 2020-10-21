import 'package:flutter/material.dart';

class ThemeChanger extends ChangeNotifier {
  ThemeData themeData;

  ThemeChanger({this.themeData});

  getTheme() => themeData;

  setTheme(ThemeData theme) {
    themeData = theme;
    notifyListeners();
  }

  static ThemeData lightTheme = ThemeData(
    primaryColor: Colors.green,
    accentColor: Colors.green,
    scaffoldBackgroundColor: Colors.white,
    brightness: Brightness.light,
    appBarTheme: AppBarTheme(
      color: Colors.transparent,
      elevation: 0.0,
      centerTitle: false,
      brightness: Brightness.light,
      iconTheme: IconThemeData(color: Colors.black),
    ),
    iconTheme: IconThemeData(color: Colors.black),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: Colors.green,
      elevation: 0.0,
    ),
    snackBarTheme: SnackBarThemeData(
      behavior: SnackBarBehavior.floating,
      actionTextColor: Colors.black,
      backgroundColor: Colors.white,
      contentTextStyle: TextStyle(color: Colors.black),
      elevation: 0.5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
    ),
    cursorColor: Colors.green,
  );

  static ThemeData darkTheme = ThemeData(
    primaryColor: Color(0xff03dac6),
    accentColor: Color(0xff03dac6),
    scaffoldBackgroundColor: Colors.black,
    brightness: Brightness.dark,
    appBarTheme: AppBarTheme(
      color: Colors.transparent,
      elevation: 0.0,
      centerTitle: false,
      brightness: Brightness.dark,
      iconTheme: IconThemeData(color: Colors.white),
    ),
    colorScheme: ColorScheme.light(
      surface: Color(0xFF222225),
      brightness: Brightness.dark,
    ),
    iconTheme: IconThemeData(color: Colors.white),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: Color(0xff03dac6),
      elevation: 0.0,
    ),
    snackBarTheme: SnackBarThemeData(
      behavior: SnackBarBehavior.floating,
      actionTextColor: Colors.white,
      backgroundColor: Color(0xFF222225),
      contentTextStyle: TextStyle(color: Colors.white),
      elevation: 0.9,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
    ),
    cursorColor: Color(0xff03dac6),
  );
}
