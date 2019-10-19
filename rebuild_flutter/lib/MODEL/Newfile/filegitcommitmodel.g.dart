// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'filegitcommitmodel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FileGitCommitModel _$FileGitCommitModelFromJson(Map<String, dynamic> json) {
  return FileGitCommitModel(
      json['message'] as String,
      json['content'] as String,
      json['committer'] == null
          ? null
          : FileGitCommitSmallModel.fromJson(
              json['committer'] as Map<String, dynamic>));
}

Map<String, dynamic> _$FileGitCommitModelToJson(FileGitCommitModel instance) =>
    <String, dynamic>{
      'message': instance.message,
      'content': instance.content,
      'committer': instance.committer
    };
