import 'package:json_annotation/json_annotation.dart';

part 'check_phone_response.g.dart';

@JsonSerializable()
class Phone {
  @JsonKey(name: 'status')
  int status;
  Phone(this.status);
  factory Phone.fromJson(Map<String,dynamic> json) => _$PhoneFromJson(json);
}