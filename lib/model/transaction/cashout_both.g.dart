// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cashout_both.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ToCashOut _$ToCashOutFromJson(Map<String, dynamic> json) => ToCashOut(
      userId: json['user_id'] as String,
      transferTo: json['transfer_to'] as String,
      method: json['payment_method'] as String,
      amount: json['amount'] as int,
    );

Map<String, dynamic> _$ToCashOutToJson(ToCashOut instance) => <String, dynamic>{
      'user_id': instance.userId,
      'transfer_to': instance.transferTo,
      'payment_method': instance.method,
      'amount': instance.amount,
    };

FromCashOut _$FromCashOutFromJson(Map<String, dynamic> json) => FromCashOut(
      json['message'] as String,
      json['status'] as int,
      json['amount'] as int,
      json['date'] as String,
      json['transaction_id'] as String,
    );

Map<String, dynamic> _$FromCashOutToJson(FromCashOut instance) =>
    <String, dynamic>{
      'message': instance.message,
      'status': instance.status,
      'amount': instance.amount,
      'date': instance.date,
      'transaction_id': instance.tranId,
    };
