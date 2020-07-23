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
    json['createDate'] == null
        ? null
        : DateTime.parse(json['createDate'] as String),
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
      'createDate': instance.createDate?.toIso8601String(),
    };
