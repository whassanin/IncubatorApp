// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) {
  return User(
    json['id'] as int,
    json['email'] as String,
    json['password'] as String,
    json['userType'] as String,
    json['provider'] as String,
    json['phone'] as String,
    json['createdDate'] == null
        ? null
        : DateTime.parse(json['createdDate'] as String),
  );
}

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'id': instance.id,
      'userType': instance.userType,
      'email': instance.email,
      'password': instance.password,
      'provider': instance.provider,
      'phone': instance.phone,
      'createdDate': instance.createdDate?.toIso8601String(),
    };
