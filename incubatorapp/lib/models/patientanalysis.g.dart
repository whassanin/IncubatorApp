// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'patientanalysis.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PatientAnalysis _$PatientAnalysisFromJson(Map<String, dynamic> json) {
  return PatientAnalysis(
    json['id'] as int,
    json['patientId'] as int,
    json['analysisId'] as int,
    json['result'] as String,
    json['createdDate'] == null
        ? null
        : DateTime.parse(json['createdDate'] as String),
  );
}

Map<String, dynamic> _$PatientAnalysisToJson(PatientAnalysis instance) =>
    <String, dynamic>{
      'id': instance.id,
      'patientId': instance.patientId,
      'analysisId': instance.analysisId,
      'result': instance.result,
      'createdDate': instance.createdDate?.toIso8601String(),
    };
