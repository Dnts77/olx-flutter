import 'package:flutter/material.dart';

class AppTheme{
  static ThemeData defaultTheme = ThemeData(
    primaryColor: Color(0xff9c27b0),
    appBarTheme: AppBarTheme(
      backgroundColor: Color(0xff9c27b0),
      shadowColor: Color(0xff7b1fa2),
      foregroundColor: Colors.white,
      elevation: 4,
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      foregroundColor: Colors.white,
      backgroundColor: Color(0xff9c27b0),
      iconSize: 30
    )
  );
}