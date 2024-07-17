import 'package:dio/dio.dart';
import 'package:practical_pachprthlo/features/data/models/disease_response_model/disease_response_model.dart';
import 'package:practical_pachprthlo/features/data/repository/locale/locale_disease_repository.dart';
import 'package:practical_pachprthlo/features/data/repository/remote/remote_disease_repository.dart';
import 'package:practical_pachprthlo/packages/connectivity_plus_package/my_connectivity_plus_package_const.dart';

class DiseaseDataProvider {
  final ILocaleDiseaseRepository iLocaleDiseaseRepository;
  final IRemoteDiseaseRepository iRemoteDiseaseRepository;
  final int page;

  DiseaseDataProvider({
    required this.iLocaleDiseaseRepository,
    required this.iRemoteDiseaseRepository,
    required this.page,
  });

  Future<dynamic> fetchDiseaseData(int page, {bool? isLoadingMore}) async {
    final bool isDatabaseEmpty = await iLocaleDiseaseRepository.isDataAvailableInDB();
    if (isConnected) {
      //* When there is a connection...
      final Response response = await iRemoteDiseaseRepository.getDiseaseList(page);
      if (response.statusCode == 200) {
        //* When everything is fine and data can be fetched...
        DiseaseResponseModel diseaseResponseModel = DiseaseResponseModel.fromJson(response.data);
        //* Inserts data to DB so we can read data from DB later...
        await iLocaleDiseaseRepository.insertAllDiseasesToDB(diseaseResponseModel);
        final DiseaseResponseModel? cachedResponseModel = await iLocaleDiseaseRepository.getAllDiseasesFromDB();
        return cachedResponseModel as DiseaseResponseModel;
      } else {
        //* When there is an error while fetching data from server...
        if (!isDatabaseEmpty) {
          //* If there is any data available in DB...
          final DiseaseResponseModel? localSourceResponseModel = await iLocaleDiseaseRepository.getAllDiseasesFromDB();
          return localSourceResponseModel as DiseaseResponseModel;
        } else {
          //* If there is no data available in DB...
          //* This typically happens when there is a connection but server's response is not
          //* 200 and no data is available in DB...
          return Exception('Something went wrong, try again!');
        }
      }
    } else {
      //* If there is no connection
      if (!isDatabaseEmpty) {
        //* But we have some cached data in DB from previously fetching...
        final DiseaseResponseModel? localSourceResponseModel = await iLocaleDiseaseRepository.getAllDiseasesFromDB();
        return localSourceResponseModel;
      } else {
        //* If there is no connection and no previous data in DB...
        return 'No network connection';
      }
    }
  }
}
