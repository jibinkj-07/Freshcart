import 'package:flutter/material.dart';

abstract class ThemeRepo {
  ThemeMode getAppTheme();

  Future<void> setAppTheme({required ThemeMode theme});
}
