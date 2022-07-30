import 'package:json_annotation/json_annotation.dart';

part 'account_record.g.dart';

@JsonSerializable()
class AccountRecord{
  @JsonKey(name: 'record_data')
  List<AccountRecordDetails> data;
  AccountRecord(this.data);
  factory AccountRecord.fromJson(Map<String,dynamic> json) => _$AccountRecordFromJson(json);
}

@JsonSerializable()
class AccountRecordDetails{
  String action;
  int amount;
  @JsonKey(name: 'bet_records')
  List<BetRecords> betRecords;
  String date;
  String id;
  String status;
  AccountRecordDetails(this.amount,this.betRecords,this.date,this.status,this.action,this.id);
  factory AccountRecordDetails.fromJson(Map<String,dynamic> json) => _$AccountRecordDetailsFromJson(json);
}

@JsonSerializable()
class BetRecords{
  @JsonKey(name: 'bet_amount')
  int betAmount;
  @JsonKey(name: 'bet_number')
  String betNumber;
  int rate;
  BetRecords(this.betAmount,this.betNumber,this.rate);
  factory BetRecords.fromJson(Map<String,dynamic> json) => _$BetRecordsFromJson(json);
}