import 'package:flutter/material.dart';

ThemeData theme = ThemeData(
  primarySwatch: Colors.red,
  accentColor: Colors.redAccent,
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
