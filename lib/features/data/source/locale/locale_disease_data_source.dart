import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:practical_pachprthlo/features/data/models/disease_response_model/disease_response_model.dart';
import 'package:practical_pachprthlo/packages/hive_flutter_package/my_hive_flutter_package_const.dart';

abstract class ILocaleDiseaseDataSource {
  //* To fetch all data from locale database...
  Future<DiseaseResponseModel?> getAllDiseasesFromDB();

  //* To insert all data to locale database...
  Future<void> insertAllDiseasesToDB(DiseaseResponseModel diseaseResponseModel);

  //* To append data to locale database...
  Future<void> appendDataToDiseasesDB(List<DiseaseModel> diseaseModelList);

  //* To check if database contains data or not...
  Future<bool> isDataAvailableInDB();

  //* To clear all data from locale database...
  Future<void> clearAllDataFromDB();
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
  Future<void> insertAllDiseasesToDB(DiseaseResponseModel diseaseResponseModel, {List<dynamic>? moreItemsList}) async {
    try {
      print(diseaseResponseModel.diseaseModelList.length);
      _diseaseBox.put(_diseaseBoxKey, diseaseResponseModel);
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

  @override
  Future<void> appendDataToDiseasesDB(List<DiseaseModel> newDiseaseModel) async {
    var box = Hive.box<DiseaseResponseModel>(_diseaseBoxKey);
    try {
      List<DiseaseModel> existingDiseases = box.get(_diseaseBoxKey)!.diseaseModelList;
      InfoModel existingInfo = box.get(_diseaseBoxKey)!.infoModel;

      // Append the new diseases to the existing list
      existingDiseases.addAll(newDiseaseModel);
      // Save the updated list back to Hive
      await box.put(
        _diseaseBoxKey,
        DiseaseResponseModel(
          diseaseModelList: existingDiseases,
          infoModel: existingInfo,
        ),
      );
    } catch (e) {
      debugPrint("Couldn't append to DB: ${e.toString()}");
    }
    // Retrieve the existing list of diseases
  }

  @override
  Future<void> clearAllDataFromDB() async {
    await _diseaseBox.clear();
  }
}
