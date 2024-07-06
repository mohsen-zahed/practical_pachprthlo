part of 'diseases_bloc.dart';

sealed class DiseasesState extends Equatable {
  const DiseasesState();

  @override
  List<Object> get props => [];
}

final class DiseasesLoading extends DiseasesState {}

final class DiseasesSuccess extends DiseasesState {
  final DiseaseResponseModel diseaseResponseModel;

  const DiseasesSuccess({required this.diseaseResponseModel});

  @override
  List<Object> get props => [diseaseResponseModel];
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
