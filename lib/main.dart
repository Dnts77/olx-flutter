import 'package:flutter/material.dart';
import 'package:olx_flutter/screens/home_screen.dart';
import 'package:olx_flutter/utils/themes.dart';

void main() {
  runApp(MaterialApp(
    home: HomeScreen(),
    title: "OLX",
    theme: AppTheme.defaultTheme,
    debugShowCheckedModeBanner: false,
  ));
}

