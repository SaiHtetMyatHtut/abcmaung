// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bet_winner_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BetWinner _$BetWinnerFromJson(Map<String, dynamic> json) => BetWinner(
      json['status'] as int,
      json['message'] as String,
      (json['data'] as List<dynamic>)
          .map((e) => BetWinnerDetail.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$BetWinnerToJson(BetWinner instance) => <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'data': instance.data,
    };

BetWinnerDetail _$BetWinnerDetailFromJson(Map<String, dynamic> json) =>
    BetWinnerDetail(
      json['bet'] as int,
      json['user_name'] as String,
      json['win'] as int,
    );

Map<String, dynamic> _$BetWinnerDetailToJson(BetWinnerDetail instance) =>
    <String, dynamic>{
      'bet': instance.bet,
      'user_name': instance.userName,
      'win': instance.win,
    };
