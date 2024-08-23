import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../app_config.dart';
import '../route/custom_page_transition.dart';

sealed class LightTheme {
  static const Color _bgColor = Color(0xFFF5F5FA);
  static final Color _primaryColor = AppConfig.appColor;
  static const Color _surfaceColor = Color(0xFFE9E9F5);

  static final schema = ThemeData(
    useMaterial3: true,
    fontFamily: AppConfig.fontFamily,
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
        fontFamily: AppConfig.fontFamily,
      ),
      bodyMedium: TextStyle(
        inherit: true,
        color: Colors.black,
        fontFamily: AppConfig.fontFamily,
      ),
      bodyLarge: TextStyle(
        inherit: true,
        color: Colors.black,
        fontFamily: AppConfig.fontFamily,
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: AppConfig.appColor,
      ),
    ),
    filledButtonTheme: FilledButtonThemeData(
      style: FilledButton.styleFrom(
        backgroundColor: Colors.amber.shade200,
        foregroundColor: Colors.black,
      ),
    ),
    listTileTheme: ListTileThemeData(
      titleTextStyle: TextStyle(
        inherit: true,
        color: Colors.black,
        fontWeight: FontWeight.w500,
        fontFamily: AppConfig.fontFamily,
      ),
      subtitleTextStyle: TextStyle(
        inherit: true,
        color: Colors.grey,
        fontFamily: AppConfig.fontFamily,
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
