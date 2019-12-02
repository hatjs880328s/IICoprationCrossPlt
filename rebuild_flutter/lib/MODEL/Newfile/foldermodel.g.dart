// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'foldermodel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FolderModel _$FolderModelFromJson(Map<String, dynamic> json) {
  return FolderModel(
      json['folderid'] as String,
      json['name'] as String,
      json['description'] as String,
      json['content'] as String,
      (json['createtime'] as num)?.toDouble(),
      (json['changetime'] as num)?.toDouble(),
      json['users'] as String,
      json['type'] as int);
}

Map<String, dynamic> _$FolderModelToJson(FolderModel instance) =>
    <String, dynamic>{
      'folderid': instance.folderid,
      'name': instance.name,
      'description': instance.description,
      'content': instance.content,
      'createtime': instance.createtime,
      'changetime': instance.changetime,
      'users': instance.users,
      'type': instance.type
    };
