import 'package:flutter/material.dart';
import '../route/custom_page_transition.dart';

abstract final class LightTheme {
  static const Color _bgColor = Color(0xFFF5F5FA);
  static const Color _surfaceColor = Color(0xFFDFE2EB);
  static const String _fontFamily = "Poppins";

  static final schema = ThemeData(
    useMaterial3: true,
    fontFamily: _fontFamily,
    scaffoldBackgroundColor: _bgColor,
    colorScheme: ColorScheme.fromSeed(seedColor: Colors.amber),
    appBarTheme: const AppBarTheme(
      backgroundColor: _bgColor,
      foregroundColor: Colors.black,
    ),
    textTheme: const TextTheme(
      bodySmall: TextStyle(
          inherit: true, color: Colors.black, fontFamily: _fontFamily),
      bodyMedium: TextStyle(
          inherit: true, color: Colors.black, fontFamily: _fontFamily),
      bodyLarge: TextStyle(
          inherit: true, color: Colors.black, fontFamily: _fontFamily),
    ),
    pageTransitionsTheme: PageTransitionsTheme(
      builders: {
        TargetPlatform.android: CustomPageTransitionBuilder(),
        TargetPlatform.iOS: CustomPageTransitionBuilder(),
      },
    ),
  );
}
