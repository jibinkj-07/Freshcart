import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import '../../domain/repo/theme_repo.dart';

part 'theme_event.dart';

part 'theme_state.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  final ThemeRepo _themeRepo;

  ThemeBloc(this._themeRepo) : super(const ThemeInitial()) {
    on<ThemeEvent>((event, emit) async {
      /// Getting stored app theme from local db
      if (event is GetAppTheme) {
        emit(ThemeState(themeMode: _themeRepo.getAppTheme()));
      }

      /// Storing updated app theme into local db
      if (event is SetAppTheme) {
        emit(ThemeState(themeMode: event.theme));
        await _themeRepo.setAppTheme(theme: event.theme);
      }
    });
  }
}
