// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cashin_both.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ToCashIn _$ToCashInFromJson(Map<String, dynamic> json) => ToCashIn(
      userId: json['user_id'] as String,
      transferTo: json['transfer_to'] as String,
      paymentMethod: json['payment_method'] as String,
      lastPh4: json['last_ph_4'] as String,
      lastTran6: json['last_tran_6'] as String,
      amount: json['amount'] as int,
    );

Map<String, dynamic> _$ToCashInToJson(ToCashIn instance) => <String, dynamic>{
      'user_id': instance.userId,
      'transfer_to': instance.transferTo,
      'payment_method': instance.paymentMethod,
      'last_ph_4': instance.lastPh4,
      'last_tran_6': instance.lastTran6,
      'amount': instance.amount,
    };

FromCashIn _$FromCashInFromJson(Map<String, dynamic> json) => FromCashIn(
      json['message'] as String,
      json['status'] as int,
      json['amount'] as int,
      json['date'] as String,
      json['transaction_id'] as String,
    );

Map<String, dynamic> _$FromCashInToJson(FromCashIn instance) =>
    <String, dynamic>{
      'message': instance.message,
      'status': instance.status,
      'amount': instance.amount,
      'date': instance.date,
      'transaction_id': instance.tranId,
    };
