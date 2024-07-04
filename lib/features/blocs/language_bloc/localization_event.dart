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

class GetLocalization extends LocalizationEvent {}
