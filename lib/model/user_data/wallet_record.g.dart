// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wallet_record.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WalletRecord _$WalletRecordFromJson(Map<String, dynamic> json) => WalletRecord(
      (json['history'] as List<dynamic>)
          .map((e) => Record.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$WalletRecordToJson(WalletRecord instance) =>
    <String, dynamic>{
      'history': instance.history,
    };

Record _$RecordFromJson(Map<String, dynamic> json) => Record(
      json['amount'] as int,
      json['date'] as String,
      json['status'] as String,
      json['action'] as String,
      json['id'] as String,
    );

Map<String, dynamic> _$RecordToJson(Record instance) => <String, dynamic>{
      'action': instance.action,
      'amount': instance.amount,
      'date': instance.date,
      'id': instance.id,
      'status': instance.status,
    };
