part of 'diseases_bloc.dart';

sealed class DiseasesEvent extends Equatable {
  const DiseasesEvent();

  @override
  List<Object> get props => [];
}

final class FetchDiseases extends DiseasesEvent {}

final class LoadMoreDiseasesRequested extends DiseasesEvent {}
