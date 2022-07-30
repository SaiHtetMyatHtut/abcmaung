import 'package:json_annotation/json_annotation.dart';

part 'wallet_record.g.dart';

@JsonSerializable()
class WalletRecord{
  List<Record> history;
  WalletRecord(this.history);
  factory WalletRecord.fromJson(Map<String,dynamic> json) => _$WalletRecordFromJson(json);
}

@JsonSerializable()
class Record{
  String action;
  int amount;
  String date;
  String id;
  String status;
  Record(this.amount,this.date,this.status,this.action,this.id);
  factory Record.fromJson(Map<String,dynamic> json) => _$RecordFromJson(json);
}
