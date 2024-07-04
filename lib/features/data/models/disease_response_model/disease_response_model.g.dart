// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'disease_response_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DiseaseResponseModelAdapter extends TypeAdapter<DiseaseResponseModel> {
  @override
  final int typeId = 0;

  @override
  DiseaseResponseModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return DiseaseResponseModel(
      infoModel: fields[0] as InfoModel,
      diseaseModel: (fields[1] as List).cast<DiseaseModel>(),
    );
  }

  @override
  void write(BinaryWriter writer, DiseaseResponseModel obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.infoModel)
      ..writeByte(1)
      ..write(obj.diseaseModel);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DiseaseResponseModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class InfoModelAdapter extends TypeAdapter<InfoModel> {
  @override
  final int typeId = 1;

  @override
  InfoModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return InfoModel(
      fields[0] as int,
      fields[1] as int,
      fields[2] as String,
      fields[3] as String,
    );
  }

  @override
  void write(BinaryWriter writer, InfoModel obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.count)
      ..writeByte(1)
      ..write(obj.pages)
      ..writeByte(2)
      ..write(obj.nextApi)
      ..writeByte(3)
      ..write(obj.prevApi);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is InfoModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class DiseaseModelAdapter extends TypeAdapter<DiseaseModel> {
  @override
  final int typeId = 2;

  @override
  DiseaseModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return DiseaseModel(
      fields[0] as int,
      fields[1] as String,
      fields[2] as String,
      fields[3] as String,
      fields[4] as String,
      fields[5] as String,
      fields[6] as String,
      fields[7] as String,
      fields[8] as String,
      fields[9] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, DiseaseModel obj) {
    writer
      ..writeByte(10)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.status)
      ..writeByte(3)
      ..write(obj.species)
      ..writeByte(4)
      ..write(obj.type)
      ..writeByte(5)
      ..write(obj.gender)
      ..writeByte(6)
      ..write(obj.origin)
      ..writeByte(7)
      ..write(obj.location)
      ..writeByte(8)
      ..write(obj.image)
      ..writeByte(9)
      ..write(obj.createdOn);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DiseaseModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
