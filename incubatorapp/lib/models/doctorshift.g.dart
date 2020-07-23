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
      'createdDate': instance.createdDate?.toIso8601String(),
    };
