// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'creditcard.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreditCard _$CreditCardFromJson(Map<String, dynamic> json) {
  return CreditCard(
    json['id'] as int,
    json['holder'] as String,
    json['number'] as String,
    json['expireMonth'] as int,
    json['expireYear'] as int,
    json['patientId'] as int,
    json['createdDate'] == null
        ? null
        : DateTime.parse(json['createdDate'] as String),
  );
}

Map<String, dynamic> _$CreditCardToJson(CreditCard instance) =>
    <String, dynamic>{
      'id': instance.id,
      'holder': instance.holder,
      'number': instance.number,
      'expireYear': instance.expireYear,
      'expireMonth': instance.expireMonth,
      'patientId': instance.patientId,
      'createdDate': instance.createdDate?.toIso8601String(),
    };
