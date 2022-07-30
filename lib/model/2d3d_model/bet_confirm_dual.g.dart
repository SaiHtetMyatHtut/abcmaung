// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bet_confirm_dual.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ToConfirm _$ToConfirmFromJson(Map<String, dynamic> json) => ToConfirm(
      userId: json['user_id'] as String,
      number:
          (json['number'] as List<dynamic>).map((e) => e as String).toList(),
      gameType: json['game_type'] as String? ?? 'three_d',
      amount: json['amount'] as int,
    );

Map<String, dynamic> _$ToConfirmToJson(ToConfirm instance) => <String, dynamic>{
      'user_id': instance.userId,
      'number': instance.number,
      'game_type': instance.gameType,
      'amount': instance.amount,
    };

FromConfirm _$FromConfirmFromJson(Map<String, dynamic> json) => FromConfirm(
      json['amount'] as int,
      json['balance'] as int,
      json['message'] as String,
      (json['number_list'] as List<dynamic>)
          .map((e) => NumberDetail.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['status'] as int,
    );

Map<String, dynamic> _$FromConfirmToJson(FromConfirm instance) =>
    <String, dynamic>{
      'amount': instance.amount,
      'balance': instance.balance,
      'message': instance.message,
      'number_list': instance.numberList,
      'status': instance.status,
    };

NumberDetail _$NumberDetailFromJson(Map<String, dynamic> json) => NumberDetail(
      number: json['number'] as String,
      percent: (json['percent'] as num).toDouble(),
      validAmount: json['valid_amount'] as int,
    );

Map<String, dynamic> _$NumberDetailToJson(NumberDetail instance) =>
    <String, dynamic>{
      'number': instance.number,
      'percent': instance.percent,
      'valid_amount': instance.validAmount,
    };
