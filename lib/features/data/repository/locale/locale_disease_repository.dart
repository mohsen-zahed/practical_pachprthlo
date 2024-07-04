import 'package:practical_pachprthlo/features/data/models/disease_response_model/disease_response_model.dart';
import 'package:practical_pachprthlo/features/data/source/locale/locale_disease_data_source.dart';

abstract class ILocaleDiseaseRepository extends ILocaleDiseaseDataSource {}

class LocaleDiseaseRepositoryImp implements ILocaleDiseaseRepository {
  final ILocaleDiseaseDataSource iLocaleDiseaseDataSource;

  LocaleDiseaseRepositoryImp({required this.iLocaleDiseaseDataSource});
  @override
  Future<DiseaseResponseModel?> getAllDiseasesFromDB() => iLocaleDiseaseDataSource.getAllDiseasesFromDB();

  @override
  Future<void> insertAllDiseasesToDB(DiseaseResponseModel diseaseModelList) => iLocaleDiseaseDataSource.insertAllDiseasesToDB(diseaseModelList);

  @override
  Future<bool> isDataAvailableInDB() => iLocaleDiseaseDataSource.isDataAvailableInDB();
}
