import 'package:json_annotation/json_annotation.dart';

part 'bet_record_response.g.dart';

@JsonSerializable()
class BetRecord{
  int status;
  String message;
  @JsonKey(name: 'record_data')
  List<Detail> data;
  BetRecord(this.status,this.message,this.data);
  factory BetRecord.fromJson(Map<String,dynamic> json) => _$BetRecordFromJson(json);
}

@JsonSerializable()
class Detail{
  @JsonKey(name: 'bet_number')
  String number;
  String state;
  @JsonKey(name: 'timestamp')
  String time;
  Detail(this.number,this.state,this.time);
  factory Detail.fromJson(Map<String,dynamic> json) => _$DetailFromJson(json);
}