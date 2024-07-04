import 'package:dio/dio.dart';
import 'package:practical_pachprthlo/features/data/source/remote/remote_disease_data_source.dart';
import 'package:practical_pachprthlo/packages/dio_package/my_dio_package.dart';

final diseaseRepositoryImp = RemoteDiseaseRepositoryImp(iRemoteDiseaseDataSource: RemoteDiseaseDataSourceImp(MyDioPackage.instance));

abstract class IRemoteDiseaseRepository extends IRemoteDiseaseDataSource {}

class RemoteDiseaseRepositoryImp extends IRemoteDiseaseRepository {
  final IRemoteDiseaseDataSource iRemoteDiseaseDataSource;

  RemoteDiseaseRepositoryImp({required this.iRemoteDiseaseDataSource});
  @override
  Future<Response> getDiseaseList(int page) => iRemoteDiseaseDataSource.getDiseaseList(page);
}
