part of 'statistic_bloc.dart';

sealed class StatisticEvent extends Equatable {
  const StatisticEvent();

  @override
  List<Object> get props => [];
}

final class StatisticRequested extends StatisticEvent {}

final class StatisticReloaded extends StatisticEvent {}
