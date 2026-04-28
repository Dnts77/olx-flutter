import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:olx_flutter/firebase_options.dart';
import 'package:olx_flutter/screens/home_screen.dart';
import 'package:olx_flutter/utils/themes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform
  );
  runApp(MaterialApp(
    home: HomeScreen(),
    title: "OLX",
    theme: AppTheme.defaultTheme,
    debugShowCheckedModeBanner: false,
  ));
}

