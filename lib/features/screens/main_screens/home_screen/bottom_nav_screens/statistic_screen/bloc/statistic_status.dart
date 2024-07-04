part of 'statistic_bloc.dart';

@immutable
class StatisticStatus extends Equatable {
  final StatisticState statisticState;

  const StatisticStatus({required this.statisticState});
  @override
  List<Object?> get props => [statisticState];

  StatisticStatus copyWith({StatisticState? statisticState}) {
    return StatisticStatus(statisticState: statisticState ?? this.statisticState);
  }
}
