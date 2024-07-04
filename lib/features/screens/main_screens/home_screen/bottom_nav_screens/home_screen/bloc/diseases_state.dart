part of 'diseases_bloc.dart';

sealed class DiseasesState extends Equatable {
  const DiseasesState();

  @override
  List<Object> get props => [];
}

final class DiseasesLoading extends DiseasesState {}

final class DiseasesSuccess extends DiseasesState {
  final DiseaseResponseModel diseaseModelList;

  const DiseasesSuccess({required this.diseaseModelList});

  @override
  List<Object> get props => [diseaseModelList];
}

final class DiseasesFailed extends DiseasesState {
  final String errorMessage;

  const DiseasesFailed({required this.errorMessage});

  @override
  List<Object> get props => [errorMessage];
}

final class LoadMoreDiseasesFailed extends DiseasesState {
  final String errorMessage;

  const LoadMoreDiseasesFailed({required this.errorMessage});

  @override
  List<Object> get props => [errorMessage];
}
