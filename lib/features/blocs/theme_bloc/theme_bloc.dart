import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:practical_pachprthlo/features/data/models/b-theme_model/theme_model.dart';
import 'package:practical_pachprthlo/packages/shared_preferences/my_shared_preferences.dart';
import 'package:practical_pachprthlo/packages/shared_preferences/my_shared_preferences_const.dart';

part 'theme_event.dart';
part 'theme_state.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  ThemeBloc() : super(const ThemeState()) {
    on<ChangeThemeMode>(_onChangeThemeMode);
    on<GetTheme>(_onGetTheme);
    on<ResetThemeMode>(_onResetThemeMode);
  }
  _onChangeThemeMode(ChangeThemeMode event, Emitter<ThemeState> emit) async {
    await MySharedPreferences.instance.storeToSharedPreferences(themeKey, event.selectedTheme.name);
    emit((state.copyWith(selectedTheme: event.selectedTheme)));
  }

  _onResetThemeMode(ResetThemeMode event, Emitter<ThemeState> emit) async {
    await MySharedPreferences.instance.removeFromSharedPreferences(event.key);
    emit((state.copyWith(selectedTheme: Themes.system)));
  }

  _onGetTheme(GetTheme event, Emitter<ThemeState> emit) async {
    final String? selectedTheme = await MySharedPreferences.instance.getFromSharedPreferences(themeKey);
    emit(
      state.copyWith(
        selectedTheme: selectedTheme != null ? Themes.values.where((element) => element.name == selectedTheme).toList().first : Themes.system,
      ),
    );
  }
}
