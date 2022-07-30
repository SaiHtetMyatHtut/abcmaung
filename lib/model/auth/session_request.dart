import 'package:json_annotation/json_annotation.dart';

part 'session_request.g.dart';

@JsonSerializable()
class SessionReg {
  @JsonKey(name: 'user_id')
  String userId;
  String token;
  SessionReg(this.userId,this.token);
  Map<String, dynamic> toJson() => _$SessionRegToJson(this);
}