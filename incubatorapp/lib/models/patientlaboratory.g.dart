// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'patientlaboratory.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PatientLaboratory _$PatientLaboratoryFromJson(Map<String, dynamic> json) {
  return PatientLaboratory(
    json['id'] as int,
    json['patientId'] as int,
    json['laboratoryId'] as int,
    json['result'] as String,
    json['createdDate'] == null
        ? null
        : DateTime.parse(json['createdDate'] as String),
  );
}

Map<String, dynamic> _$PatientLaboratoryToJson(PatientLaboratory instance) =>
    <String, dynamic>{
      'id': instance.id,
      'patientId': instance.patientId,
      'laboratoryId': instance.laboratoryId,
      'result': instance.result,
      'createdDate': instance.createdDate?.toIso8601String(),
    };
