import 'package:json_annotation/json_annotation.dart';

part 'send_otp1_response.g.dart';

@JsonSerializable()
class Otp1{
  @JsonKey(name: 'status')
  int status;
  @JsonKey(name: 'request_id')
  int requestId;
  @JsonKey(name: 'message')
  String message;

  // Otp1(this.status,this.message);
  Otp1(this.status, this.requestId, this.message);

  factory Otp1.fromJson(Map<String,dynamic> json) => _$Otp1FromJson(json);
}