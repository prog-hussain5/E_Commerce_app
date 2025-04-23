import 'package:flutter/material.dart';

class AppTheme {
  // ألوان الثيم الفاتح
  static final Color _lightPrimaryColor = Colors.teal;
  static final Color _lightAccentColor = Colors.tealAccent;
  static final Color _lightBackgroundColor = Colors.white;
  static final Color _lightTextColor = Colors.black87;
  static final Color _lightIconColor = Colors.black54;
  static final Color _lightCardColor = Colors.white;
  static final Color _lightDividerColor = Colors.grey.shade300;

  // ألوان الثيم المظلم
  static final Color _darkPrimaryColor = Colors.teal.shade700;
  static final Color _darkAccentColor = Colors.tealAccent.shade400;
  static final Color _darkBackgroundColor = Color(0xFF121212);
  static const Color _darkTextColor = Colors.white;
  static final Color _darkIconColor = Colors.white70;
  static final Color _darkCardColor = Color(0xFF1E1E1E);
  static final Color _darkDividerColor = Colors.grey.shade800;

  // الثيم الفاتح
  static final ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: _lightPrimaryColor,
    colorScheme: ColorScheme.light(
      primary: _lightPrimaryColor,
      secondary: _lightAccentColor,
      background: _lightBackgroundColor,
    ),
    scaffoldBackgroundColor: _lightBackgroundColor,
    appBarTheme: AppBarTheme(
      backgroundColor: _lightPrimaryColor,
      foregroundColor: Colors.white,
      elevation: 0,
    ),
    cardTheme: CardTheme(
      color: _lightCardColor,
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    ),
    iconTheme: IconThemeData(color: _lightIconColor),
    textTheme: TextTheme(
      displayLarge: TextStyle(color: _lightTextColor, fontFamily: 'Cairo'),
      displayMedium: TextStyle(color: _lightTextColor, fontFamily: 'Cairo'),
      displaySmall: TextStyle(color: _lightTextColor, fontFamily: 'Cairo'),
      headlineMedium: TextStyle(color: _lightTextColor, fontFamily: 'Cairo'),
      headlineSmall: TextStyle(color: _lightTextColor, fontFamily: 'Cairo'),
      titleLarge: TextStyle(color: _lightTextColor, fontFamily: 'Cairo'),
      bodyLarge: TextStyle(color: _lightTextColor, fontFamily: 'Cairo'),
      bodyMedium: TextStyle(color: _lightTextColor, fontFamily: 'Cairo'),
    ),
    dividerTheme: DividerThemeData(color: _lightDividerColor),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: _lightCardColor,
      selectedItemColor: _lightPrimaryColor,
      unselectedItemColor: _lightIconColor,
    ),
    buttonTheme: ButtonThemeData(
      buttonColor: _lightPrimaryColor,
      textTheme: ButtonTextTheme.primary,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: _lightPrimaryColor,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    ),
    useMaterial3: true,
  );

  // الثيم المظلم
  static final ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: _darkPrimaryColor,
    colorScheme: ColorScheme.dark(
      primary: _darkPrimaryColor,
      secondary: _darkAccentColor,
      surface: _darkBackgroundColor,
    ),
    scaffoldBackgroundColor: _darkBackgroundColor,
    appBarTheme: AppBarTheme(
      backgroundColor: _darkCardColor,
      foregroundColor: _darkTextColor,
      elevation: 0,
    ),
    cardTheme: CardTheme(
      color: _darkCardColor,
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    ),
    iconTheme: IconThemeData(color: _darkIconColor),
    textTheme: const TextTheme(
      displayLarge: TextStyle(color: _darkTextColor, fontFamily: 'Cairo'),
      displayMedium: TextStyle(color: _darkTextColor, fontFamily: 'Cairo'),
      displaySmall: TextStyle(color: _darkTextColor, fontFamily: 'Cairo'),
      headlineMedium: TextStyle(color: _darkTextColor, fontFamily: 'Cairo'),
      headlineSmall: TextStyle(color: _darkTextColor, fontFamily: 'Cairo'),
      titleLarge: TextStyle(color: _darkTextColor, fontFamily: 'Cairo'),
      bodyLarge: TextStyle(color: _darkTextColor, fontFamily: 'Cairo'),
      bodyMedium: TextStyle(color: _darkTextColor, fontFamily: 'Cairo'),
    ),
    dividerTheme: DividerThemeData(color: _darkDividerColor),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: _darkCardColor,
      selectedItemColor: _darkAccentColor,
      unselectedItemColor: _darkIconColor,
    ),
    buttonTheme: ButtonThemeData(
      buttonColor: _darkPrimaryColor,
      textTheme: ButtonTextTheme.primary,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: _darkPrimaryColor,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    ),
    useMaterial3: true,
  );
}