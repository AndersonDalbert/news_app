import 'package:flutter/material.dart';

final ThemeData appTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: Colors.deepPurple,
    canvasColor: Colors.grey[100],
    accentColor: Color(0xFF9b0000),
    fontFamily: 'Roboto',
    textTheme: TextTheme(
      headline1: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
      headline2: TextStyle(
        fontSize: 26,
        fontFamily: 'Poppins-Medium',
        fontWeight: FontWeight.bold,
        letterSpacing: 1,
      ),
      headline3: TextStyle(
        fontSize: 16,
        fontFamily: 'Poppins-Medium',
        fontWeight: FontWeight.w500,
        letterSpacing: 0.8,
      ),
      subtitle1: TextStyle(
        fontSize: 18,
        fontFamily: 'Poppins-Medium',
        fontWeight: FontWeight.w300,
        color: Colors.black87,
        letterSpacing: 1.0,
      ),
      bodyText1: TextStyle(fontSize: 20, color: Colors.black87),
      bodyText2: TextStyle(fontSize: 16, color: Colors.black87),
      button: TextStyle(
        fontSize: 14,
        fontFamily: 'Poppins-Medium',
        color: Colors.white,
      ),
    ));
