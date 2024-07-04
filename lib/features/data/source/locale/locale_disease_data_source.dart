import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:practical_pachprthlo/features/data/models/disease_response_model/disease_response_model.dart';
import 'package:practical_pachprthlo/packages/hive_flutter_package/my_hive_flutter_package_const.dart';

abstract class ILocaleDiseaseDataSource {
  //* To fetch all data from locale database...
  Future<DiseaseResponseModel?> getAllDiseasesFromDB();

  //* To insert all data to locale database...
  Future<void> insertAllDiseasesToDB(DiseaseResponseModel diseaseModel);

  //* To check if database contains data or not...
  Future<bool> isDataAvailableInDB();
}

class LocaleDiseasesDataSourceImp implements ILocaleDiseaseDataSource {
  final String _diseaseBoxKey = DBKeys.dbDiseases;
  late final Box<DiseaseResponseModel> _diseaseBox;

  Future<void> initDB() async {
    try {
      Hive.registerAdapter(DiseaseResponseModelAdapter());
      Hive.registerAdapter(InfoModelAdapter());
      Hive.registerAdapter(DiseaseModelAdapter());
      _diseaseBox = await Hive.openBox(_diseaseBoxKey);
      // final x = _diseaseBox.values.toList();
      // print(x.length);
      // print("value: ${x[0].diseaseModel[0].image}");
    } catch (e) {
      debugPrint("Couldn't get data from DB: ${e.toString()}");
    }
  }

  @override
  Future<DiseaseResponseModel?> getAllDiseasesFromDB() async {
    if (_diseaseBox.isOpen && _diseaseBox.isNotEmpty) {
      return _diseaseBox.get(_diseaseBoxKey);
    } else {
      return null;
    }
  }

  @override
  Future<void> insertAllDiseasesToDB(DiseaseResponseModel diseaseModelList) async {
    try {
      _diseaseBox.put(_diseaseBoxKey, diseaseModelList);
    } catch (e) {
      debugPrint("Couldn't insert to DB: ${e.toString()}");
    }
  }

  @override
  Future<bool> isDataAvailableInDB() async {
    try {
      return _diseaseBox.isEmpty;
    } catch (e) {
      return true;
    }
  }
}
