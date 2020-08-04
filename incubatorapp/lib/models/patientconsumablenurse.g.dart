// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'patientconsumablenurse.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PatientConsumableNurse _$PatientConsumableNurseFromJson(
    Map<String, dynamic> json) {
  return PatientConsumableNurse(
    json['id'] as int,
    json['consumableId'] as int,
    json['patientId'] as int,
    json['nurseId'] as int,
    json['quantity'] as int,
    json['createdDate'] == null
        ? null
        : DateTime.parse(json['createdDate'] as String),
  );
}

Map<String, dynamic> _$PatientConsumableNurseToJson(
        PatientConsumableNurse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'consumableId': instance.consumableId,
      'patientId': instance.patientId,
      'nurseId': instance.nurseId,
      'quantity': instance.quantity,
      'createdDate': instance.createdDate?.toIso8601String(),
    };
