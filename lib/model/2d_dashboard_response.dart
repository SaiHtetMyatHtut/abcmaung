import 'package:json_annotation/json_annotation.dart';
part '2d_dashboard_response.g.dart';

@JsonSerializable()
class DashBoard {
  Data data;
  @JsonKey(name: 'is_close_day')
  bool isCloseDay;
  String message;
  int status;
  Time time;
  DashBoard(this.data,this.isCloseDay,this.message,this.status,this.time);
  factory DashBoard.fromJson(Map<String,dynamic> json) => _$DashBoardFromJson(json);
}

@JsonSerializable()
class Data {
  String set;
  String value;
  String live;
  @JsonKey(name: 'current_date')
  String currentDate;
  @JsonKey(name: 'updated_time')
  String updatedTime;
  @JsonKey(name: 'e_internet')
  String eInternet;
  @JsonKey(name: 'e_modern')
  String eModern;
  @JsonKey(name: 'e_result')
  String eResult;
  @JsonKey(name: 'e_set')
  String eSet;
  @JsonKey(name: 'e_value')
  String eValue;
  @JsonKey(name: 'm_internet')
  String mInternet;
  @JsonKey(name: 'm_modern')
  String mModern;
  @JsonKey(name: 'm_result')
  String mResult;
  @JsonKey(name: 'm_set')
  String mSet;
  @JsonKey(name: 'm_value')
  String mValue;
  Data(this.currentDate,this.eInternet,this.eModern,this.eResult,this.eSet,this.eValue,this.live,this.mInternet,this.mModern,this.mResult,this.mSet,this.mValue,this.set,this.updatedTime,this.value);
  factory Data.fromJson(Map<String,dynamic> json) => _$DataFromJson(json);
}

@JsonSerializable()
class Time {
  String eModernAndInternet;
  String eResult;
  String mModernAndInternet;
  String mResult;
  Time(this.eModernAndInternet,this.eResult,this.mModernAndInternet,this.mResult);
  factory Time.fromJson(Map<String,dynamic> json) => _$TimeFromJson(json);
}