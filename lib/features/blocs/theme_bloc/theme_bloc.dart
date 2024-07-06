import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:practical_pachprthlo/features/data/models/b-theme_model/theme_model.dart';
import 'package:practical_pachprthlo/packages/shared_preferences/my_shared_preferences.dart';

part 'theme_event.dart';
part 'theme_state.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  ThemeBloc() : super(const ThemeState()) {
    on<ChangeThemeMode>(_onChangeThemeMode);
    on<GetTheme>(_onGetTheme);
  }
  _onChangeThemeMode(ChangeThemeMode event, Emitter<ThemeState> emit) async {
    await MySharedPreferences.instance.storeTheme(event.selectedTheme.themeMode.name);
    emit((state.copyWith(selectedTheme: event.selectedTheme)));
  }

  _onGetTheme(GetTheme event, Emitter<ThemeState> emit) async {
    final String? selectedTheme = await MySharedPreferences.instance.getTheme();
    emit(state.copyWith(selectedTheme: Themes.values.where((element) => element.themeMode.name == selectedTheme).first));
  }
}
