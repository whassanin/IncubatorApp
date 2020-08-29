// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shift.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Shift _$ShiftFromJson(Map<String, dynamic> json) {
  return Shift(
    json['id'] as int,
    json['name'] as String,
    json['startTime'] as int,
    json['isStartTimePM'] as bool,
    json['endTime'] as int,
    json['isEndTimePM'] as bool,
  );
}

Map<String, dynamic> _$ShiftToJson(Shift instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'startTime': instance.startTime,
      'isStartTimePM': instance.isStartTimePM,
      'endTime': instance.endTime,
      'isEndTimePM': instance.isEndTimePM,
    };
