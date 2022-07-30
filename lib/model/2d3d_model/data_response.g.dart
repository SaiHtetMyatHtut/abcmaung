// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'data_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Data2D _$Data2DFromJson(Map<String, dynamic> json) => Data2D(
      (json['data'] as List<dynamic>)
          .map((e) => Details.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['last_read_time'] as String,
      json['message'] as String,
      json['status'] as int,
    );

Map<String, dynamic> _$Data2DToJson(Data2D instance) => <String, dynamic>{
      'data': instance.data,
      'last_read_time': instance.lastReadTime,
      'message': instance.message,
      'status': instance.status,
    };

Details _$DetailsFromJson(Map<String, dynamic> json) => Details(
      json['number'] as String,
      (json['percent'] as num).toDouble(),
      json['valid_amount'] as int,
    );

Map<String, dynamic> _$DetailsToJson(Details instance) => <String, dynamic>{
      'number': instance.number,
      'percent': instance.percent,
      'valid_amount': instance.validAmount,
    };
