// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'extra.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Extra _$ExtraFromJson(Map<String, dynamic> json) {
  return Extra(
    json['id'] as int,
    json['name'] as String,
    (json['price'] as num)?.toDouble(),
  );
}

Map<String, dynamic> _$ExtraToJson(Extra instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'price': instance.price,
    };
