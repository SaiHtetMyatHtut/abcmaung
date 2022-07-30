// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'account_record.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AccountRecord _$AccountRecordFromJson(Map<String, dynamic> json) =>
    AccountRecord(
      (json['record_data'] as List<dynamic>)
          .map((e) => AccountRecordDetails.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$AccountRecordToJson(AccountRecord instance) =>
    <String, dynamic>{
      'record_data': instance.data,
    };

AccountRecordDetails _$AccountRecordDetailsFromJson(
        Map<String, dynamic> json) =>
    AccountRecordDetails(
      json['amount'] as int,
      (json['bet_records'] as List<dynamic>)
          .map((e) => BetRecords.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['date'] as String,
      json['status'] as String,
      json['action'] as String,
      json['id'] as String,
    );

Map<String, dynamic> _$AccountRecordDetailsToJson(
        AccountRecordDetails instance) =>
    <String, dynamic>{
      'action': instance.action,
      'amount': instance.amount,
      'bet_records': instance.betRecords,
      'date': instance.date,
      'id': instance.id,
      'status': instance.status,
    };

BetRecords _$BetRecordsFromJson(Map<String, dynamic> json) => BetRecords(
      json['bet_amount'] as int,
      json['bet_number'] as String,
      json['rate'] as int,
    );

Map<String, dynamic> _$BetRecordsToJson(BetRecords instance) =>
    <String, dynamic>{
      'bet_amount': instance.betAmount,
      'bet_number': instance.betNumber,
      'rate': instance.rate,
    };
