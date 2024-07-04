import 'package:practical_pachprthlo/features/data/models/statistic_response_model/statistic_response_model.dart';
import 'package:practical_pachprthlo/packages/dio_package/my_dio_package.dart';
import 'package:practical_pachprthlo/packages/dio_package/my_dio_package_const.dart';

abstract class IRemoteStatisticDataSource {
  Future<List<dynamic>> fetchStatistics();
}

class RemoteStatisticDataSourceImp implements IRemoteStatisticDataSource {
  final MyDioPackage myDioPackage;

  RemoteStatisticDataSourceImp({required this.myDioPackage});
  @override
  Future<List<dynamic>> fetchStatistics() async {
    final response = await myDioPackage.getData(statisticUrl);
    List<dynamic> statisticModelList = [];
    for (var element in (response.data['results'] as List)) {
      statisticModelList.add(StatisticModel.fromJson(element));
    }

    return statisticModelList;
  }
}
