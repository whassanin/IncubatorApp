// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'xray.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

XRay _$XRayFromJson(Map<String, dynamic> json) {
  return XRay(
    json['id'] as int,
    json['name'] as String,
    (json['price'] as num)?.toDouble(),
  );
}

Map<String, dynamic> _$XRayToJson(XRay instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'price': instance.price,
    };
