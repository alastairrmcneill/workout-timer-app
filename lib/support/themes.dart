import 'package:flutter/material.dart';

class MyThemes {
  static getLightTheme() {
    return ThemeData(
      primarySwatch: Colors.blue,
    );
  }

  static getDarkTheme() {
    Color backgroundColor = const Color(0xFF30505C);
    Color accentColor = const Color.fromARGB(255, 222, 235, 241);
    return ThemeData(
      primarySwatch: Colors.orange,
      cardColor: const Color(0xFF546f79),
      indicatorColor: Colors.orange,
      appBarTheme: AppBarTheme(
        backgroundColor: backgroundColor,
        elevation: 0,
        foregroundColor: accentColor,
        titleTextStyle: TextStyle(fontSize: 30, fontFamily: 'Roboto', fontWeight: FontWeight.w400, color: accentColor),
      ),
      scaffoldBackgroundColor: backgroundColor,
      listTileTheme: ListTileThemeData(
        textColor: accentColor,
      ),
      dividerColor: accentColor,
      textTheme: TextTheme(
        headline3: TextStyle(
          fontSize: 140,
          fontFamily: 'Roboto',
          fontWeight: FontWeight.w200,
          color: accentColor,
        ),
        headline4: TextStyle(
          fontSize: 30,
          fontFamily: 'Roboto',
          fontWeight: FontWeight.w400,
          color: accentColor,
        ),
        headline5: TextStyle(
          fontSize: 18,
          fontFamily: 'Roboto',
          fontWeight: FontWeight.w400,
          color: accentColor,
        ),
        headline6: TextStyle(
          fontSize: 14,
          fontFamily: 'Roboto',
          fontWeight: FontWeight.w400,
          color: accentColor,
        ),
      ),
    );
  }
}
