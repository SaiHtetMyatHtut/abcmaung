import 'package:json_annotation/json_annotation.dart';
part 'bet_confirm_dual.g.dart';
@JsonSerializable()
class ToConfirm {
  @JsonKey(name: 'user_id')
  String userId;
  List<String> number;
  @JsonKey(name: 'game_type')
  String gameType;
  int amount; 
  ToConfirm({required this.userId,required this.number,this.gameType='three_d',required this.amount});
  Map<String,dynamic> toJson()=>_$ToConfirmToJson(this);
}

@JsonSerializable()
class FromConfirm {
  int amount;
  int balance;
  String message;
  @JsonKey(name: 'number_list')
  List<NumberDetail> numberList;
  int status;
  FromConfirm(
    this.amount,
    this.balance,
    this.message,
    this.numberList,
    this.status
  );
  factory FromConfirm.fromJson(Map<String,dynamic> json)=> _$FromConfirmFromJson(json);
}

@JsonSerializable()
class NumberDetail {
  String number;
  double percent;
  @JsonKey(name: 'valid_amount')
  int validAmount;
  NumberDetail({required this.number, required this.percent, required this.validAmount});
  factory NumberDetail.fromJson(Map<String,dynamic> json)=> _$NumberDetailFromJson(json);
}