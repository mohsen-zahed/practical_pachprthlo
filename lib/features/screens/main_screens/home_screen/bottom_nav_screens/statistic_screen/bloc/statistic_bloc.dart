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
        if (e.type == DioExceptionType.badResponse) {
          emit(state.copyWith(statisticState: const StatisticFailed(errorMessage: 'Something went wrong, please try again in the next 24 hours!')));
          debugPrint('BadResponse message: ${e.message.toString()}');
        } else if (e.type == DioExceptionType.connectionError) {
          emit(state.copyWith(statisticState: const StatisticFailed(errorMessage: 'Please check your network and try again!')));
          debugPrint('ConnectionError message: ${e.message.toString()}');
        } else if (e.type == DioExceptionType.connectionTimeout) {
          emit(state.copyWith(statisticState: const StatisticFailed(errorMessage: 'Request timed out, try again later!')));
          debugPrint('ConnectionTimeout message: ${e.message.toString()}');
        } else if (e.type == DioExceptionType.sendTimeout) {
          emit(state.copyWith(statisticState: const StatisticFailed(errorMessage: 'Request timed out, try again later!')));
          debugPrint('SendTimeout message: ${e.message.toString()}');
        } else if (e.type == DioExceptionType.unknown) {
          emit(state.copyWith(statisticState: const StatisticFailed(errorMessage: 'There is an unknown problem keeping you from sending requests!')));
          debugPrint('Unknown message: ${e.message.toString()}');
        } else {
          emit(state.copyWith(statisticState: const StatisticFailed(errorMessage: 'Something went wrong!')));
        }
      }
    });
  }
}
