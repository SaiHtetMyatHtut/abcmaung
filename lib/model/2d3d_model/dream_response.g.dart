// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dream_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Dream _$DreamFromJson(Map<String, dynamic> json) => Dream(
      (json['data'] as List<dynamic>)
          .map((e) => DreamDetail.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['start'] as int,
      json['end'] as int,
      json['next'] as int,
    );

Map<String, dynamic> _$DreamToJson(Dream instance) => <String, dynamic>{
      'data': instance.data,
      'start': instance.start,
      'end': instance.end,
      'next': instance.next,
    };

DreamDetail _$DreamDetailFromJson(Map<String, dynamic> json) => DreamDetail(
      json['image_url'] as String,
      json['name'] as String,
      json['num_1'] as String,
      json['num_2'] as String,
    );

Map<String, dynamic> _$DreamDetailToJson(DreamDetail instance) =>
    <String, dynamic>{
      'image_url': instance.url,
      'name': instance.title,
      'num_1': instance.numL,
      'num_2': instance.numR,
    };
