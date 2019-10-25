// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'nsloginmodel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NSLoginModel _$NSLoginModelFromJson(Map<String, dynamic> json) {
  return NSLoginModel(json['uid'] as String, json['nickname'] as String,
      json['icon'] as String);
}

Map<String, dynamic> _$NSLoginModelToJson(NSLoginModel instance) =>
    <String, dynamic>{
      'uid': instance.uid,
      'nickname': instance.nickname,
      'icon': instance.icon
    };
