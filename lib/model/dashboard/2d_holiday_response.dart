import 'package:json_annotation/json_annotation.dart';

part '2d_holiday_response.g.dart';

@JsonSerializable()
class TwoDHoliday { 
  List<Detail> data;
  TwoDHoliday(this.data);
  factory TwoDHoliday.fromJson(Map<String,dynamic> json) => _$TwoDHolidayFromJson(json);
}

@JsonSerializable()
class Detail {
  String date;
  @JsonKey(name: 'day_left')
  int dayLeft;
  String name;
  Detail(this.date,this.dayLeft,this.name);
  factory Detail.fromJson(Map<String,dynamic> json) => _$DetailFromJson(json);
}