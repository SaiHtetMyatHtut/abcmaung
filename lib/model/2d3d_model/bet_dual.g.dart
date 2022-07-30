// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bet_dual.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ToBet _$ToBetFromJson(Map<String, dynamic> json) => ToBet(
      userId: json['user_id'] as String,
      data: json['data'] as List<dynamic>,
    );

Map<String, dynamic> _$ToBetToJson(ToBet instance) => <String, dynamic>{
      'user_id': instance.userId,
      'data': instance.data,
    };

FromBet _$FromBetFromJson(Map<String, dynamic> json) => FromBet(
      json['bet_list'] as List<dynamic>,
      json['balance'] as int,
      json['message'] as String,
      json['status'] as int,
    );

Map<String, dynamic> _$FromBetToJson(FromBet instance) => <String, dynamic>{
      'bet_list': instance.betList,
      'balance': instance.balance,
      'message': instance.message,
      'status': instance.status,
    };
