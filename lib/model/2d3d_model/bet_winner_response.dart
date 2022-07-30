import 'package:json_annotation/json_annotation.dart';

part 'bet_winner_response.g.dart';

@JsonSerializable()
class BetWinner{
  int status;
  String message;
  List<BetWinnerDetail> data;
  BetWinner(this.status,this.message,this.data);
  factory BetWinner.fromJson(Map<String,dynamic> json) => _$BetWinnerFromJson(json);
}

@JsonSerializable()
class BetWinnerDetail{
  int bet;
  @JsonKey(name: 'user_name')
  String userName;
  int win;
  BetWinnerDetail(this.bet,this.userName,this.win);
  factory BetWinnerDetail.fromJson(Map<String,dynamic> json) => _$BetWinnerDetailFromJson(json);
}