part of 'theme_bloc.dart';

class ThemeState extends Equatable {
  final Themes selectedTheme;

  const ThemeState({Themes? theme}) : selectedTheme = theme ?? Themes.system;
  @override
  List<Object?> get props => [selectedTheme];
  
  ThemeState copyWith({Themes? selectedTheme}) {
    return ThemeState(theme: selectedTheme ?? this.selectedTheme);
  }
}

final class ThemeChangedSuccess extends ThemeEvent {
  final Themes selectedTheme;

  const ThemeChangedSuccess({required this.selectedTheme});
}
