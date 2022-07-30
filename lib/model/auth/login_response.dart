import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

part 'login_response.g.dart';

@JsonSerializable()
class LoginResponse {
  String token;
  @JsonKey(name: 'user_data')
  UserData userData;
  @JsonKey(name: 'wallet_data')
  WalletData walletData;
  String message;
  int status;
  LoginResponse(this.walletData,this.message, this.status, this.token, this.userData);
  factory LoginResponse.fromJson(Map<String,dynamic> json) => _$LoginResponseFromJson(json);
}

@JsonSerializable()
class WalletData {
  @JsonKey(name: 'game_balance')
  int gameBalance;
  @JsonKey(name: 'main_balance')
  int mainBalance;
  int point;
  @JsonKey(name: 'wallet_id')
  String walletId;
  WalletData(this.gameBalance,this.mainBalance,this.point,this.walletId);
  factory WalletData.fromJson(Map<String,dynamic> json) => _$WalletDataFromJson(json);
}

@JsonSerializable()
class UserData {
  @JsonKey(name: 'full_name')
  String fullName;
  @JsonKey(name: 'user_email')
  String userEmail;
  @JsonKey(name: 'user_id')
  String userId;
  @JsonKey(name: 'user_phone')
  String userPhone;
  UserData(this.fullName,this.userEmail,this.userId,this.userPhone);
  factory UserData.fromJson(Map<String,dynamic> json) => _$UserDataFromJson(json);
}