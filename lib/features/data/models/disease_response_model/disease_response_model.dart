import 'package:hive/hive.dart';
import 'package:practical_pachprthlo/helpers/data_base_helper/disease_hive_helper/fields/disease_model_fields.dart';
import 'package:practical_pachprthlo/helpers/data_base_helper/disease_hive_helper/hive_types.dart';
import 'package:practical_pachprthlo/helpers/data_base_helper/disease_hive_helper/fields/disease_response_model_fields.dart';
import 'package:practical_pachprthlo/helpers/data_base_helper/disease_hive_helper/fields/info_model_fields.dart';

part 'disease_response_model.g.dart';

@HiveType(typeId: HiveTypes.diseaseResponseModel)
class DiseaseResponseModel extends HiveObject {
  @HiveField(DiseaseResponseModelFields.infoModel)
  final InfoModel infoModel;
  @HiveField(DiseaseResponseModelFields.diseaseModel)
  final List<DiseaseModel> diseaseModelList;

  factory DiseaseResponseModel.fromJson(Map<String, dynamic> json) => DiseaseResponseModel(
        infoModel: InfoModel.fromJson(json['info']),
        diseaseModelList: List<DiseaseModel>.from(json['results'].map((x) => DiseaseModel.fromJson(x))),
      );
  DiseaseResponseModel({required this.infoModel, required this.diseaseModelList});
}

@HiveType(typeId: HiveTypes.infoModel)
class InfoModel extends HiveObject {
  @HiveField(InfoModelFields.count)
  final int count;
  @HiveField(InfoModelFields.pages)
  final int pages;
  @HiveField(InfoModelFields.nextApi)
  final String nextApi;
  @HiveField(InfoModelFields.prevApi)
  final String prevApi;

  InfoModel(this.count, this.pages, this.nextApi, this.prevApi);

  InfoModel.fromJson(Map<String, dynamic> json)
      : count = json['count'],
        pages = json['pages'],
        nextApi = json['next'],
        prevApi = json['prev'];
}

@HiveType(typeId: HiveTypes.diseaseModel)
class DiseaseModel extends HiveObject {
  @HiveField(DiseaseModelFields.id)
  final int id;
  @HiveField(DiseaseModelFields.name)
  final String name;
  @HiveField(DiseaseModelFields.status)
  final String status;
  @HiveField(DiseaseModelFields.species)
  final String species;
  @HiveField(DiseaseModelFields.type)
  final String type;
  @HiveField(DiseaseModelFields.gender)
  final String gender;
  @HiveField(DiseaseModelFields.origin)
  final String origin;
  @HiveField(DiseaseModelFields.location)
  final String location;
  @HiveField(DiseaseModelFields.image)
  final String image;
  @HiveField(DiseaseModelFields.createdOn)
  final DateTime createdOn;

  DiseaseModel(
    this.id,
    this.name,
    this.status,
    this.species,
    this.type,
    this.gender,
    this.origin,
    this.location,
    this.image,
    this.createdOn,
  );

  DiseaseModel.fromJson(Map<String, dynamic> json)
      : id = json['id'] ?? 0,
        name = json['name'] ?? '',
        status = json['status'] ?? '',
        species = json['species'] ?? '',
        type = json['type'] ?? '',
        origin = json['origin']['name'] ?? '',
        location = json['location']['name'] ?? '',
        image = json['image'] ?? '',
        gender = json['gender'] ?? '',
        createdOn = DateTime.parse(json['created']);
}
