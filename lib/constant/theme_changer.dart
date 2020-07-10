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
    primaryColor: Colors.red,
    accentColor: Colors.redAccent,
    brightness: Brightness.light,
    iconTheme: IconThemeData(color: Colors.grey[900]),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: Colors.redAccent,
      elevation: 0.0,
    ),
    snackBarTheme: SnackBarThemeData(
      backgroundColor: Colors.white,
      actionTextColor: Colors.redAccent,
      contentTextStyle: TextStyle(color: Colors.grey[900]),
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
    iconTheme: IconThemeData(color: Colors.white),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: Colors.redAccent,
      elevation: 0.0,
    ),
    snackBarTheme: SnackBarThemeData(
      backgroundColor: Colors.grey[900],
      actionTextColor: Colors.redAccent,
      contentTextStyle: TextStyle(color: Colors.white),
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
