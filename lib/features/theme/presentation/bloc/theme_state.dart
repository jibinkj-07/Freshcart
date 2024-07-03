part of 'theme_bloc.dart';

@immutable
class ThemeState {
  final ThemeMode themeMode;

  const ThemeState({required this.themeMode});
}

final class ThemeInitial extends ThemeState {
  const ThemeInitial() : super(themeMode: ThemeMode.system);
}
