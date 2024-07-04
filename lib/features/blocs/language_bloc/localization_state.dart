part of 'localization_bloc.dart';

class LocalizationState extends Equatable {
  final Languages selectedLanguage;
  const LocalizationState({Languages? language}) : selectedLanguage = language ?? Languages.persian;

  @override
  List<Object> get props => [selectedLanguage];

  LocalizationState copyWith({Languages? selectedLanguage}) {
    return LocalizationState(language: selectedLanguage ?? this.selectedLanguage);
  }
}

final class LocalizationChanged extends LocalizationEvent {
  final Languages selectedLanguage;

  const LocalizationChanged({required this.selectedLanguage});
}
