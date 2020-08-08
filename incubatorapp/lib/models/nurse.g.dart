// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'nurse.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Nurse _$NurseFromJson(Map<String, dynamic> json) {
  return Nurse(
    json['id'] as int,
    json['firstName'] as String,
    json['lastName'] as String,
    json['gender'] as bool,
    json['dateOfBirth'] == null
        ? null
        : DateTime.parse(json['dateOfBirth'] as String),
    json['username'] as String,
    json['password'] as String,
    json['createdDate'] == null
        ? null
        : DateTime.parse(json['createdDate'] as String),
  );
}

Map<String, dynamic> _$NurseToJson(Nurse instance) => <String, dynamic>{
      'id': instance.id,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'gender': instance.gender,
      'dateOfBirth': instance.dateOfBirth?.toIso8601String(),
      'username': instance.username,
      'password': instance.password,
      'createdDate': instance.createdDate?.toIso8601String(),
    };
