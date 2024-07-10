part of 'localization_bloc.dart';

sealed class LocalizationEvent extends Equatable {
  const LocalizationEvent();

  @override
  List<Object> get props => [];
}

class ChangeLocalization extends LocalizationEvent {
  final Languages selectedLanguage;

  const ChangeLocalization({required this.selectedLanguage});

  @override
  List<Object> get props => [selectedLanguage];
}

class ResetLocalization extends LocalizationEvent {
  final String key;

  const ResetLocalization({required this.key});
  @override
  List<Object> get props => [key];
}

class GetLocalization extends LocalizationEvent {}
