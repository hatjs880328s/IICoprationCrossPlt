// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'realgitfilemodel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RealGitFileModel _$RealGitFileModelFromJson(Map<String, dynamic> json) {
  return RealGitFileModel(json['content'] as String,
      (json['time'] as num)?.toDouble(), json['img'] as String);
}

Map<String, dynamic> _$RealGitFileModelToJson(RealGitFileModel instance) =>
    <String, dynamic>{
      'content': instance.content,
      'time': instance.time,
      'img': instance.img
    };
