import 'package:flutter/material.dart';

class AppTheme {
  static final ThemeData lightTheme = ThemeData(
      scaffoldBackgroundColor: Colors.white,
      primaryColor: Colors.blue[500],
      canvasColor: Colors.white,
      appBarTheme: AppBarTheme(
          color: Colors.blue[500],
          iconTheme: const IconThemeData(color: Colors.white)),
      iconTheme: IconThemeData(color: Colors.blue[400]),
      textTheme: TextTheme(
          bodyText1: TextStyle(
            color: Colors.grey[800],
          ),
          bodyText2: TextStyle(color: Colors.grey[800]),
          headline4: TextStyle(color: Colors.grey[900])),
      unselectedWidgetColor: Colors.blue[400],
      buttonTheme: const ButtonThemeData(
          buttonColor: Colors.blueAccent, textTheme: ButtonTextTheme.primary));

  static final ThemeData darkTheme = ThemeData(
      scaffoldBackgroundColor: Colors.grey[700],
      canvasColor: Colors.grey[800],
      toggleableActiveColor: Colors.grey[300],
      appBarTheme: AppBarTheme(
          color: Colors.grey[900],
          iconTheme: IconThemeData(color: Colors.grey[100])),
      iconTheme: IconThemeData(color: Colors.grey[300]),
      textTheme: TextTheme(
          bodyText1: TextStyle(
            color: Colors.grey[100],
          ),
          bodyText2: TextStyle(color: Colors.grey[100]),
          headline4: TextStyle(color: Colors.grey[50])),
      unselectedWidgetColor: Colors.grey[300],
      dividerColor: Colors.grey[500],
      buttonTheme: ButtonThemeData(
          buttonColor: Colors.grey[900], textTheme: ButtonTextTheme.primary));
}
