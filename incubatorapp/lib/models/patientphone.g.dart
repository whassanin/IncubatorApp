// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'patientphone.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PatientPhone _$PatientPhoneFromJson(Map<String, dynamic> json) {
  return PatientPhone(
    json['id'] as int,
    json['phone'] as String,
    json['patientId'] as int,
  );
}

Map<String, dynamic> _$PatientPhoneToJson(PatientPhone instance) =>
    <String, dynamic>{
      'id': instance.id,
      'phone': instance.phone,
      'patientId': instance.patientId,
    };
