import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData light = ThemeData(
    brightness: Brightness.light,
    primaryColor: const Color.fromARGB(255, 144, 77, 48),
    scaffoldBackgroundColor: Colors.white,
    fontFamily: 'Satoshi',
  );

  static ThemeData dark = ThemeData(
    brightness: Brightness.dark,
    primaryColor: const Color.fromARGB(255, 188, 118, 88),
    scaffoldBackgroundColor: Colors.black,
    fontFamily: 'Satoshi',
  );
}
