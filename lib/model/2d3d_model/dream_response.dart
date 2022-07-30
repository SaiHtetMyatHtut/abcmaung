import 'package:json_annotation/json_annotation.dart';
part 'dream_response.g.dart';
@JsonSerializable()
class Dream{
  List<DreamDetail> data;
  int start;
  int end;
  int next;
  Dream(this.data,this.start,this.end,this.next);
  factory Dream.fromJson(Map<String,dynamic> json) => _$DreamFromJson(json);
}

@JsonSerializable()
class DreamDetail{
  @JsonKey(name: 'image_url')
  String url;
  @JsonKey(name: 'name')
  String title;
  @JsonKey(name: 'num_1')
  String numL;
  @JsonKey(name: 'num_2')
  String numR;
  DreamDetail(this.url,this.title,this.numL,this.numR);
  factory DreamDetail.fromJson(Map<String,dynamic> json) => _$DreamDetailFromJson(json);
}