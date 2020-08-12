// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'doctor.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Doctor _$DoctorFromJson(Map<String, dynamic> json) {
  return Doctor(
    json['id'] as int,
    json['firstName'] as String,
    json['lastName'] as String,
    json['gender'] as bool,
    json['dateOfBirth'] == null
        ? null
        : DateTime.parse(json['dateOfBirth'] as String),
    json['createdDate'] == null
        ? null
        : DateTime.parse(json['createdDate'] as String),
    json['userId'] as int,
  );
}

Map<String, dynamic> _$DoctorToJson(Doctor instance) => <String, dynamic>{
      'id': instance.id,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'gender': instance.gender,
      'dateOfBirth': instance.dateOfBirth?.toIso8601String(),
      'createdDate': instance.createdDate?.toIso8601String(),
      'userId': instance.userId,
    };
