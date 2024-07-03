import 'package:flutter/material.dart';
import '../../domain/repo/theme_repo.dart';
import '../data_source/theme_data_source.dart';

class ThemeRepoImpl implements ThemeRepo {
  final ThemeDataSource _dataSource;

  ThemeRepoImpl(this._dataSource);

  @override
  ThemeMode getAppTheme() => _dataSource.getAppTheme();

  @override
  Future<void> setAppTheme({required ThemeMode theme}) =>
      _dataSource.setAppTheme(theme: theme);
}
