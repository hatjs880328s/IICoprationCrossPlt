// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'gitcmdmodel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GitCMDModel _$GitCMDModelFromJson(Map<String, dynamic> json) {
  return GitCMDModel(
      json['sender'] == null
          ? null
          : NSLoginModel.fromJson(json['sender'] as Map<String, dynamic>),
      json['receiver'] == null
          ? null
          : NSLoginModel.fromJson(json['receiver'] as Map<String, dynamic>),
      json['cmd'] as String,
      (json['time'] as num)?.toDouble(),
      json['group'] == null
          ? null
          : CoperationGroupModel.fromJson(
              json['group'] as Map<String, dynamic>));
}

Map<String, dynamic> _$GitCMDModelToJson(GitCMDModel instance) =>
    <String, dynamic>{
      'sender': instance.sender,
      'receiver': instance.receiver,
      'cmd': instance.cmd,
      'time': instance.time,
      'group': instance.group
    };
