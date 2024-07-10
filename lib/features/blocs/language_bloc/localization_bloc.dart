import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:practical_pachprthlo/features/data/models/a-language_model/language_model.dart';
import 'package:practical_pachprthlo/packages/shared_preferences/my_shared_preferences.dart';
import 'package:practical_pachprthlo/packages/shared_preferences/my_shared_preferences_const.dart';

part 'localization_event.dart';
part 'localization_state.dart';

class LocalizationBloc extends Bloc<LocalizationEvent, LocalizationState> {
  LocalizationBloc() : super(const LocalizationState()) {
    on<ChangeLocalization>(_onChangeLanguage);
    on<GetLocalization>(_onGetLanguage);
    on<ResetLocalization>(_onResetLocalization);
  }

  _onChangeLanguage(ChangeLocalization event, Emitter<LocalizationState> emit) async {
    await MySharedPreferences.instance.storeToSharedPreferences(languageKey, event.selectedLanguage.locale.languageCode);
    emit((state.copyWith(selectedLanguage: event.selectedLanguage)));
  }

  _onResetLocalization(ResetLocalization event, Emitter<LocalizationState> emit) async {
    await MySharedPreferences.instance.removeFromSharedPreferences(event.key);
    emit((state.copyWith(selectedLanguage: Languages.persian)));
  }

  _onGetLanguage(GetLocalization event, Emitter<LocalizationState> emit) async {
    final String? selectedLanguage = await MySharedPreferences.instance.getFromSharedPreferences(languageKey);
    emit(
      state.copyWith(
        selectedLanguage: selectedLanguage != null
            ? Languages.values.firstWhere((element) => element.locale.languageCode == selectedLanguage, orElse: () => Languages.persian)
            : Languages.persian,
      ),
    );
  }
}
