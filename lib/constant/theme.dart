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
    primarySwatch: Colors.red,
    accentColor: Colors.redAccent,
    brightness: Brightness.light,
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: Colors.redAccent,
      elevation: 0.0,
    ),
    appBarTheme: AppBarTheme(
      color: Colors.white,
      elevation: 0.0,
      iconTheme: IconThemeData(
        color: Colors.red,
      ),
    ),
    scaffoldBackgroundColor: Colors.white,
    cursorColor: Colors.greenAccent,
  );

  static ThemeData darkTheme = ThemeData(
    primarySwatch: Colors.red,
    accentColor: Colors.redAccent,
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: Colors.redAccent,
      elevation: 0.0,
    ),
    brightness: Brightness.dark,
    appBarTheme: AppBarTheme(
      color: Colors.grey[900],
      elevation: 0.0,
      iconTheme: IconThemeData(
        color: Colors.white,
      ),
    ),
    scaffoldBackgroundColor: Colors.grey[850],
    cursorColor: Colors.red,
  );
}
