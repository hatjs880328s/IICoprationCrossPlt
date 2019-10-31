// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'coperationgroupmodel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CoperationGroupModel _$CoperationGroupModelFromJson(Map<String, dynamic> json) {
  return CoperationGroupModel(
      json['name'] as String,
      json['id'] as String,
      (json['users'] as List)?.map((e) => e as String)?.toList(),
      (json['time'] as num)?.toDouble(),
      (json['files'] as List)?.map((e) => e as String)?.toList());
}

Map<String, dynamic> _$CoperationGroupModelToJson(
        CoperationGroupModel instance) =>
    <String, dynamic>{
      'name': instance.name,
      'id': instance.id,
      'users': instance.users,
      'time': instance.time,
      'files': instance.files
    };
