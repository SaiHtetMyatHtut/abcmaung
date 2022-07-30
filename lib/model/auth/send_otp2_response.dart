import 'package:json_annotation/json_annotation.dart';

part 'send_otp2_response.g.dart';

@JsonSerializable()
class Otp2{
  @JsonKey(name: 'status')
  int status;
  @JsonKey(name: 'message')
  String message;
  Otp2(this.status, this.message);
  factory Otp2.fromJson(Map<String,dynamic> json) => _$Otp2FromJson(json);
}