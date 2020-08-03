// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'consumable.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Consumable _$ConsumableFromJson(Map<String, dynamic> json) {
  return Consumable(
    json['id'] as int,
    json['name'] as String,
    (json['amount'] as num)?.toDouble(),
    (json['price'] as num)?.toDouble(),
  );
}

Map<String, dynamic> _$ConsumableToJson(Consumable instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'price': instance.price,
      'amount': instance.amount,
    };
