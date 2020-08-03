// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'medicine.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Medicine _$MedicineFromJson(Map<String, dynamic> json) {
  return Medicine(
    json['id'] as int,
    json['name'] as String,
    (json['amount'] as num)?.toDouble(),
    (json['price'] as num)?.toDouble(),
  );
}

Map<String, dynamic> _$MedicineToJson(Medicine instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'price': instance.price,
      'amount': instance.amount,
    };
