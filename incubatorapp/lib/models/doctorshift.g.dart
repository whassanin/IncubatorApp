// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'doctorshift.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DoctorShift _$DoctorShiftFromJson(Map<String, dynamic> json) {
  return DoctorShift(
    json['id'] as int,
    json['doctorId'] as int,
    json['shiftId'] as int,
    json['startDateTime'] == null
        ? null
        : DateTime.parse(json['startDateTime'] as String),
    json['endDateTime'] == null
        ? null
        : DateTime.parse(json['endDateTime'] as String),
    json['createdDate'] == null
        ? null
        : DateTime.parse(json['createdDate'] as String),
  );
}

Map<String, dynamic> _$DoctorShiftToJson(DoctorShift instance) =>
    <String, dynamic>{
      'id': instance.id,
      'doctorId': instance.doctorId,
      'shiftId': instance.shiftId,
      'startDateTime': instance.startDateTime?.toIso8601String(),
      'endDateTime': instance.endDateTime?.toIso8601String(),
      'createdDate': instance.createdDate?.toIso8601String(),
    };
