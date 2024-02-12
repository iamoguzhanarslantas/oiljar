import 'package:flutter/material.dart';

import 'package:oiljar/src/utils/utils.dart' show AppColors;

class AppThemes {
  static final ThemeData lightTheme = ThemeData(
    primaryColorLight: AppColors.lightThemeLightShade,
    primaryColorDark: AppColors.lightThemeDarkShade,
    appBarTheme: const AppBarTheme(
      iconTheme: IconThemeData(
        color: Colors.black,
      ),
      elevation: 0,
      centerTitle: true,
      backgroundColor: Colors.white,
      titleTextStyle: TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.bold,
        fontSize: 24,
      ),
    ),
    scaffoldBackgroundColor: Colors.white,
    dividerColor: AppColors.lightThemeLightShade,
    brightness: Brightness.light,
    useMaterial3: true,
    textTheme: const TextTheme().copyWith(
      bodyMedium: const TextStyle(
        fontWeight: FontWeight.bold,
        color: Colors.black,
      ),
    ),
  );
  static final ThemeData darkTheme = ThemeData(
    primaryColorLight: AppColors.darkThemeLightShade,
    primaryColorDark: AppColors.darkThemeDarkShade,
    appBarTheme: const AppBarTheme(
      iconTheme: IconThemeData(
        color: Colors.white,
      ),
      elevation: 0,
      centerTitle: true,
      backgroundColor: Colors.black,
      titleTextStyle: TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.bold,
        fontSize: 24,
      ),
    ),
    scaffoldBackgroundColor: Colors.black,
    dividerColor: AppColors.darkThemeLightShade,
    brightness: Brightness.dark,
    useMaterial3: true,
    textTheme: const TextTheme().copyWith(
      bodyMedium: const TextStyle(
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
    ),
  );
  static final ThemeData theme = ThemeData(
    useMaterial3: true,
    primaryColor: Colors.blue[900],
  );
}
