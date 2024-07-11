import 'package:dio/dio.dart';
import 'package:practical_pachprthlo/packages/dio_package/my_dio_package.dart';
import 'package:practical_pachprthlo/packages/dio_package/my_dio_package_const.dart';

abstract class IRemoteDiseaseDataSource {
  Future<Response> getDiseaseList(int page);
}

class RemoteDiseaseDataSourceImp implements IRemoteDiseaseDataSource {
  final MyDioPackage myDioPackage;

  RemoteDiseaseDataSourceImp(this.myDioPackage);
  @override
  Future<Response> getDiseaseList(int page) async {
    return await myDioPackage.getData(dataUrl, queryParameters: {'page': page});
  }
}
