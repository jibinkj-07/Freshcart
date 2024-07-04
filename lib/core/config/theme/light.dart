import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../route/custom_page_transition.dart';

sealed class LightTheme {
  static const Color _bgColor = Color(0xFFF5F5FA);
  static const Color _primaryColor = Colors.amber;
  static const Color _surfaceColor = Color(0xFFDFE2EB);
  static const String _fontFamily = "Poppins";

  static final schema = ThemeData(
    useMaterial3: true,
    fontFamily: _fontFamily,
    scaffoldBackgroundColor: _bgColor,
    colorScheme: ColorScheme.fromSeed(seedColor: _primaryColor),
    appBarTheme: const AppBarTheme(
      backgroundColor: _bgColor,
      foregroundColor: Colors.black,
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarBrightness: Brightness.light,
      ),
    ),
    textTheme: const TextTheme(
      bodySmall: TextStyle(
          inherit: true, color: Colors.black, fontFamily: _fontFamily),
      bodyMedium: TextStyle(
          inherit: true, color: Colors.black, fontFamily: _fontFamily),
      bodyLarge: TextStyle(
          inherit: true, color: Colors.black, fontFamily: _fontFamily),
    ),
    filledButtonTheme: FilledButtonThemeData(
      style: FilledButton.styleFrom(
        backgroundColor: _primaryColor,
        foregroundColor: Colors.black,
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
