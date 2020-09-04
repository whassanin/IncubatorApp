// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'patientextra.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PatientExtra _$PatientExtraFromJson(Map<String, dynamic> json) {
  return PatientExtra(
    json['id'] as int,
    json['patientId'] as int,
    json['extraId'] as int,
    json['billStatus'] as String,
    json['createdDate'] == null
        ? null
        : DateTime.parse(json['createdDate'] as String),
  );
}

Map<String, dynamic> _$PatientExtraToJson(PatientExtra instance) =>
    <String, dynamic>{
      'id': instance.id,
      'patientId': instance.patientId,
      'extraId': instance.extraId,
      'billStatus': instance.billStatus,
      'createdDate': instance.createdDate?.toIso8601String(),
    };
