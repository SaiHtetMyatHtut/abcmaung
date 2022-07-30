import 'package:json_annotation/json_annotation.dart';
part 'bet_dual.g.dart';
@JsonSerializable()
class ToBet {
  @JsonKey(name: 'user_id')
  String userId;
  List data;
  ToBet({required this.userId,required this.data});
  Map<String,dynamic> toJson() => _$ToBetToJson(this);
}

@JsonSerializable()
class FromBet {
  @JsonKey(name: 'bet_list')
  List betList;
  int balance;
  String message;
  int status;
  FromBet(this.betList,this.balance,this.message,this.status);
  factory FromBet.fromJson(Map<String,dynamic> json) => _$FromBetFromJson(json);
}