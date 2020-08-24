// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reportproblem.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReportProblem _$ReportProblemFromJson(Map<String, dynamic> json) {
  return ReportProblem(
    json['id'] as int,
    json['subject'] as String,
    json['body'] as String,
    json['mailTo'] as String,
    json['mailFrom'] as String,
    json['status'] as String,
    json['createdDate'] == null
        ? null
        : DateTime.parse(json['createdDate'] as String),
  );
}

Map<String, dynamic> _$ReportProblemToJson(ReportProblem instance) =>
    <String, dynamic>{
      'id': instance.id,
      'subject': instance.subject,
      'body': instance.body,
      'mailTo': instance.mailTo,
      'mailFrom': instance.mailFrom,
      'status': instance.status,
      'createdDate': instance.createdDate?.toIso8601String(),
    };
