// GENERATED CODE - DO NOT MODIFY BY HAND

part of '3d_dashboard_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Dash3D _$Dash3DFromJson(Map<String, dynamic> json) => Dash3D(
      (json['data'] as List<dynamic>)
          .map((e) => Data.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$Dash3DToJson(Dash3D instance) => <String, dynamic>{
      'data': instance.data,
    };

Data _$DataFromJson(Map<String, dynamic> json) => Data(
      json['date'] as String,
      json['number'] as String,
    );

Map<String, dynamic> _$DataToJson(Data instance) => <String, dynamic>{
      'date': instance.date,
      'number': instance.number,
    };
