// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'nurseshift.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NurseShift _$NurseShiftFromJson(Map<String, dynamic> json) {
  return NurseShift(
    json['id'] as int,
    json['nurseId'] as int,
    json['shiftId'] as int,
  );
}

Map<String, dynamic> _$NurseShiftToJson(NurseShift instance) =>
    <String, dynamic>{
      'id': instance.id,
      'nurseId': instance.nurseId,
      'shiftId': instance.shiftId,
    };
