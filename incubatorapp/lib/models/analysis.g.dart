// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'analysis.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Analysis _$AnalysisFromJson(Map<String, dynamic> json) {
  return Analysis(
    json['id'] as int,
    json['name'] as String,
    (json['price'] as num)?.toDouble(),
  );
}

Map<String, dynamic> _$AnalysisToJson(Analysis instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'price': instance.price,
    };
