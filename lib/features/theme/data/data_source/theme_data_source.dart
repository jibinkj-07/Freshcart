import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../../../../core/config/hive/hive_keys.dart';

abstract class ThemeDataSource {
  ThemeMode getAppTheme();

  Future<void> setAppTheme({required ThemeMode theme});
}

class ThemeDataSourceImpl implements ThemeDataSource {
  final Box<String> _themeBox;

  ThemeDataSourceImpl(this._themeBox);

  @override
  ThemeMode getAppTheme() {
    final mode = _themeBox.get(HiveKeys.themeKey, defaultValue: 'system');
    switch (mode) {
      case 'light':
        return ThemeMode.light;
      case 'dark':
        return ThemeMode.dark;
      default:
        return ThemeMode.system;
    }
  }

  @override
  Future<void> setAppTheme({required ThemeMode theme}) async {
    switch (theme) {
      case ThemeMode.light:
        await _themeBox.put(HiveKeys.themeKey, 'light');
        break;
      case ThemeMode.dark:
        await _themeBox.put(HiveKeys.themeKey, 'dark');
        break;
      default:
        await _themeBox.put(HiveKeys.themeKey, 'system');
    }
  }
}
