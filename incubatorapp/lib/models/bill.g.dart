// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bill.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Bill _$BillFromJson(Map<String, dynamic> json) {
  return Bill(
    json['id'] as int,
    json['date'] == null ? null : DateTime.parse(json['date'] as String),
    (json['paid'] as num)?.toDouble(),
    (json['dayCost'] as num)?.toDouble(),
    (json['consumable'] as num)?.toDouble(),
    (json['laboratory'] as num)?.toDouble(),
    (json['xRay'] as num)?.toDouble(),
    (json['lightRays'] as num)?.toDouble(),
    (json['medicine'] as num)?.toDouble(),
    (json['extra'] as num)?.toDouble(),
    (json['discount'] as num)?.toDouble(),
    json['patientId'] as int,
  );
}

Map<String, dynamic> _$BillToJson(Bill instance) => <String, dynamic>{
      'id': instance.id,
      'date': instance.createdDate?.toIso8601String(),
      'paid': instance.paid,
      'dayCost': instance.dayCost,
      'consumable': instance.consumable,
      'laboratory': instance.laboratory,
      'xRay': instance.xRay,
      'lightRays': instance.lightRays,
      'medicine': instance.medicine,
      'extra': instance.extra,
      'discount': instance.discount,
      'patientId': instance.patientId,
    };
