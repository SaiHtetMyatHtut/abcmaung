// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginResponse _$LoginResponseFromJson(Map<String, dynamic> json) =>
    LoginResponse(
      WalletData.fromJson(json['wallet_data'] as Map<String, dynamic>),
      json['message'] as String,
      json['status'] as int,
      json['token'] as String,
      UserData.fromJson(json['user_data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$LoginResponseToJson(LoginResponse instance) =>
    <String, dynamic>{
      'token': instance.token,
      'user_data': instance.userData,
      'wallet_data': instance.walletData,
      'message': instance.message,
      'status': instance.status,
    };

WalletData _$WalletDataFromJson(Map<String, dynamic> json) => WalletData(
      json['game_balance'] as int,
      json['main_balance'] as int,
      json['point'] as int,
      json['wallet_id'] as String,
    );

Map<String, dynamic> _$WalletDataToJson(WalletData instance) =>
    <String, dynamic>{
      'game_balance': instance.gameBalance,
      'main_balance': instance.mainBalance,
      'point': instance.point,
      'wallet_id': instance.walletId,
    };

UserData _$UserDataFromJson(Map<String, dynamic> json) => UserData(
      json['full_name'] as String,
      json['user_email'] as String,
      json['user_id'] as String,
      json['user_phone'] as String,
    );

Map<String, dynamic> _$UserDataToJson(UserData instance) => <String, dynamic>{
      'full_name': instance.fullName,
      'user_email': instance.userEmail,
      'user_id': instance.userId,
      'user_phone': instance.userPhone,
    };
