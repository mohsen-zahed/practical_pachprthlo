import 'package:practical_pachprthlo/features/data/source/remote/remote_statistic_data_source.dart';
import 'package:practical_pachprthlo/packages/dio_package/my_dio_package.dart';

final statisticRepository = RemoteStatisticRepositoryImp(iStatisticDataSource: RemoteStatisticDataSourceImp(myDioPackage: MyDioPackage.instance));

abstract class IRemoteStatisticRepository extends IRemoteStatisticDataSource {}

class RemoteStatisticRepositoryImp extends IRemoteStatisticRepository {
  final IRemoteStatisticDataSource iStatisticDataSource;

  RemoteStatisticRepositoryImp({required this.iStatisticDataSource});
  @override
  Future<List<dynamic>> fetchStatistics() => iStatisticDataSource.fetchStatistics();
}
