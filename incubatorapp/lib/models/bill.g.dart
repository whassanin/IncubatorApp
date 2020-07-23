// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bill.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Bill _$BillFromJson(Map<String, dynamic> json) {
  return Bill(
    json['id'] as int,
    json['createdDate'] == null
        ? null
        : DateTime.parse(json['createdDate'] as String),
    (json['paid'] as num)?.toDouble(),
    (json['dayCost'] as num)?.toDouble(),
    (json['staying'] as num)?.toDouble(),
    (json['incubatorClean'] as num)?.toDouble(),
    (json['consumable'] as num)?.toDouble(),
    (json['analysis'] as num)?.toDouble(),
    (json['xRay'] as num)?.toDouble(),
    (json['lightRays'] as num)?.toDouble(),
    (json['medicine'] as num)?.toDouble(),
    json['patientId'] as int,
    (json['billExtra'] as List)
        ?.map((e) =>
            e == null ? null : BillExtra.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$BillToJson(Bill instance) => <String, dynamic>{
      'id': instance.id,
      'createdDate': instance.createdDate?.toIso8601String(),
      'paid': instance.paid,
      'dayCost': instance.dayCost,
      'staying': instance.staying,
      'incubatorClean': instance.incubatorClean,
      'consumable': instance.consumable,
      'analysis': instance.analysis,
      'xRay': instance.xRay,
      'lightRays': instance.lightRays,
      'medicine': instance.medicine,
      'patientId': instance.patientId,
      'billExtra': instance.billExtraList,
    };
