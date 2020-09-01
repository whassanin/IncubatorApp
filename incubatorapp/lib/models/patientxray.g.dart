// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'patientxray.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PatientXRay _$PatientXRayFromJson(Map<String, dynamic> json) {
  return PatientXRay(
    json['id'] as int,
    json['patientId'] as int,
    json['xRayId'] as int,
    json['comment'] as String,
    json['billStatus'] as String,
    json['createdDate'] == null
        ? null
        : DateTime.parse(json['createdDate'] as String),
  );
}

Map<String, dynamic> _$PatientXRayToJson(PatientXRay instance) =>
    <String, dynamic>{
      'id': instance.id,
      'patientId': instance.patientId,
      'xRayId': instance.xRayId,
      'createdDate': instance.createdDate?.toIso8601String(),
      'comment': instance.comment,
      'billStatus': instance.billStatus,
    };
