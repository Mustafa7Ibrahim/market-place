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
    brightness: Brightness.light,
    iconTheme: IconThemeData(color: Colors.grey[900]),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: Colors.greenAccent,
      elevation: 0.0,
    ),
    snackBarTheme: SnackBarThemeData(
      backgroundColor: Colors.white,
      actionTextColor: Colors.green,
      contentTextStyle: TextStyle(color: Colors.grey[900]),
    ),
    appBarTheme: AppBarTheme(
      color: Colors.white,
      elevation: 0.0,
      brightness: Brightness.light,
      textTheme: TextTheme(headline6: TextStyle(color: Colors.green)),
      iconTheme: IconThemeData(color: Colors.green),
    ),
    scaffoldBackgroundColor: Colors.white,
    cursorColor: Colors.green,
  );

  static ThemeData darkTheme = ThemeData(
    primaryColor: Colors.greenAccent,
    accentColor: Colors.greenAccent,
    iconTheme: IconThemeData(color: Colors.white),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: Colors.greenAccent,
      elevation: 0.0,
    ),
    snackBarTheme: SnackBarThemeData(
      backgroundColor: Colors.grey[900],
      actionTextColor: Colors.greenAccent,
      contentTextStyle: TextStyle(color: Colors.white),
    ),
    brightness: Brightness.dark,
    appBarTheme: AppBarTheme(
      brightness: Brightness.dark,
      color: Colors.grey[900],
      elevation: 0.0,
      textTheme: TextTheme(headline6: TextStyle(color: Colors.greenAccent)),
      iconTheme: IconThemeData(color: Colors.white),
    ),
    scaffoldBackgroundColor: Colors.grey[850],
    cursorColor: Colors.greenAccent,
  );
}
