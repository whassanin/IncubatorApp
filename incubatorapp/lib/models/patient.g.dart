// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'patient.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Patient _$PatientFromJson(Map<String, dynamic> json) {
  return Patient(
    json['userId'] as int,
    json['motherName'] as String,
    json['fatherName'] as String,
    json['gender'] as bool,
    json['dateOfBirth'] == null
        ? null
        : DateTime.parse(json['dateOfBirth'] as String),
    json['address'] as String,
    (json['weight'] as num)?.toDouble(),
    json['ssn'] as String,
    json['state'] as String,
    json['isOnLightRay'] as bool,
    json['createdDate'] == null
        ? null
        : DateTime.parse(json['createdDate'] as String),
    json['conditionId'] as int,
    json['incubatorId'] as int,
    (json['patientanalysis'] as List)
        ?.map((e) => e == null
            ? null
            : PatientAnalysis.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    (json['patientxray'] as List)
        ?.map((e) =>
            e == null ? null : PatientXRay.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    (json['patientmedicinedoctor'] as List)
        ?.map((e) => e == null
            ? null
            : PatientMedicineDoctor.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    (json['patientconsumablenurse'] as List)
        ?.map((e) => e == null
            ? null
            : PatientConsumableNurse.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    (json['patientextra'] as List)
        ?.map((e) =>
            e == null ? null : PatientExtra.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$PatientToJson(Patient instance) => <String, dynamic>{
      'userId': instance.userId,
      'motherName': instance.motherName,
      'fatherName': instance.fatherName,
      'gender': instance.gender,
      'dateOfBirth': instance.dateOfBirth?.toIso8601String(),
      'address': instance.address,
      'weight': instance.weight,
      'ssn': instance.ssn,
      'state': instance.state,
      'createdDate': instance.createdDate?.toIso8601String(),
      'isOnLightRay': instance.isOnLightRay,
      'conditionId': instance.conditionId,
      'incubatorId': instance.incubatorId,
      'patientanalysis': instance.patientAnalysisList,
      'patientxray': instance.patientXRaysList,
      'patientmedicinedoctor': instance.patientMedicineDoctorList,
      'patientconsumablenurse': instance.patientConsumableNurseList,
      'patientextra': instance.patientExtraList,
    };
