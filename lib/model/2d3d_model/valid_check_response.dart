import 'package:json_annotation/json_annotation.dart';

part 'valid_check_response.g.dart';

@JsonSerializable()
class CheckValid {
  String message;
  int status;
  @JsonKey(name: 'valid_amount')
  int validAmount;
  CheckValid(this.status,this.message,this.validAmount);
  factory CheckValid.fromJson(Map<String,dynamic> json) => _$CheckValidFromJson(json);
}