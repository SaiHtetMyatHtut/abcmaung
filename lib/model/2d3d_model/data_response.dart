import 'package:json_annotation/json_annotation.dart';

part 'data_response.g.dart';

@JsonSerializable()
class Data2D {
  List<Details> data;
  @JsonKey(name: 'last_read_time')
  String lastReadTime;
  String message;
  int status;
  Data2D(this.data,this.lastReadTime,this.message,this.status);
  factory Data2D.fromJson(Map<String,dynamic> json) => _$Data2DFromJson(json);
}

@JsonSerializable()
class Details {
  String number;
  double percent;
  @JsonKey(name: 'valid_amount')
  int validAmount;
  Details(this.number,this.percent,this.validAmount);
  factory Details.fromJson(Map<String,dynamic> json) => _$DetailsFromJson(json);
}