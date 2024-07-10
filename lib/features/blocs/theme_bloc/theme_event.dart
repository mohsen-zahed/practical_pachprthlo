part of 'theme_bloc.dart';

sealed class ThemeEvent extends Equatable {
  const ThemeEvent();

  @override
  List<Object> get props => [];
}

class ChangeThemeMode extends ThemeEvent {
  final Themes selectedTheme;

  const ChangeThemeMode({required this.selectedTheme});
  @override
  List<Object> get props => [selectedTheme];
}

class ResetThemeMode extends ThemeEvent {
  final String key;

  const ResetThemeMode({required this.key});

  @override
  List<Object> get props => [key];
}

final class GetTheme extends ThemeEvent {}
