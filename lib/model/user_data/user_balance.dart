import 'package:json_annotation/json_annotation.dart';

part 'user_balance.g.dart';

@JsonSerializable()
class UserBalance {
  @JsonKey(name: 'balance_data')
  Child balanceData;
  String message;
  int status;
  @JsonKey(name: 'user_id')
  String userId;
  UserBalance(this.balanceData,this.message,this.status,this.userId);
  factory UserBalance.fromJson(Map<String,dynamic> json)=> _$UserBalanceFromJson(json);
}

@JsonSerializable()
class Child {
  @JsonKey(name: 'game_balance')
  int gameBalance;
  @JsonKey(name: 'main_balance')
  int mainBalance;
  @JsonKey(name: 'vip_id')
  int vipId;
  @JsonKey(name: 'walllet_id')
  String wallletId;
  
  Child(this.gameBalance,this.mainBalance,this.vipId,this.wallletId);
  factory Child.fromJson(Map<String,dynamic> json)=> _$ChildFromJson(json);
}

