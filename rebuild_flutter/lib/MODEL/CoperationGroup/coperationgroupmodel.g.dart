// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'coperationgroupmodel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CoperationGroupModel _$CoperationGroupModelFromJson(Map<String, dynamic> json) {
  return CoperationGroupModel(
      json['folderid'] as String,
      json['name'] as String,
      json['description'] as String,
      json['content'] as String,
      (json['createtime'] as num)?.toDouble(),
      (json['changetime'] as num)?.toDouble(),
      json['users'] as String,
      json['type'] as int,
      (json['realFiles'] as List)
          ?.map((e) => e == null
              ? null
              : RealGitFileModel.fromJson(e as Map<String, dynamic>))
          ?.toList(),
      (json['realUsers'] as List)
          ?.map((e) => e == null
              ? null
              : NSLoginModel.fromJson(e as Map<String, dynamic>))
          ?.toList());
}

Map<String, dynamic> _$CoperationGroupModelToJson(
        CoperationGroupModel instance) =>
    <String, dynamic>{
      'folderid': instance.folderid,
      'name': instance.name,
      'description': instance.description,
      'content': instance.content,
      'createtime': instance.createtime,
      'changetime': instance.changetime,
      'users': instance.users,
      'type': instance.type,
      'realUsers': instance.realUsers,
      'realFiles': instance.realFiles
    };
