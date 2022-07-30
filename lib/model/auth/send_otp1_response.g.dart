// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'send_otp1_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Otp1 _$Otp1FromJson(Map<String, dynamic> json) => Otp1(
      json['status'] as int,
      json['request_id'] as int,
      json['message'] as String,
    );

Map<String, dynamic> _$Otp1ToJson(Otp1 instance) => <String, dynamic>{
      'status': instance.status,
      'request_id': instance.requestId,
      'message': instance.message,
    };
