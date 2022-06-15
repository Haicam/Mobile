import 'package:flutter/material.dart';
import 'package:prac_haicam/core/utils/app_colors.dart';

class AppTheme {
  static final ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    appBarTheme: const AppBarTheme(
      titleTextStyle: TextStyle(
        color: AppColors.primary,
      ),
    ),
  );

  static final ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
  );
}
