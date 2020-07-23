// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'status.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Status _$StatusFromJson(Map<String, dynamic> json) {
  return Status(
    json['id'] as int,
    (json['temperature'] as num)?.toDouble(),
    (json['oxygen'] as num)?.toDouble(),
    (json['weight'] as num)?.toDouble(),
    (json['pressure'] as num)?.toDouble(),
    (json['sugar'] as num)?.toDouble(),
    json['createdDate'] == null
        ? null
        : DateTime.parse(json['createdDate'] as String),
  );
}

Map<String, dynamic> _$StatusToJson(Status instance) => <String, dynamic>{
      'id': instance.id,
      'temperature': instance.temperature,
      'oxygen': instance.oxygen,
      'weight': instance.weight,
      'pressure': instance.pressure,
      'sugar': instance.sugar,
      'createdDate': instance.createdDate?.toIso8601String(),
    };
