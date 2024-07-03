import 'package:flutter/material.dart';
import '../route/custom_page_transition.dart';

abstract final class DarkTheme {
  static const Color _bgColor = Color(0xFF121414);
  static const Color _surfaceColor = Color(0xFF31343B);
  static const String _fontFamily = "Poppins";

  static final schema = ThemeData(
    useMaterial3: true,
    fontFamily: _fontFamily,
    scaffoldBackgroundColor: _bgColor,
    colorScheme: ColorScheme.fromSeed(seedColor: Colors.amber),
    appBarTheme: const AppBarTheme(
      backgroundColor: _bgColor,
      foregroundColor: Colors.white,
    ),
    textTheme: const TextTheme(
      bodySmall: TextStyle(
          inherit: true, color: Colors.white, fontFamily: _fontFamily),
      bodyMedium: TextStyle(
          inherit: true, color: Colors.white, fontFamily: _fontFamily),
      bodyLarge: TextStyle(
          inherit: true, color: Colors.white, fontFamily: _fontFamily),
    ),
    pageTransitionsTheme: PageTransitionsTheme(
      builders: {
        TargetPlatform.android: CustomPageTransitionBuilder(),
        TargetPlatform.iOS: CustomPageTransitionBuilder(),
      },
    ),
  );
}
