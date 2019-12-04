// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'gitcmdshowmodel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GitCMDShowModel _$GitCMDShowModelFromJson(Map<String, dynamic> json) {
  return GitCMDShowModel(
      json['cmdtype'] as int,
      json['sender'] as String,
      json['reveiver'] as String,
      json['cmdid'] as String,
      (json['time'] as num)?.toDouble(),
      json['groupid'] as String,
      json['nickname'] as String,
      json['name'] as String);
}

Map<String, dynamic> _$GitCMDShowModelToJson(GitCMDShowModel instance) =>
    <String, dynamic>{
      'cmdid': instance.cmdid,
      'sender': instance.sender,
      'reveiver': instance.reveiver,
      'cmdtype': instance.cmdtype,
      'time': instance.time,
      'groupid': instance.groupid,
      'nickname': instance.nickname,
      'name': instance.name
    };
