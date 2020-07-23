
import 'package:json_annotation/json_annotation.dart';

part 'patientanalysis.g.dart';

@JsonSerializable()

class PatientAnalysis{
  int id;
  int patientId;
  int analysisId;
  String result;
  DateTime createdDate;

  PatientAnalysis(this.id,this.patientId,this.analysisId,this.result,this.createdDate);

  factory PatientAnalysis.fromJson(Map<String, dynamic> json) => _$PatientAnalysisFromJson(json);

  Map<String, dynamic> toJson() => _$PatientAnalysisToJson(this);
}