part of 'statistic_bloc.dart';

sealed class StatisticState extends Equatable {
  const StatisticState();

  @override
  List<Object> get props => [];
}

final class StatisticLoading extends StatisticState {}

final class StatisticSuccess extends StatisticState {
  final List<dynamic> statisticList;

  const StatisticSuccess({required this.statisticList});

  @override
  List<Object> get props => [statisticList];
}

final class StatisticFailed extends StatisticState {
  final String errorMessage;

  const StatisticFailed({required this.errorMessage});

  @override
  List<Object> get props => [errorMessage];
}
