import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:practical_pachprthlo/features/data/repository/remote/remote_statistic_repository.dart';

part 'statistic_event.dart';
part 'statistic_state.dart';
part 'statistic_status.dart';

class StatisticBloc extends Bloc<StatisticEvent, StatisticStatus> {
  final IRemoteStatisticRepository iStatisticRepository;
  StatisticBloc(this.iStatisticRepository) : super(StatisticStatus(statisticState: StatisticLoading())) {
    on<StatisticRequested>((event, emit) async {
      try {
        emit(state.copyWith(statisticState: StatisticLoading()));
        final result = await iStatisticRepository.fetchStatistics();
        emit(state.copyWith(statisticState: StatisticSuccess(statisticList: result)));
      } on DioException catch (e) {
        emit(state.copyWith(statisticState: StatisticFailed(errorMessage: e.message.toString())));
      }
    });
  }
}
