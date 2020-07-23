// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'patientmedicinedoctor.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PatientMedicineDoctor _$PatientMedicineDoctorFromJson(
    Map<String, dynamic> json) {
  return PatientMedicineDoctor(
    json['id'] as int,
    json['consumableId'] as int,
    json['patientId'] as int,
    json['doctorId'] as int,
    json['quantity'] as int,
    json['createDate'] == null
        ? null
        : DateTime.parse(json['createDate'] as String),
  );
}

Map<String, dynamic> _$PatientMedicineDoctorToJson(
        PatientMedicineDoctor instance) =>
    <String, dynamic>{
      'id': instance.id,
      'consumableId': instance.consumableId,
      'patientId': instance.patientId,
      'doctorId': instance.doctorId,
      'quantity': instance.quantity,
      'createDate': instance.createDate?.toIso8601String(),
    };
