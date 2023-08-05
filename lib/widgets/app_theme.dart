import 'package:flutter/material.dart';

final ThemeData appTheme = ThemeData(
  primarySwatch: Colors.brown,
  textTheme: TextTheme(
    headline1: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
    headline2: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
    bodyText1: TextStyle(fontSize: 16, fontWeight: FontWeight.normal),
  ),
  appBarTheme: AppBarTheme(
    centerTitle: true,
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      primary: Colors.brown,
      textStyle: TextStyle(fontSize: 16),
      padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
    ),
  ),
);
