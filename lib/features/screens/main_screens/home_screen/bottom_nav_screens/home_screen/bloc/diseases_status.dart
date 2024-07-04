part of 'diseases_bloc.dart';

@immutable
class DiseasesStatus extends Equatable {
  final DiseasesState diseasesState;

  const DiseasesStatus({required this.diseasesState});

  @override
  List<Object?> get props => [diseasesState];

  DiseasesStatus copyWith({
    DiseasesState? diseasesState,
  }) {
    return DiseasesStatus(
      diseasesState: diseasesState ?? this.diseasesState,
    );
  }
}
