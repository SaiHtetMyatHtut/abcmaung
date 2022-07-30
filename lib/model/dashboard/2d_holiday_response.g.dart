// GENERATED CODE - DO NOT MODIFY BY HAND

part of '2d_holiday_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TwoDHoliday _$TwoDHolidayFromJson(Map<String, dynamic> json) => TwoDHoliday(
      (json['data'] as List<dynamic>)
          .map((e) => Detail.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$TwoDHolidayToJson(TwoDHoliday instance) =>
    <String, dynamic>{
      'data': instance.data,
    };

Detail _$DetailFromJson(Map<String, dynamic> json) => Detail(
      json['date'] as String,
      json['day_left'] as int,
      json['name'] as String,
    );

Map<String, dynamic> _$DetailToJson(Detail instance) => <String, dynamic>{
      'date': instance.date,
      'day_left': instance.dayLeft,
      'name': instance.name,
    };
