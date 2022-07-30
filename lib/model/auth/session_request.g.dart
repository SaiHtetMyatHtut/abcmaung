// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'session_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SessionReg _$SessionRegFromJson(Map<String, dynamic> json) => SessionReg(
      json['user_id'] as String,
      json['token'] as String,
    );

Map<String, dynamic> _$SessionRegToJson(SessionReg instance) =>
    <String, dynamic>{
      'user_id': instance.userId,
      'token': instance.token,
    };
