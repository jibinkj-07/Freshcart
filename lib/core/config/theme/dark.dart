import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../config_helper.dart';
import '../route/custom_page_transition.dart';

sealed class DarkTheme {
  static const Color bgColor = Color(0xFF121414);
  static const Color _surfaceColor = Color(0xFF2E2F33);
  static final Color _primaryColor = ConfigHelper.appColor;

  static final schema = ThemeData(
    useMaterial3: true,
    fontFamily: ConfigHelper.fontFamily,
    scaffoldBackgroundColor: bgColor,
    primaryColor: Colors.white,
    colorScheme: ColorScheme.fromSeed(
      seedColor: _primaryColor,
      surface: _surfaceColor,
      onSurface: Colors.white,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: bgColor,
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
        backgroundColor: Colors.amber.shade200,
        foregroundColor: Colors.black,
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: ConfigHelper.appColor,
      ),
    ),
    listTileTheme: ListTileThemeData(
      titleTextStyle: TextStyle(
        inherit: true,
        color: Colors.white,
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
    datePickerTheme: DatePickerThemeData(
      backgroundColor: _surfaceColor,
      headerForegroundColor: Colors.white,
      yearForegroundColor: WidgetStateColor.resolveWith(
        (states) =>
            states.contains(WidgetState.selected) ? Colors.white : Colors.grey,
      ),
      todayForegroundColor:
          WidgetStateColor.resolveWith((_) => Colors.amber.shade100),
    ),
    pageTransitionsTheme: PageTransitionsTheme(
      builders: {
        TargetPlatform.android: CustomPageTransitionBuilder(),
        TargetPlatform.iOS: CustomPageTransitionBuilder(),
      },
    ),
  );
}
