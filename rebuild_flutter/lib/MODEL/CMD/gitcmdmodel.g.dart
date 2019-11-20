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
      _$enumDecodeNullable(_$CMDTypeEnumMap, json['cmd']),
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
      'cmd': _$CMDTypeEnumMap[instance.cmd],
      'time': instance.time,
      'group': instance.group
    };

T _$enumDecode<T>(Map<T, dynamic> enumValues, dynamic source) {
  if (source == null) {
    throw ArgumentError('A value must be provided. Supported values: '
        '${enumValues.values.join(', ')}');
  }
  return enumValues.entries
      .singleWhere((e) => e.value == source,
          orElse: () => throw ArgumentError(
              '`$source` is not one of the supported values: '
              '${enumValues.values.join(', ')}'))
      .key;
}

T _$enumDecodeNullable<T>(Map<T, dynamic> enumValues, dynamic source) {
  if (source == null) {
    return null;
  }
  return _$enumDecode<T>(enumValues, source);
}

const _$CMDTypeEnumMap = <CMDType, dynamic>{
  CMDType.invite: 'invite',
  CMDType.inviteresult: 'inviteresult'
};
