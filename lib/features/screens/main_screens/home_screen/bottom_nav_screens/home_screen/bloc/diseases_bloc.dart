import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:practical_pachprthlo/features/data/models/disease_response_model/disease_response_model.dart';
import 'package:practical_pachprthlo/features/providers/disease_data_provider.dart';

part 'diseases_event.dart';
part 'diseases_state.dart';
part 'diseases_status.dart';

class DiseaseBloc extends Bloc<DiseasesEvent, DiseasesStatus> {
  final DiseaseDataProvider diseaseDataProvider;

  ScrollController scrollController = ScrollController();
  bool isLoadingMore = false;
  int page = 2;
  DiseaseBloc(this.diseaseDataProvider) : super(DiseasesStatus(diseasesState: DiseasesLoading())) {
    scrollController.addListener(() {
      add(LoadMoreDiseasesRequested());
    });
    on<FetchDiseases>((event, emit) async {
      try {
        emit(state.copyWith(diseasesState: DiseasesLoading()));

        final diseaseResponseResults = await diseaseDataProvider.fetchDiseaseData(page);
        if (diseaseResponseResults is DiseaseResponseModel) {
          emit(state.copyWith(diseasesState: DiseasesSuccess(diseaseResponseModel: diseaseResponseResults)));
        } else {
          diseaseResponseResults is String;
          emit(state.copyWith(
            diseasesState: DiseasesFailed(errorMessage: diseaseResponseResults),
          ));
        }
      } on DioException catch (e) {
        if (e.type == DioExceptionType.badResponse) {
          emit(state.copyWith(diseasesState: const DiseasesFailed(errorMessage: 'Something went wrong, please try again in the next 24 hours!')));
          debugPrint('BadResponse message: ${e.message.toString()}');
        } else if (e.type == DioExceptionType.connectionError) {
          emit(state.copyWith(diseasesState: const DiseasesFailed(errorMessage: 'Please check your network and try again!')));
          debugPrint('ConnectionError message: ${e.message.toString()}');
        } else if (e.type == DioExceptionType.connectionTimeout) {
          emit(state.copyWith(diseasesState: const DiseasesFailed(errorMessage: 'Request timed out, try again later!')));
          debugPrint('ConnectionTimeout message: ${e.message.toString()}');
        } else if (e.type == DioExceptionType.sendTimeout) {
          emit(state.copyWith(diseasesState: const DiseasesFailed(errorMessage: 'Request timed out, try again later!')));
          debugPrint('SendTimeout message: ${e.message.toString()}');
        } else if (e.type == DioExceptionType.unknown) {
          emit(state.copyWith(diseasesState: const DiseasesFailed(errorMessage: 'There is an unknown problem keeping you from sending requests!')));
          debugPrint('Unknown message: ${e.message.toString()}');
        } else {
          emit(state.copyWith(diseasesState: const DiseasesFailed(errorMessage: 'Something went wrong!')));
        }
      }
    });

    on<LoadMoreDiseasesRequested>((event, emit) async {
      if (scrollController.position.pixels == scrollController.position.maxScrollExtent) {
        isLoadingMore = true;
        page++;
        try {
          DiseaseResponseModel diseaseResponseResult = await diseaseDataProvider.fetchDiseaseData(page);
          if (state is DiseasesSuccess) {
            // final currentState = state as DiseasesSuccess;

            emit(state.copyWith(diseasesState: DiseasesSuccess(diseaseResponseModel: diseaseResponseResult)));
          } else {
            emit(state.copyWith(diseasesState: DiseasesSuccess(diseaseResponseModel: diseaseResponseResult)));
          }
        } catch (e) {
          emit(state.copyWith(diseasesState: DiseasesFailed(errorMessage: e.toString())));
        }
      }
    });
  }
}
