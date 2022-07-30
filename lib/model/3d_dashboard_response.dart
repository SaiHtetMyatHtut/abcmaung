import 'package:json_annotation/json_annotation.dart';

part '3d_dashboard_response.g.dart';

@JsonSerializable()
class Dash3D {
  List<Data> data;
  Dash3D(this.data);
  factory Dash3D.fromJson(Map<String,dynamic> json) => _$Dash3DFromJson(json);
}

@JsonSerializable()
class Data {
  String date;
  String number;
  Data(this.date,this.number);
  factory Data.fromJson(Map<String,dynamic> json) => _$DataFromJson(json);
}