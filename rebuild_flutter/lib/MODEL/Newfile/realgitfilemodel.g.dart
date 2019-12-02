// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'realgitfilemodel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RealGitFileModel _$RealGitFileModelFromJson(Map<String, dynamic> json) {
  return RealGitFileModel(
      json['content'] as String,
      (json['createtime'] as num)?.toDouble(),
      json['images'] as String,
      json['name'] as String,
      json['description'] as String,
      json['fileid'] as String,
      json['folderid'] as String,
      (json['changetime'] as num)?.toDouble(),
      json['currentowner'] as String,
      json['creator'] as String);
}

Map<String, dynamic> _$RealGitFileModelToJson(RealGitFileModel instance) =>
    <String, dynamic>{
      'content': instance.content,
      'images': instance.images,
      'name': instance.name,
      'description': instance.description,
      'fileid': instance.fileid,
      'folderid': instance.folderid,
      'createtime': instance.createtime,
      'changetime': instance.changetime,
      'currentowner': instance.currentowner,
      'creator': instance.creator
    };
