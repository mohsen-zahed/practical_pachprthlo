import 'package:get_it/get_it.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:practical_pachprthlo/features/blocs/language_bloc/localization_bloc.dart';
import 'package:practical_pachprthlo/features/blocs/theme_bloc/theme_bloc.dart';
import 'package:practical_pachprthlo/features/cubit/internet_cubit.dart';
import 'package:practical_pachprthlo/features/providers/disease_data_provider.dart';
import 'package:practical_pachprthlo/features/data/repository/locale/locale_disease_repository.dart';
import 'package:practical_pachprthlo/features/data/repository/remote/remote_disease_repository.dart';
import 'package:practical_pachprthlo/features/data/repository/remote/remote_statistic_repository.dart';
import 'package:practical_pachprthlo/features/data/source/locale/locale_disease_data_source.dart';
import 'package:practical_pachprthlo/features/data/source/remote/remote_disease_data_source.dart';
import 'package:practical_pachprthlo/features/data/source/remote/remote_statistic_data_source.dart';
import 'package:practical_pachprthlo/features/screens/main_screens/home_screen/bottom_nav_screens/home_screen/bloc/diseases_bloc.dart';
import 'package:practical_pachprthlo/features/screens/main_screens/home_screen/bottom_nav_screens/statistic_screen/bloc/statistic_bloc.dart';
import 'package:practical_pachprthlo/packages/connectivity_plus_package/my_connectivity_plus_package.dart';
import 'package:practical_pachprthlo/packages/dio_package/my_dio_package.dart';

GetIt di = GetIt.instance;

Future<void> setupDi() async {
  //* Network services...
  di.registerSingleton<MyDioPackage>(MyDioPackage.instance);
  di.registerSingleton<MyConnectivityPlusPackage>(MyConnectivityPlusPackage.instance);

  //* DB initialization...
  await Hive.initFlutter();

  //* DB services...
  di.registerSingleton<LocaleDiseasesDataSourceImp>(LocaleDiseasesDataSourceImp());
  await di<LocaleDiseasesDataSourceImp>().initDB();

  //* DB provider...
  di.registerSingleton(LocaleDiseaseRepositoryImp(iLocaleDiseaseDataSource: di<LocaleDiseasesDataSourceImp>()));

  //* Remote data source imp...
  di.registerSingleton(RemoteDiseaseDataSourceImp(di<MyDioPackage>()));

  //* Remote repository imp...
  di.registerSingleton(RemoteDiseaseRepositoryImp(iRemoteDiseaseDataSource: di<RemoteDiseaseDataSourceImp>()));

  //* Disease data provider...
  di.registerSingleton(DiseaseDataProvider(
    iLocaleDiseaseRepository: di<LocaleDiseaseRepositoryImp>(),
    iRemoteDiseaseRepository: di<RemoteDiseaseRepositoryImp>(),
    page: 2,
  ));

  //* RemoteStatisticDataSourceImp...
  di.registerSingleton<IRemoteStatisticDataSource>(RemoteStatisticDataSourceImp(myDioPackage: di<MyDioPackage>()));

  //* RemoteStatisticRepositoryImp...
  di.registerSingleton<IRemoteStatisticRepository>(RemoteStatisticRepositoryImp(iStatisticDataSource: di<IRemoteStatisticDataSource>()));

  //* Disease Bloc...
  di.registerSingleton<DiseaseBloc>(DiseaseBloc(di<DiseaseDataProvider>()));

  //* Statistic Bloc...
  di.registerSingleton<StatisticBloc>(StatisticBloc(di<IRemoteStatisticRepository>()));

  //* Theme Bloc...
  di.registerSingleton<ThemeBloc>(ThemeBloc());

  //* Localization Bloc...
  di.registerSingleton<LocalizationBloc>(LocalizationBloc());

  //* Internet Connectivity...
  di.registerSingleton<InternetCubit>(InternetCubit());
}
