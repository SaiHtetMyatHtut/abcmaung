import 'package:json_annotation/json_annotation.dart';

part 'cashout_both.g.dart';

@JsonSerializable()
class ToCashOut {
  @JsonKey(name:"user_id")
  String userId;
  @JsonKey(name:"transfer_to")
  String transferTo;
  @JsonKey(name:"payment_method")
  String method;
  int amount;
  ToCashOut({required this.userId, required this.transferTo, required this.method, required this.amount});
  Map<String,dynamic> toJson() => _$ToCashOutToJson(this);
}

@JsonSerializable()
class FromCashOut {
  String message;
  int status;
  int amount;
  String date;
  @JsonKey(name: 'transaction_id')
  String tranId;
  FromCashOut(this.message,this.status,this.amount,this.date,this.tranId);
  factory FromCashOut.fromJson( Map<String,dynamic> json )=> _$FromCashOutFromJson(json);
}
