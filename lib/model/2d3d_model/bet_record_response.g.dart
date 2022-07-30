// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bet_record_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BetRecord _$BetRecordFromJson(Map<String, dynamic> json) => BetRecord(
      json['status'] as int,
      json['message'] as String,
      (json['record_data'] as List<dynamic>)
          .map((e) => Detail.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$BetRecordToJson(BetRecord instance) => <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'record_data': instance.data,
    };

Detail _$DetailFromJson(Map<String, dynamic> json) => Detail(
      json['bet_number'] as String,
      json['state'] as String,
      json['timestamp'] as String,
    );

Map<String, dynamic> _$DetailToJson(Detail instance) => <String, dynamic>{
      'bet_number': instance.number,
      'state': instance.state,
      'timestamp': instance.time,
    };
