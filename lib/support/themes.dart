import 'package:flutter/material.dart';

class MyThemes {
  static getLightTheme() {
    return ThemeData(
      primarySwatch: Colors.blue,
    );
  }

  static getDarkTheme() {
    return ThemeData(
      primarySwatch: Colors.green,
    );
  }
}
