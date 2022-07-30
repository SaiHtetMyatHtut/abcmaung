import 'package:json_annotation/json_annotation.dart';

part 'cashin_both.g.dart';

@JsonSerializable()
class ToCashIn {
  @JsonKey(name: 'user_id')
  String userId;
  @JsonKey(name: 'transfer_to')
  String transferTo;
  @JsonKey(name: 'payment_method')
  String paymentMethod;
  @JsonKey(name: 'last_ph_4')
  String lastPh4;
  @JsonKey(name: 'last_tran_6')
  String lastTran6;
  int amount;
  ToCashIn({required this.userId,required this.transferTo,required this.paymentMethod,required this.lastPh4,required this.lastTran6,required this.amount});
  Map<String,dynamic> toJson() => _$ToCashInToJson(this);
}

@JsonSerializable()
class FromCashIn{
  String message;
  int status;
  int amount;
  String date;
  @JsonKey(name: 'transaction_id')
  String tranId;
  FromCashIn(this.message,this.status,this.amount,this.date,this.tranId);
  factory FromCashIn.fromJson( Map<String,dynamic> json )=> _$FromCashInFromJson(json);
}

    