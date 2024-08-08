import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../config_helper.dart';
import '../route/custom_page_transition.dart';

sealed class DarkTheme {
  static const Color _bgColor = Color(0xFF121414);
  static const Color _surfaceColor = Color(0xFF2E2F33);
  static const Color _primaryColor = Colors.amber;

  static final schema = ThemeData(
    useMaterial3: true,
    fontFamily: ConfigHelper.fontFamily,
    scaffoldBackgroundColor: _bgColor,
    primaryColor: Colors.white,
    colorScheme: ColorScheme.fromSeed(
      seedColor: _primaryColor,
      surface: _surfaceColor,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: _bgColor,
      foregroundColor: Colors.white,
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarBrightness: Brightness.dark,
      ),
    ),
    textTheme: TextTheme(
      bodySmall: TextStyle(
        inherit: true,
        color: Colors.white,
        fontFamily: ConfigHelper.fontFamily,
      ),
      bodyMedium: TextStyle(
        inherit: true,
        color: Colors.white,
        fontFamily: ConfigHelper.fontFamily,
      ),
      bodyLarge: TextStyle(
        inherit: true,
        color: Colors.white,
        fontFamily: ConfigHelper.fontFamily,
      ),
    ),
    filledButtonTheme: FilledButtonThemeData(
      style: FilledButton.styleFrom(
        backgroundColor: _primaryColor,
        foregroundColor: Colors.black,
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: Colors.amber,
      ),
    ),
    pageTransitionsTheme: PageTransitionsTheme(
      builders: {
        TargetPlatform.android: CustomPageTransitionBuilder(),
        TargetPlatform.iOS: CustomPageTransitionBuilder(),
      },
    ),
  );
}
