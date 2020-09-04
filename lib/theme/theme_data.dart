import 'package:flutter/material.dart';

ThemeData themeData(BuildContext context) {
  return ThemeData(
    primaryColor: Color(0xff0F528A),
    accentColor: Colors.white,
    scaffoldBackgroundColor: Colors.white,
    backgroundColor: Colors.white,
    fontFamily: 'Ubuntu',
    textTheme: TextTheme(
      //confirmed top text
      headline1: TextStyle(
        fontSize: 11,
        color: Colors.red,
        fontWeight: FontWeight.bold,
      ),
      //recovered top text
      headline2: TextStyle(
        fontSize: 11,
        color: Colors.green,
        fontWeight: FontWeight.bold,
      ),
      //deaths top text
      headline3: TextStyle(
        fontSize: 11,
        color: Colors.deepPurple,
        fontWeight: FontWeight.bold,
      ),
      //confirmed number
      headline4: TextStyle(
        fontSize: 16,
        color: Colors.red,
        fontWeight: FontWeight.bold,
      ),
      //recovered number
      headline5: TextStyle(
        fontSize: 16,
        color: Colors.green,
        fontWeight: FontWeight.bold,
      ),
      //deaths number
      headline6: TextStyle(
        fontSize: 16,
        color: Colors.deepPurple,
        fontWeight: FontWeight.bold,
      ),
    ),
  );
}
