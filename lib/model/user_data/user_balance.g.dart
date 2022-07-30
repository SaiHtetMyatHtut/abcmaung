// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_balance.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserBalance _$UserBalanceFromJson(Map<String, dynamic> json) => UserBalance(
      Child.fromJson(json['balance_data'] as Map<String, dynamic>),
      json['message'] as String,
      json['status'] as int,
      json['user_id'] as String,
    );

Map<String, dynamic> _$UserBalanceToJson(UserBalance instance) =>
    <String, dynamic>{
      'balance_data': instance.balanceData,
      'message': instance.message,
      'status': instance.status,
      'user_id': instance.userId,
    };

Child _$ChildFromJson(Map<String, dynamic> json) => Child(
      json['game_balance'] as int,
      json['main_balance'] as int,
      json['vip_id'] as int,
      json['walllet_id'] as String,
    );

Map<String, dynamic> _$ChildToJson(Child instance) => <String, dynamic>{
      'game_balance': instance.gameBalance,
      'main_balance': instance.mainBalance,
      'vip_id': instance.vipId,
      'walllet_id': instance.wallletId,
    };
