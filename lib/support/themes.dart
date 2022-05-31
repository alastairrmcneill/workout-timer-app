import 'package:flutter/material.dart';

class MyThemes {
  static getLightTheme() {
    return ThemeData(
      primarySwatch: Colors.blue,
    );
  }

  static getDarkTheme() {
    Color backgroundColor = const Color(0xFF30505C);
    Color accentColor = const Color(0xFFD1DEE3);
    return ThemeData(
      primarySwatch: Colors.deepOrange,
      cardColor: const Color(0xFF546f79),
      appBarTheme: AppBarTheme(
        backgroundColor: backgroundColor,
        elevation: 0,
        foregroundColor: accentColor,
      ),
      scaffoldBackgroundColor: backgroundColor,
      listTileTheme: ListTileThemeData(
        textColor: accentColor,
      ),
      dividerColor: accentColor,
      textTheme: TextTheme(
        headline4: TextStyle(
          fontSize: 24,
          fontFamily: 'Roboto',
          fontWeight: FontWeight.w400,
          color: accentColor,
        ),
        headline5: TextStyle(
          fontSize: 14,
          fontFamily: 'Roboto',
          fontWeight: FontWeight.w400,
          color: accentColor,
        ),
        headline6: const TextStyle(
          fontSize: 30,
          fontFamily: 'Roboto',
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }
}
