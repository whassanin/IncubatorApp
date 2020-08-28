// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'patientmedicinedoctor.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PatientMedicineDoctor _$PatientMedicineDoctorFromJson(
    Map<String, dynamic> json) {
  return PatientMedicineDoctor(
    json['id'] as int,
    json['medicineId'] as int,
    json['patientId'] as int,
    json['doctorId'] as int,
    json['quantity'] as int,
    json['description'] as String,
    json['createdDate'] == null
        ? null
        : DateTime.parse(json['createdDate'] as String),
  );
}

Map<String, dynamic> _$PatientMedicineDoctorToJson(
        PatientMedicineDoctor instance) =>
    <String, dynamic>{
      'id': instance.id,
      'medicineId': instance.medicineId,
      'patientId': instance.patientId,
      'doctorId': instance.doctorId,
      'quantity': instance.quantity,
      'description': instance.description,
      'createdDate': instance.createdDate?.toIso8601String(),
    };
