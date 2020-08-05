// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'status.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Status _$StatusFromJson(Map<String, dynamic> json) {
  return Status(
    json['id'] as int,
    (json['heartRate'] as num)?.toDouble(),
    (json['pulseRate'] as num)?.toDouble(),
    (json['oxygen'] as num)?.toDouble(),
    (json['weight'] as num)?.toDouble(),
    (json['sugar'] as num)?.toDouble(),
    (json['urine'] as num)?.toDouble(),
    (json['stool'] as num)?.toDouble(),
    (json['bloodPressure'] as num)?.toDouble(),
    (json['temperature'] as num)?.toDouble(),
    (json['incubatorTemperature'] as num)?.toDouble(),
    json['createdDate'] == null
        ? null
        : DateTime.parse(json['createdDate'] as String),
    json['patientId'] as int,
    json['nurseId'] as int,
  );
}

Map<String, dynamic> _$StatusToJson(Status instance) => <String, dynamic>{
      'id': instance.id,
      'heartRate': instance.heartRate,
      'pulseRate': instance.pulseRate,
      'oxygen': instance.oxygen,
      'weight': instance.weight,
      'sugar': instance.sugar,
      'urine': instance.urine,
      'stool': instance.stool,
      'bloodPressure': instance.bloodPressure,
      'temperature': instance.temperature,
      'incubatorTemperature': instance.incubatorTemperature,
      'createdDate': instance.createdDate?.toIso8601String(),
      'patientId': instance.patientId,
      'nurseId': instance.nurseId,
    };
