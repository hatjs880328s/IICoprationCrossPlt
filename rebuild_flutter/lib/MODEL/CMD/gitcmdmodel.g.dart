// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'gitcmdmodel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GitCMDModel _$GitCMDModelFromJson(Map<String, dynamic> json) {
  return GitCMDModel(
      json['cmdtype'] as int,
      json['sender'] as String,
      json['reveiver'] as String,
      json['cmdid'] as String,
      (json['time'] as num)?.toDouble(),
      json['groupid'] as String);
}

Map<String, dynamic> _$GitCMDModelToJson(GitCMDModel instance) =>
    <String, dynamic>{
      'cmdid': instance.cmdid,
      'sender': instance.sender,
      'reveiver': instance.reveiver,
      'cmdtype': instance.cmdtype,
      'time': instance.time,
      'groupid': instance.groupid
    };
