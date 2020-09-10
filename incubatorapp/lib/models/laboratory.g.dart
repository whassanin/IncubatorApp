// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'laboratory.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Laboratory _$LaboratoryFromJson(Map<String, dynamic> json) {
  return Laboratory(
    json['id'] as int,
    json['name'] as String,
    (json['price'] as num)?.toDouble(),
  );
}

Map<String, dynamic> _$LaboratoryToJson(Laboratory instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'price': instance.price,
    };
