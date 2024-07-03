import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../../../../core/config/hive/hive_keys.dart';

abstract class ThemeDataSource {
  ThemeMode getAppTheme();

  Future<void> setAppTheme({required ThemeMode theme});
}

class ThemeDataSourceImpl implements ThemeDataSource {
  final Box<ThemeMode> _themeBox;

  ThemeDataSourceImpl(this._themeBox);

  @override
  ThemeMode getAppTheme() =>
      _themeBox.get(HiveKeys.themeKey) ?? ThemeMode.system;

  @override
  Future<void> setAppTheme({required ThemeMode theme}) async {
    await _themeBox.put(HiveKeys.themeKey, theme);
  }
}
