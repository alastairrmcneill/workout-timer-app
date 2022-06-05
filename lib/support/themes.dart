import 'package:flutter/material.dart';

class MyThemes {
  static getLightTheme() {
    Color backgroundColor = const Color(0xFF1a2432);
    Color accentColor = Color.fromARGB(255, 208, 215, 229);
    return ThemeData(
      primarySwatch: Colors.orange,
      cardColor: const Color(0xFF293345),
      cardTheme: CardTheme(color: Color(0xFF293345)),
      indicatorColor: Colors.orange,
      appBarTheme: AppBarTheme(
        backgroundColor: backgroundColor,
        elevation: 0,
        foregroundColor: accentColor,
        titleTextStyle: TextStyle(
          fontSize: 30,
          fontFamily: 'Open Sans',
          fontWeight: FontWeight.w400,
          color: accentColor,
        ),
      ),
      iconTheme: IconThemeData(color: accentColor),
      scaffoldBackgroundColor: backgroundColor,
      listTileTheme: ListTileThemeData(
        textColor: accentColor,
      ),
      dividerColor: accentColor,
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
            minimumSize: MaterialStateProperty.all<Size>(Size(150, 50)),
            backgroundColor: MaterialStateProperty.all<Color>(Colors.black.withOpacity(0)),
            shape: MaterialStateProperty.all<OutlinedBorder>(RoundedRectangleBorder(borderRadius: BorderRadius.circular(25))),
            padding: MaterialStateProperty.all<EdgeInsetsGeometry>(EdgeInsets.symmetric(horizontal: 20, vertical: 5))),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: ButtonStyle(
          foregroundColor: MaterialStateProperty.all<Color>(Colors.orangeAccent),
          side: MaterialStateProperty.all<BorderSide>(
            BorderSide(width: 2.0, color: Colors.orangeAccent),
          ),
          shape: MaterialStateProperty.all<OutlinedBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25),
            ),
          ),
          minimumSize: MaterialStateProperty.all<Size>(
            Size(120, 50),
          ),
          textStyle: MaterialStateProperty.all<TextStyle>(
            TextStyle(
              fontSize: 18,
              fontFamily: 'Open Sans',
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ),
      textTheme: TextTheme(
        headline3: TextStyle(
          fontSize: 64,
          fontFamily: 'Open Sans',
          fontWeight: FontWeight.w200,
          color: accentColor,
        ),
        headline4: TextStyle(
          fontSize: 30,
          fontFamily: 'Open Sans',
          fontWeight: FontWeight.w400,
          color: accentColor,
        ),
        headline5: TextStyle(
          fontSize: 18,
          fontFamily: 'Open Sans',
          fontWeight: FontWeight.w400,
          color: accentColor,
        ),
        headline6: TextStyle(
          fontSize: 16,
          fontFamily: 'Open Sans',
          fontWeight: FontWeight.w400,
          color: accentColor,
        ),
        bodyText1: TextStyle(
          fontSize: 24,
          fontFamily: 'Open Sans',
          fontWeight: FontWeight.w400,
          color: Color.fromARGB(255, 63, 77, 104),
        ),
      ),
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
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
            shape: MaterialStateProperty.all<OutlinedBorder>(RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))),
            padding: MaterialStateProperty.all<EdgeInsetsGeometry>(EdgeInsets.symmetric(horizontal: 20, vertical: 5))),
      ),
      textTheme: TextTheme(
        headline3: TextStyle(
          fontSize: 140,
          fontFamily: 'Roboto',
          fontWeight: FontWeight.w200,
          color: Colors.orange,
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
