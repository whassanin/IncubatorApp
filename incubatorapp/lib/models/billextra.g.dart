// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'billextra.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BillExtra _$BillExtraFromJson(Map<String, dynamic> json) {
  return BillExtra(
    json['id'] as int,
    json['name'] as String,
    (json['cost'] as num)?.toDouble(),
  );
}

Map<String, dynamic> _$BillExtraToJson(BillExtra instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'cost': instance.cost,
    };
