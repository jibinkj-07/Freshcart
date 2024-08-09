import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../config_helper.dart';
import '../route/custom_page_transition.dart';

sealed class LightTheme {
  static const Color _bgColor = Color(0xFFF5F5FA);
  static const Color _primaryColor = Colors.amber;
  static const Color _surfaceColor = Color(0xFFF2F5FC);

  static final schema = ThemeData(
    useMaterial3: true,
    fontFamily: ConfigHelper.fontFamily,
    primaryColor: Colors.black,
    scaffoldBackgroundColor: _bgColor,
    colorScheme: ColorScheme.fromSeed(
      seedColor: _primaryColor,
      surface: _surfaceColor,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: _bgColor,
      foregroundColor: Colors.black,
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarBrightness: Brightness.light,
      ),
    ),
    textTheme: TextTheme(
      bodySmall: TextStyle(
        inherit: true,
        color: Colors.black,
        fontFamily: ConfigHelper.fontFamily,
      ),
      bodyMedium: TextStyle(
        inherit: true,
        color: Colors.black,
        fontFamily: ConfigHelper.fontFamily,
      ),
      bodyLarge: TextStyle(
        inherit: true,
        color: Colors.black,
        fontFamily: ConfigHelper.fontFamily,
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: Colors.amber,
      ),
    ),
    filledButtonTheme: FilledButtonThemeData(
      style: FilledButton.styleFrom(
        backgroundColor: _primaryColor,
        foregroundColor: Colors.black,
      ),
    ),
    listTileTheme: ListTileThemeData(
      titleTextStyle: TextStyle(
        inherit: true,
        color: Colors.black,
        fontWeight: FontWeight.w500,
        fontFamily: ConfigHelper.fontFamily,
      ),
      subtitleTextStyle: TextStyle(
        inherit: true,
        color: Colors.grey,
        fontFamily: ConfigHelper.fontFamily,
        fontSize: 13.0,
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
