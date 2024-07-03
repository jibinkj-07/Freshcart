part of 'theme_bloc.dart';

@immutable
sealed class ThemeEvent {}

class GetAppTheme extends ThemeEvent {}

class SetAppTheme extends ThemeEvent {
  final ThemeMode theme;

  SetAppTheme({required this.theme});
}
