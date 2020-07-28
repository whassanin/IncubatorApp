// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'patient.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Patient _$PatientFromJson(Map<String, dynamic> json) {
  return Patient(
    json['id'] as int,
    json['motherName'] as String,
    json['fatherName'] as String,
    json['gender'] as bool,
    json['dateOfBirth'] == null
        ? null
        : DateTime.parse(json['dateOfBirth'] as String),
    json['address'] as String,
    (json['weight'] as num)?.toDouble(),
    json['ssn'] as String,
    json['conditionId'] as int,
    json['createdDate'] == null
        ? null
        : DateTime.parse(json['createdDate'] as String),
    json['incubatorId'] as int,
    json['patientPhone'] == null
        ? null
        : PatientPhone.fromJson(json['patientPhone'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$PatientToJson(Patient instance) => <String, dynamic>{
      'id': instance.id,
      'motherName': instance.motherName,
      'fatherName': instance.fatherName,
      'gender': instance.gender,
      'dateOfBirth': instance.dateOfBirth?.toIso8601String(),
      'address': instance.address,
      'weight': instance.weight,
      'ssn': instance.ssn,
      'conditionId': instance.conditionId,
      'incubatorId': instance.incubatorId,
      'createdDate': instance.createdDate?.toIso8601String(),
      'patientPhone': instance.patientPhone,
    };
