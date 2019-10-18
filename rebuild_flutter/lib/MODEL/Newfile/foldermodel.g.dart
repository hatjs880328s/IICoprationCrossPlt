// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'foldermodel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FolderModel _$FolderModelFromJson(Map<String, dynamic> json) {
  return FolderModel(
      json['name'] as String,
      json['path'] as String,
      json['sha'] as String,
      json['size'] as int,
      json['url'] as String,
      json['html_url'] as String,
      json['git_url'] as String,
      json['download_url'] as String,
      json['type'] as String);
}

Map<String, dynamic> _$FolderModelToJson(FolderModel instance) =>
    <String, dynamic>{
      'name': instance.name,
      'path': instance.path,
      'sha': instance.sha,
      'size': instance.size,
      'url': instance.url,
      'html_url': instance.html_url,
      'git_url': instance.git_url,
      'download_url': instance.download_url,
      'type': instance.type
    };
