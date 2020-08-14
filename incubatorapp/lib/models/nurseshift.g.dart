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
    json['startDateTime'] == null
        ? null
        : DateTime.parse(json['startDateTime'] as String),
    json['isSignedIn'] as bool,
    json['endDateTime'] == null
        ? null
        : DateTime.parse(json['endDateTime'] as String),
    json['isSignedOut'] as bool,
    json['createdDate'] == null
        ? null
        : DateTime.parse(json['createdDate'] as String),
    json['changedDate'] == null
        ? null
        : DateTime.parse(json['changedDate'] as String),
  );
}

Map<String, dynamic> _$NurseShiftToJson(NurseShift instance) =>
    <String, dynamic>{
      'id': instance.id,
      'nurseId': instance.nurseId,
      'shiftId': instance.shiftId,
      'startDateTime': instance.startDateTime?.toIso8601String(),
      'isSignedIn': instance.isSignedIn,
      'endDateTime': instance.endDateTime?.toIso8601String(),
      'isSignedOut': instance.isSignedOut,
      'createdDate': instance.createdDate?.toIso8601String(),
      'changedDate': instance.changedDate?.toIso8601String(),
    };
