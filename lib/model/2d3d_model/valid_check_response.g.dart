// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'valid_check_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CheckValid _$CheckValidFromJson(Map<String, dynamic> json) => CheckValid(
      json['status'] as int,
      json['message'] as String,
      json['valid_amount'] as int,
    );

Map<String, dynamic> _$CheckValidToJson(CheckValid instance) =>
    <String, dynamic>{
      'message': instance.message,
      'status': instance.status,
      'valid_amount': instance.validAmount,
    };
