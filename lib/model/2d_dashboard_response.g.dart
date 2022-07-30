// GENERATED CODE - DO NOT MODIFY BY HAND

part of '2d_dashboard_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DashBoard _$DashBoardFromJson(Map<String, dynamic> json) => DashBoard(
      Data.fromJson(json['data'] as Map<String, dynamic>),
      json['is_close_day'] as bool,
      json['message'] as String,
      json['status'] as int,
      Time.fromJson(json['time'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$DashBoardToJson(DashBoard instance) => <String, dynamic>{
      'data': instance.data,
      'is_close_day': instance.isCloseDay,
      'message': instance.message,
      'status': instance.status,
      'time': instance.time,
    };

Data _$DataFromJson(Map<String, dynamic> json) => Data(
      json['current_date'] as String,
      json['e_internet'] as String,
      json['e_modern'] as String,
      json['e_result'] as String,
      json['e_set'] as String,
      json['e_value'] as String,
      json['live'] as String,
      json['m_internet'] as String,
      json['m_modern'] as String,
      json['m_result'] as String,
      json['m_set'] as String,
      json['m_value'] as String,
      json['set'] as String,
      json['updated_time'] as String,
      json['value'] as String,
    );

Map<String, dynamic> _$DataToJson(Data instance) => <String, dynamic>{
      'set': instance.set,
      'value': instance.value,
      'live': instance.live,
      'current_date': instance.currentDate,
      'updated_time': instance.updatedTime,
      'e_internet': instance.eInternet,
      'e_modern': instance.eModern,
      'e_result': instance.eResult,
      'e_set': instance.eSet,
      'e_value': instance.eValue,
      'm_internet': instance.mInternet,
      'm_modern': instance.mModern,
      'm_result': instance.mResult,
      'm_set': instance.mSet,
      'm_value': instance.mValue,
    };

Time _$TimeFromJson(Map<String, dynamic> json) => Time(
      json['eModernAndInternet'] as String,
      json['eResult'] as String,
      json['mModernAndInternet'] as String,
      json['mResult'] as String,
    );

Map<String, dynamic> _$TimeToJson(Time instance) => <String, dynamic>{
      'eModernAndInternet': instance.eModernAndInternet,
      'eResult': instance.eResult,
      'mModernAndInternet': instance.mModernAndInternet,
      'mResult': instance.mResult,
    };
